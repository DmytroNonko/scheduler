<?php

namespace App\DataFixtures;

use App\Entity\Weekday;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Ramsey\Uuid\Uuid;

class WeekdayFixtures extends Fixture
{
    private const WEEKDAYS = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
    ];

    public function load(ObjectManager $manager): void
    {
        for ($i = 0; $i < count(self::WEEKDAYS); $i++) {
            $weekday = new Weekday(
                name: self::WEEKDAYS[$i],
            );

            $manager->persist($weekday);
        }

        $manager->flush();
    }
}
