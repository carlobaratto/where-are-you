<?php

namespace App\Controller;

use App\Entity\Position;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Doctrine\ORM\EntityManagerInterface;
use App\ApiResource\PositionRecordResponse;
use App\Repository\PositionRepository;
use App\ApiResource\Positions;
use DateTime;
use Symfony\Component\HttpKernel\KernelInterface;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

#[AsController]
class PositionsController extends AbstractController
{
    public function __construct(
        private PositionRepository $positionRepository,
        private ParameterBagInterface $parameters,
        private EntityManagerInterface $entityManager,
    ) {}

    public function __invoke(string $group_name): Positions
    {
        $max_minutes_to_keep = (int) $_ENV["MAX_MINUTES_TO_KEEP"];
        $positions = $this->positionRepository->findBy(
            ['group_name' => $group_name],
        );

        $response = new Positions();
        $response->group = $group_name;
        foreach ($positions as $position) {
            $positionRecord = new PositionRecordResponse();
            $positionRecord->group = $position->getGroupName();
            $positionRecord->name = $position->getName();
            $positionRecord->lon = $position->getLon();
            $positionRecord->lat = $position->getLat();
            $positionRecord->datetime = $position->getDatetime();

            $lastseen = $position->getDatetime();
            $d1 = new DateTime($lastseen);
            $d2 = new DateTime();
            $interval = $d2->diff($d1);
            $minutes = ($interval->days * 24 * 60) + ($interval->h * 60) + $interval->i;
            $positionRecord->minutes = $minutes;
            
            if ($minutes < 10) {
                $color = 'green';
            } elseif ($minutes >= 10 && $minutes <= 60) {
                $color = 'orange';
            } else {
                $color = 'grey';
            }
            $positionRecord->color = $color;

            // Delete the position from the database
            if ($minutes > $max_minutes_to_keep) {
                $this->entityManager->remove($position);
                $this->entityManager->flush();
            }
        
            $response->positions->add($positionRecord);
        }

        return $response;
    }
}