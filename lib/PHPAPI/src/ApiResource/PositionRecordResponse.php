<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;

class PositionRecordResponse
{
    public string $group = '';

    public string $name = '';

    public string $datetime = '';

    public int $lat = 0;

    public int $lon = 0;

    public int $minutes = 0;

    public string $color = '';
}