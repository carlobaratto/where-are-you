<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;
use App\ApiResource\RegisterPositionElement;
use ApiPlatform\Metadata\Post;
use App\Controller\RegisterPositionController;
use ApiPlatform\Metadata\Link;
use App\Entity\Position;

#[ApiResource(
     operations: [
        new Post(
            uriTemplate: '/positions/register/{group_name}',
            uriVariables: [
                'group_name' => new Link(
                    fromClass: Position::class,
                    fromProperty: 'group'
                )
            ],
            controller: RegisterPositionController::class
        ),
    ]
)]
class RegisterPosition
{
    public RegisterPositionElement $position;
}