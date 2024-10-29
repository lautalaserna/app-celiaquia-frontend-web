import { CanActivateFn, Router } from '@angular/router';
import { UserRoles, UserService } from '../../services/user.service';
import { HttpClient } from '@angular/common/http';
import { inject } from '@angular/core';

export const AdminGuard: CanActivateFn = (route, state) => {
  const _userService = inject(UserService);
  const router = inject(Router);
  
  const user = _userService.getUserData();

  if (user && _userService.validateRoles([UserRoles.ROL_ADMIN])) {
    return true;
  }

  router.navigate(['/home']);
  return false; 
};
