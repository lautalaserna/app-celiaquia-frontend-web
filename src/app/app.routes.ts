import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { AuthGuard } from './utils/guards/auth.guard';
import { PagesComponent } from './pages/pages.component';
import { LoginComponent } from './login/login.component';
import { pagesRoutes } from './pages/pages.routes';
import { LoginGuard } from './utils/guards/login.guard';

export const routes: Routes = [
  { 
    path: 'login', 
    component: LoginComponent,
    canActivate: [LoginGuard] 
  },
  {
    path: '',
    component: PagesComponent,
    canActivate: [AuthGuard],
    children: pagesRoutes,
  },
  { path: '**', redirectTo: 'home', pathMatch: 'full' },
];
