<?php
namespace App\Security;

use App\Repository\AccessTokenRepository;
use Symfony\Component\Security\Core\Exception\BadCredentialsException;
use Symfony\Component\Security\Http\AccessToken\AccessTokenHandlerInterface;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\UserProviderInterface;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;

class User implements UserInterface
{   
    public function __construct(private string $identifier)
    {
    }
    
    public function getUserIdentifier(): string
    {
        return $this->identifier;
    }
    
    public function getRoles(): array
    {
        return [];
    }

    public function getPassword(): ?string
    {
    }

    public function eraseCredentials(): void
    {
    }

    public function equals(UserInterface $user)
    {
    }
}
