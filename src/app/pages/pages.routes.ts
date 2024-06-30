import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { CuidadosComponent } from './cuidados/cuidados.component';
import { AlimentosComponent } from './alimentos/alimentos.component';
import { CuestionarioComponent } from './cuestionario/cuestionario.component';
import { RecetasComponent } from './recetas/recetas.component';

export const pagesRoutes: Routes = [
  { path: 'home', component: HomeComponent },
  { path: 'cuidados', component: CuidadosComponent },
  { path: 'cuestionario', component: CuestionarioComponent },
  { path: 'alimentos', component: AlimentosComponent },
  { path: 'recetas', component: RecetasComponent },
];
