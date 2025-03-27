<?php

declare(strict_types=1);

namespace App\Command;

use App\Service\ScheduleService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'schedule:generate',
    description: 'Generate school schedule',
)]
class ScheduleGenerateCommand extends Command
{
    public function __construct(
        private readonly ScheduleService $scheduleService,
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addOption('from', null, InputOption::VALUE_REQUIRED, 'Option description')
            ->addOption('to', null, InputOption::VALUE_REQUIRED, 'Option description')
        ;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);

        $fromDate = new \DateTimeImmutable($input->getOption('from'));
        $toDate = new \DateTime($input->getOption('to'));

        $schedule = $this->scheduleService->generateSchedule($fromDate, $toDate);

        $rows = [];
        foreach ($schedule->getDays() as $day) {
            foreach ($day->getLessons() as $lesson) {
                $rows[] = [
                    $day->getDate()->format('Y-m-d'),
                    $lesson->getBell()->getName(),
                    $lesson->getGrade()->getName(),
                    $lesson->getSubject()->getName(),
                    $lesson->getSubject()->getTeacher()->getName(),
                ];
            }
        }

        $io->table(
            [
                'date', 'lesson', 'grade', 'subject', 'teacher',
            ],
            $rows
        );

        return Command::SUCCESS;
    }
}
