<?php

declare(strict_types=1);

namespace App\Entity;

use App\Repository\CurriculumRepository;
use Doctrine\ORM\Mapping as ORM;
use Ramsey\Uuid\UuidInterface;

#[ORM\Entity(repositoryClass: CurriculumRepository::class)]
class Curriculum
{
    #[ORM\Id]
    #[ORM\Column(type: 'uuid', unique: true)]
    #[ORM\GeneratedValue(strategy: 'CUSTOM')]
    #[ORM\CustomIdGenerator(class: 'Ramsey\Uuid\Doctrine\UuidGenerator')]
    private UuidInterface $id;

    public function __construct(
        #[ORM\ManyToOne(targetEntity: Grade::class)]
        #[ORM\JoinColumn(name: 'grade_id', referencedColumnName: 'id')]
        private readonly Grade $grade,

        #[ORM\ManyToOne(targetEntity: Subject::class)]
        #[ORM\JoinColumn(name: 'subject_id', referencedColumnName: 'id')]
        private readonly Subject $subject,

        #[ORM\Column]
        private int $hours,
    ) {
    }

    public function getId(): UuidInterface
    {
        return $this->id;
    }

    public function getGrade(): Grade
    {
        return $this->grade;
    }

    public function setGrade(Grade $grade): void
    {
        $this->grade = $grade;
    }

    public function getSubject(): Subject
    {
        return $this->subject;
    }

    public function setSubject(Subject $subject): static
    {
        $this->subject = $subject;

        return $this;
    }

    public function getHours(): int
    {
        return $this->hours;
    }

    public function setHours(int $hours): static
    {
        $this->hours = $hours;

        return $this;
    }
}
