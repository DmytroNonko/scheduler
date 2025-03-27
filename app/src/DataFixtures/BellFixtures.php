<?php

namespace App\DataFixtures;

use App\Entity\Bell;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
use Ramsey\Uuid\Uuid;

class BellFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create();

        for ($i = 0; $i < 5; $i++) {
            $bell = new Bell(
                name: $faker->word(),
            );

            $manager->persist($bell);
        }

        $manager->flush();
    }
}
