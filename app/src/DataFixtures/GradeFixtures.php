<?php

namespace App\DataFixtures;

use App\Entity\Grade;
use App\Entity\Subject;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
use Ramsey\Uuid\Rfc4122\UuidV4;
use Ramsey\Uuid\Uuid;

class GradeFixtures extends Fixture implements DependentFixtureInterface
{
    public const GRADE_REFERENCE = 'grade_';

    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create();

        for ($i = 0; $i < 5; $i++) {
            $grade = new Grade(
                name: $faker->numberBetween(1, 9) . '-' . $faker->randomLetter(),
            );

            $randSubjectsIds = array_rand(range(0, 9), random_int(5, 10));

            foreach ($randSubjectsIds as $randSubjectId) {
                $grade->addSubject(
                    $this->getReference(SubjectFixtures::SUBJECT_REFERENCE . $randSubjectId, Subject::class)
                );
            }

            $manager->persist($grade);

            $this->addReference(self::GRADE_REFERENCE . $i, $grade);
        }

        $manager->flush();
    }

    public function getDependencies(): array
    {
        return [
            SubjectFixtures::class,
        ];
    }
}
