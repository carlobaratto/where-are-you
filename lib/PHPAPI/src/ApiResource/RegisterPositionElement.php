<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;

class RegisterPositionElement
{
    public string $name = '';

    public int $lat = 0;

    public int $lon = 0;
}