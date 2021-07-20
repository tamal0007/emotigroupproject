<?php

namespace App\Controller;

use App\Entity\Reservations;
use App\Entity\ReservationDates;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\classes\Calender_;
use Symfony\Component\Security\Core\Security;
use App\Repository\RoomsRepository;

class FrontController extends AbstractController {

    /**
     * @Route("/front", name="front")
     */
    public function index(Request $request, RoomsRepository $rooms_repository): Response {


        $total_days_in_month = cal_days_in_month(CAL_GREGORIAN, date('m'), date('Y'));

        $first_date_of_month = date('Y') . "-" . date('m') . "-01";
        $last_date_of_month = date('Y') . "-" . date('m') . "-" . $total_days_in_month;


        $em = $this->getDoctrine()->getManager();
        $conn = $em->getConnection();

        $sql = "
            SELECT reservation_date,count(room_id) as occupied_room_count,(select count(id) as total_rooms from rooms where is_active = 1) as total_rooms FROM reservation_dates 
            where 
            reservation_date between :start_date and :end_date
            group by reservation_date
            
            ";
        $stmt = $conn->prepare($sql);
        $stmt->execute(['start_date' => $first_date_of_month, 'end_date' => $last_date_of_month]);
        $query_reserved_dates = $stmt->fetchAllAssociative();

        $room = $rooms_repository->findBy(['isActive' => 1,]);
        
        $date_wise_vac_occupied = [];
        
        array_walk($query_reserved_dates, function($val,$key) use(&$date_wise_vac_occupied){
            $date_wise_vac_occupied [$val['reservation_date']] = [
                                                                    'occupied_room_count' => $val['occupied_room_count'],
                                                                    'total_rooms' => $val['total_rooms']
                                                                ];
        });
        

        $calendar = new Calender_($date_wise_vac_occupied,count($room));


        return $this->render('front/front_home.html.twig', ['calender' => $calendar, 'loggedin_stat' => $this->isGranted('ROLE_USER')]);
    }

    /**
     * @Route("/confirmvacancy", name="confirmvacancy")
     */
    public function confirmvacancy(Request $request, RoomsRepository $rooms_repository): Response {

        $message = '';

        $room_id = $request->get('vac_id');
        $start_date = $request->get('start_date');
        $end_date = $request->get('end_date');


        if (strtotime($start_date) < strtotime(date('Y-m-d')) || strtotime($end_date) < strtotime(date('Y-m-d')) || strtotime($end_date) < strtotime($start_date)) {
            $message = 'Sorry! You have selected Invalid date!! Please select a correct date range';
        } else {


            //.... logged in user object
            $user = $this->get('security.token_storage')->getToken()->getUser();
            $user_id = $user->getId();

            //....entity manager
            $em = $this->getDoctrine()->getManager();
            $conn = $em->getConnection();

            //.... query through repository
            $room = $rooms_repository->findOneBy(['id' => $room_id, 'isActive' => 1,]); // if room is active

            $qb = $em->createQueryBuilder();
            $qb->select('count(*)');

            $sql = "
            select room_id from reservation_dates
                where
                reservation_date between :start_date and :end_date
                and
                room_id = :room_id
            ";
            $stmt = $conn->prepare($sql);

            $stmt->execute(['start_date' => $start_date, 'end_date' => $end_date, 'room_id' => $room_id]);

            // returns an array of arrays (i.e. a raw data set)
            $room_search_result = $stmt->fetchAllAssociative();

            if ($room && count($room_search_result) <= 0) {

                $room_price = $room->getPrice();
                $customer_id = $user_id;

                $total_dates = $this->date_array($start_date, $end_date);
                $total_days = count($total_dates);
                $total_bill = $total_days * $room_price;


                //....insert into reservation table
                $reservation = new Reservations();
                $reservation->setCustomerId($customer_id)
                        ->setFromDate(\DateTime::createFromFormat('Y-m-d', $start_date))
                        ->setToDate(\DateTime::createFromFormat('Y-m-d', $end_date))
                        ->setTotalBill($total_bill);

                $em->persist($reservation);
                $em->flush();

                $reservation_id = $reservation->getId();

                foreach ($total_dates as $date) {

                    //..... book room
                    $reservation_dates = new ReservationDates();
                    $reservation_dates->setReservationId($reservation_id)
                            ->setRoomId($room_id)
                            ->setReservationDate(\DateTime::createFromFormat('Y-m-d', $date))
                            ->setPrice($room_price)
                            ->setCreatedBy($user_id)
                            ->setReservationId($reservation_id);
                    $em->persist($reservation_dates);
                }
                $em->flush();

                $message = "Success! Your room name/number is <b>".$room->getName()."</b> , booked from " . $start_date . " to " . $end_date
                        . " ( " . $total_days . " ) day(s) ( @ $" . $room_price . ") . Total cost is $" . $total_bill . " .";
            } else {
                $message = "Error! Some days already booked! Please another date range.";
            }
        }
        return $this->render('front/book_room.html.twig', ['message' => $message]);
    }

    /**
     * @Route("/logins", name="logins")
     */
    public function loginss(Request $request): Response {
        return $this->render('login.html.twig');
    }

    /**
     * @Route("/registers", name="registers")
     */
    public function registersss(Request $request): Response {
        $conn = $this->getDoctrine()->getManager()->getConnection();

        $sql = '
            SELECT * FROM product p
            WHERE p.price > :price
            ORDER BY p.price ASC
            ';
        $stmt = $conn->prepare($sql);
        $stmt->execute(['price' => $price]);

        // returns an array of arrays (i.e. a raw data set)
        return $stmt->fetchAllAssociative();
        return $this->render('register.html.twig');
    }

    /**
     * @Route("/search", name="search")
     */
    public function vacancy_search(Request $request): Response {

        $dates = explode('-', $request->get('dates'));

        $start_date = date('Y-m-d', strtotime(trim($dates[0])));
        $end_date = date('Y-m-d', strtotime(trim($dates[1])));

        $em = $this->getDoctrine()->getManager();
        $conn = $em->getConnection();

        $sql = "
            SELECT * FROM rooms 
            where 
            id not in 
            (
                select room_id from reservation_dates 
                where reservation_date between :start_date and :end_date 
                group by room_id
            )
            and is_active = 1
            order by id asc
            ";
        $stmt = $conn->prepare($sql);

        $stmt->execute(['start_date' => $start_date, 'end_date' => $end_date]);

        // returns an array of arrays (i.e. a raw data set)
        $room_search_result = $stmt->fetchAllAssociative();


        return $this->render('front/room_search_result.html.twig', ['room_search_result' => $room_search_result, 'start_date' => $start_date, 'end_date' => $end_date, 'loggedin_stat' => $this->isGranted('ROLE_USER')]);
    }

    private function date_array($date1, $date2, $format = 'Y-m-d') {
        $dates = array();
        $current = strtotime($date1);
        $date2 = strtotime($date2);
        $stepVal = '+1 day';
        while ($current <= $date2) {
            $dates[] = date($format, $current);
            $current = strtotime($stepVal, $current);
        }
        return $dates;
    }

}
