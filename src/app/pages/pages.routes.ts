import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { CuidadosComponent } from './cuidados/cuidados.component';

export const pagesRoutes: Routes = [
  { path: 'home', component: HomeComponent },
  { path: 'cuidados', component: CuidadosComponent },
];
