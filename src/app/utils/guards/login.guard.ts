import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { UserService } from '../../services/user.service';

export const LoginGuard: CanActivateFn = (route, state) => {
  const _userService = inject(UserService);
  const router = inject(Router);

  if (_userService.getUserData()) {
    router.navigate(['/home']);
    return false;
  }

  return true;
};
