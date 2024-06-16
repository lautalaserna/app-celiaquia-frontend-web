import { CanActivateFn, Router } from '@angular/router';

export const authGuard: CanActivateFn = (route, state) => {
  const router:Router = new Router();
  const token = localStorage.getItem('token')
  
  if(token == undefined) {
    router.navigate(['/login'])
    return false
  }

  return true;
};
