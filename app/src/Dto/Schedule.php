<?php

declare(strict_types=1);

namespace App\Dto;

class Schedule
{
    private array $days = [];

    public function addDay(ScheduleDay $day): void
    {
        $this->days[] = $day;
    }

    /**
     * @return ScheduleDay[]
     */
    public function getDays(): array
    {
        return $this->days;
    }
}
