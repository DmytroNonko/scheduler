<?php

declare(strict_types=1);

namespace App\Repository;

use App\Entity\Curriculum;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Curriculum>
 */
class CurriculumRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Curriculum::class);
    }
}
