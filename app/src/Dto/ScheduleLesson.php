<?php

declare(strict_types=1);

namespace App\Dto;

use App\Entity\Bell;
use App\Entity\Grade;
use App\Entity\Subject;

class ScheduleLesson
{
    public function __construct(
        private readonly Bell $bell,
        private readonly Grade $grade,
        private readonly Subject $subject,
    ) {
    }

    public function getBell(): Bell
    {
        return $this->bell;
    }

    public function getGrade(): Grade
    {
        return $this->grade;
    }

    public function getSubject(): Subject
    {
        return $this->subject;
    }
}
