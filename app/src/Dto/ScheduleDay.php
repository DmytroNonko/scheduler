<?php

declare(strict_types=1);

namespace App\Dto;

class ScheduleDay
{
    private array $lessons = [];

    public function __construct(
        private \DateTimeInterface $date,
    ) {
    }

    public function getDate(): \DateTimeInterface
    {
        return $this->date;
    }

    public function addLesson(ScheduleLesson $lesson): void
    {
        $this->lessons[] = $lesson;
    }

    /**
     * @return ScheduleLesson[]
     */
    public function getLessons(): array
    {
        return $this->lessons;
    }
}
