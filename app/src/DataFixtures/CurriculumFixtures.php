<?php

namespace App\DataFixtures;

use App\Entity\Curriculum;
use App\Entity\Grade;
use App\Entity\Subject;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
use Ramsey\Uuid\Uuid;

class CurriculumFixtures extends Fixture implements DependentFixtureInterface
{
    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create();
        for ($gradeNumber = 0; $gradeNumber < 5; $gradeNumber++) {
            $grade = $this->getReference(GradeFixtures::GRADE_REFERENCE . $gradeNumber, Grade::class);
            foreach ($grade->getSubjects()->toArray() as $subject) {
                $curriculum = new Curriculum(
                    grade: $grade,
                    subject: $subject,
                    hours: $faker->numberBetween(10, 15),
                );

                $manager->persist($curriculum);
            }
        }

        $manager->flush();
    }

    public function getDependencies(): array
    {
        return [
            GradeFixtures::class,
            SubjectFixtures::class,
        ];
    }
}
