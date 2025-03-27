<?php

namespace App\Service\Contract;

use App\Dto\Schedule;

interface ScheduleServiceInterface
{
    public function generateSchedule(\DateTimeImmutable $forDate, \DateTime $toDate): Schedule;
}
