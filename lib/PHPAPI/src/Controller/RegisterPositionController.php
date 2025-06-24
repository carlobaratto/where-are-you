<?php

namespace App\Controller;

use App\Entity\Position;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpKernel\Attribute\AsController;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use App\ApiResource\RegisterPositionElement;
use App\ApiResource\RegisterPosition;

#[AsController]
class RegisterPositionController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    public function __invoke(string $group_name, RegisterPosition $request): JsonResponse
    {
        $position = $request->position;
        $name = mb_ereg_replace("([^\w\s\d\-_~,;$$$$$$.])", '', $position->name);

        $positionRecord = new Position();
        $positionRecord->setGroupName($group_name);
        $positionRecord->setName($name);
        $positionRecord->setLon($position->lon);
        $positionRecord->setLat($position->lat);
        $positionRecord->setDatetime(date("Y-m-d H:i:s"));

        $this->entityManager->persist($positionRecord);
        $this->entityManager->flush();

        return new JsonResponse([], Response::HTTP_OK);
    }
}