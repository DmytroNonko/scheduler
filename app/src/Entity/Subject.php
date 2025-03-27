<?php

declare(strict_types=1);

namespace App\Entity;

use App\Repository\SubjectRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Ramsey\Uuid\UuidInterface;

#[ORM\Entity(repositoryClass: SubjectRepository::class)]
class Subject
{
    #[ORM\Id]
    #[ORM\Column(type: 'uuid', unique: true)]
    #[ORM\GeneratedValue(strategy: 'CUSTOM')]
    #[ORM\CustomIdGenerator(class: 'Ramsey\Uuid\Doctrine\UuidGenerator')]
    private UuidInterface $id;

    #[ORM\ManyToMany(targetEntity: Subject::class, mappedBy: 'subjects')]
    private Collection $grades;

    public function __construct(
        #[ORM\Column(length: 50)]
        private string $name,

        #[ORM\OneToOne(targetEntity: Teacher::class, inversedBy: 'subject')]
        #[ORM\JoinColumn(name: 'teacher_id', referencedColumnName: 'id')]
        private Teacher $teacher,
    ) {
        $this->grades = new ArrayCollection();
    }

    public function getId(): UuidInterface
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getTeacher(): ?Teacher
    {
        return $this->teacher;
    }

    public function getGrades(): Collection
    {
        return $this->grades;
    }
}
