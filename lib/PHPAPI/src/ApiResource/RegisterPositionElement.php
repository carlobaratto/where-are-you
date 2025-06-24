<?php

namespace App\ApiResource;

use ApiPlatform\Metadata\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Validator\Constraints as Assert;

class RegisterPositionElement
{
    public string $name = '';

    #[Assert\Type("numeric")]
    public string $lat = '';

    #[Assert\Type("numeric")]
    public string $lon = '';
}