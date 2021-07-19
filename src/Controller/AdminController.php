<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Reservations;
use App\Entity\ReservationDates;
use Symfony\Component\HttpFoundation\Request;
use App\classes\Calender_;
use App\Repository\RoomsRepository;
use App\Repository\UserRepository;

class AdminController extends AbstractController {

    /**
     * @Route("/admin", name="admin")
     */
    public function index(Request $request, RoomsRepository $rooms_repository,UserRepository $user_repository): Response {
        $em = $this->getDoctrine()->getManager();
        $conn = $em->getConnection();

        //echo date('');
        $todays_sales = '';
        $calendar = '';
        $todays_total_empty_rooms = '';
        $total_rooms = '';


        /* total active users [start] */
        
        $total_customer_sql = "
                SELECT *  FROM user 
                WHERE 
                JSON_CONTAINS(roles, '\"ROLE_USER\"')
                ";

        $stmt_total_customer = $conn->prepare($total_customer_sql);
        $stmt_total_customer->execute();
        $query_total_customer = $stmt_total_customer->fetchAllAssociative();
//        $total_customer = $query_total_customer[0]['total_rooms'];
         //dump($query_total_customer);exit;
        //$user_repository = $user_repository->findBy(['isActive' => 1,]);
        /* total active users [end] */
        
        
        /* total active room count [end] */

        /*get all active rooms[start]*/
        $total_rooms = $rooms_repository->findBy(['isActive' => 1,]);
        /*get all active rooms[end]*/
        
        
        /* todays total empty room count [start] */
        $todays_total_empty_rooms_sql = "
            SELECT count(*) as total_free_rooms FROM rooms 
            where 
            id not in 
            (
                select room_id from reservation_dates 
                where reservation_date = :todays_date
                group by room_id
            )
            and is_active = 1
            order by id asc
            limit 1
            ";

        $stmt_todays_total_empty_rooms = $conn->prepare($todays_total_empty_rooms_sql);
        $stmt_todays_total_empty_rooms->execute(['todays_date' => date('Y-m-d')]);
        $query_todays_total_empty_rooms = $stmt_todays_total_empty_rooms->fetchAllAssociative();
        $todays_total_empty_rooms = $query_todays_total_empty_rooms[0]['total_free_rooms'];

        /* todays total empty room count [end] */

        /* calendar and full booked dates [start] */
        $total_days_in_month = cal_days_in_month(CAL_GREGORIAN, date('m'), date('Y'));

        $first_date_of_month = date('Y') . "-" . date('m') . "-01";
        $last_date_of_month = date('Y') . "-" . date('m') . "-" . $total_days_in_month;



        $sql = "
            SELECT reservation_date,count(room_id) as occupied_room_count,(select count(id) as total_rooms from rooms where is_active = 1) as total_rooms FROM reservation_dates 
            where 
            reservation_date between :start_date and :end_date
            group by reservation_date
            ";
        $stmt = $conn->prepare($sql);
        $stmt->execute(['start_date' => $first_date_of_month, 'end_date' => $last_date_of_month]);
        $query_reserved_dates = $stmt->fetchAllAssociative();

        /*
          $date_extractor = function($array) {
          return end($array);
          };
          $full_reserved_dates = array_map($date_extractor, $query_reserved_dates);
         */
        $date_wise_vac_occupied = [];

        array_walk($query_reserved_dates, function($val, $key) use(&$date_wise_vac_occupied) {
            $date_wise_vac_occupied [$val['reservation_date']] = [
                'occupied_room_count' => $val['occupied_room_count'],
                'total_rooms' => $val['total_rooms']
            ];
        });
        $calendar = new Calender_($date_wise_vac_occupied, count($total_rooms));
        /* calendar and full booked dates [end] */

        $all_customer = '';

        return $this->render(
                        'admin/dashboard.html.twig', ['calender' => $calendar,
                    'todays_sales' => $todays_sales,
                    'todays_total_empty_rooms' => $todays_total_empty_rooms,
                    'total_rooms' => count($total_rooms),
                    'loggedin_stat' => $this->isGranted('ROLE_USER'),
                    'total_customers' => $query_total_customer,
        ]);
    }

    /**
     * @Route("/admin/booking", name="admin_booking")
     */
    public function booking(Request $request): Response {
        $message = '';

        $dates = explode('-', $request->get('dates'));
        $customer_id = $request->get('customer_id');

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
            limit 1
            ";
        $stmt = $conn->prepare($sql);

        $stmt->execute(['start_date' => $start_date, 'end_date' => $end_date]);

        // returns an array of arrays (i.e. a raw data set)
        $result = $stmt->fetchAllAssociative();
        //echo "<pre>";

        $room_id = $result[0]['id'];
        $room_price = $result[0]['price'];
        $user_id = 1;
        

        $total_dates = $this->date_array($start_date, $end_date);
        $total_days = count($total_dates);
        $total_bill = $total_days * $room_price;

        if (count($result) > 0) {

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

            $message = "Success! Your room booked from " . $start_date . " to " . $end_date
                    . " ( " . $total_days . " ) days ( @ $" . $room_price . ") . Total cost is $" . $total_bill . " .";
        } else {
            $message = "Error! Some days already booked! Please another date range.";
        }
        return $this->render('admin/book_room.html.twig', ['message' => $message,'loggedin_stat' => $this->isGranted('ROLE_USER'),]);
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
