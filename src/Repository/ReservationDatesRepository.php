<?php

namespace App\Repository;

use App\Entity\ReservationDates;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ReservationDates|null find($id, $lockMode = null, $lockVersion = null)
 * @method ReservationDates|null findOneBy(array $criteria, array $orderBy = null)
 * @method ReservationDates[]    findAll()
 * @method ReservationDates[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ReservationDatesRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ReservationDates::class);
    }

    // /**
    //  * @return ReservationDates[] Returns an array of ReservationDates objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('r.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?ReservationDates
    {
        return $this->createQueryBuilder('r')
            ->andWhere('r.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
