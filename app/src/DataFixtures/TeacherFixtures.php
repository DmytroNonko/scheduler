<?php

namespace App\DataFixtures;

use App\Entity\Teacher;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class TeacherFixtures extends Fixture
{
    public const TEACHER_REFERENCE = 'teacher_';

    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create();

        for ($i = 0; $i < 10; $i++) {
            $teacher = new Teacher(
                name: $faker->name(),
            );

            $manager->persist($teacher);

            $this->addReference(self::TEACHER_REFERENCE . $i, $teacher);
        }

        $manager->flush();
    }
}
