<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;

class RegisterPositionElement
{
    public string $name = '';

    public float $lat = 0.0;

    public float $lon = 0.0;
}