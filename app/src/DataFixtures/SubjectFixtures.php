<?php

namespace App\DataFixtures;

use App\Entity\Subject;
use App\Entity\Teacher;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
use Ramsey\Uuid\Uuid;

class SubjectFixtures extends Fixture implements DependentFixtureInterface
{
    public const SUBJECT_REFERENCE = 'subject_';

    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create();

        for ($i = 0; $i < 10; $i++) {
            $subject = new Subject(
                name: $faker->word(),
                teacher: $this->getReference(TeacherFixtures::TEACHER_REFERENCE . $i, Teacher::class),
            );

            $manager->persist($subject);

            $this->addReference(self::SUBJECT_REFERENCE . $i, $subject);
        }

        $manager->flush();
    }

    public function getDependencies(): array
    {
        return [
            TeacherFixtures::class,
        ];
    }
}
