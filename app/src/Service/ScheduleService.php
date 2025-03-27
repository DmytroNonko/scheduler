<?php

declare(strict_types=1);

namespace App\Service;

use App\Dto\Schedule;
use App\Dto\ScheduleDay;
use App\Dto\ScheduleLesson;
use App\Entity\Bell;
use App\Entity\Curriculum;
use App\Entity\Grade;
use App\Entity\Teacher;
use App\Repository\BellRepository;
use App\Repository\CurriculumRepository;
use App\Repository\GradeRepository;
use App\Service\Contract\ScheduleServiceInterface;

class ScheduleService implements ScheduleServiceInterface
{
    private $curriculumList = [];
    private $teacherBusy = [];

    public function __construct(
        private readonly GradeRepository $gradeRepository,
        private readonly CurriculumRepository $curriculumRepository,
        private readonly BellRepository $bellRepository,
    ) {
    }

    public function generateSchedule(\DateTimeImmutable $forDate, \DateTime $toDate): Schedule
    {
        $schedule = new Schedule();

        while ($forDate->diff($toDate)->days > 0) {
            if ($forDate->format('N') > 5) {
                $forDate = $forDate->modify('+1 day');
                // weekend
                continue;
            }

            $scheduleDay = $this->daySchedule($forDate);
            $schedule->addDay($scheduleDay);
            $forDate = $forDate->modify('+1 day');
        }

        return $schedule;
    }

    private function daySchedule(\DateTimeInterface $date): ScheduleDay
    {
        $scheduleDay = new ScheduleDay($date);
        $grades = $this->gradeRepository->findAll();

        foreach ($grades as $grade) {
            $this->gradeSchedule($scheduleDay, $grade);
        }

        return $scheduleDay;
    }

    private function gradeSchedule(ScheduleDay $day, Grade $grade): void
    {
        $bells = $this->bellRepository->findAll();
        $bellNumber = 0;

        foreach ($this->getGradeCurriculum($grade) as $curriculum) {
            $bell = $bells[$bellNumber] ?? null;
            if (!$bell) {
                break;
            }

            if ($this->isTeacherBusy($day, $curriculum->getSubject()->getTeacher(), $bell)) {
                continue;
            }

            $day->addLesson(
                new ScheduleLesson(
                    bell: $bell,
                    grade: $grade,
                    subject: $curriculum->getSubject(),
                )
            );

            $this->teacherBusy[] = sprintf(
                '%s.%s.%s',
                $day->getDate()->format('Y-m-d'),
                $curriculum->getSubject()->getTeacher()->getName(),
                $bell->getId(),
            );

            $curriculum->setHours($curriculum->getHours() - 1);
            $bellNumber++;
        }
    }

    private function isTeacherBusy(ScheduleDay $day, Teacher $teacher, Bell $bell): bool
    {
        $key = sprintf(
            '%s.%s.%s',
            $day->getDate()->format('Y-m-d'),
            $teacher->getId(),
            $bell->getId(),
        );

        return in_array($key, $this->teacherBusy);
    }

    /**
     * @return iterable|Curriculum[]
     */
    private function getGradeCurriculum(Grade $grade): Iterable
    {
        $curriculum = $this->curriculumList[$grade->getId()->toString()] ?? null;
        if (!$curriculum) {
            $curriculum = $this->curriculumRepository->findBy([
                'grade' => $grade,
            ]);
            $this->curriculumList[$grade->getId()->toString()] = $curriculum;
        }

        $filtered = array_values(
            array_filter(
                $curriculum,
                fn (Curriculum $curriculum) => $curriculum->getHours() > 0,
            )
        );

        foreach ($filtered as $item) {
            yield $item;
        }
    }
}
