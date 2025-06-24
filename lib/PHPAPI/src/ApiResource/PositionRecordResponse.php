<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Validator\Constraints as Assert;

class PositionRecordResponse
{
    public string $group = '';

    public string $name = '';

    public string $datetime = '';

    #[Assert\Type("numeric")]
    public string $lat = '';

    #[Assert\Type("numeric")]
    public string $lon = '';

    public int $minutes = 0;

    public string $color = '';
}