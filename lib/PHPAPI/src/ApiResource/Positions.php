<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;
use App\ApiResource\PositionRecordResponse;
use ApiPlatform\Metadata\Get;
use App\Controller\PositionsController;
use App\Entity\Position;

#[ApiResource(
     operations: [
        new Get(
            uriTemplate: '/positions/{group_name}',
            controller: PositionsController::class,
            read: false,
        ),
    ]
)]
class Positions
{
    public string $group;

    /** @var PositionRecordResponse[] */
    public iterable $positions;

    public function __construct()
    {
        $this->positions = new ArrayCollection();
    }
}