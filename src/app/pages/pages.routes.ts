import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { CuidadosComponent } from './cuidados/cuidados.component';
import { AlimentosComponent } from './alimentos/alimentos.component';
import { CuestionarioComponent } from './cuestionario/cuestionario.component';
import { RecetasComponent } from './recetas/recetas.component';
import { CuidadoDetalleComponent } from './cuidados/cuidado-detalle/cuidado-detalle.component';
import { CuidadosResolverService } from '../services/cuidados-resolver.service';

export const pagesRoutes: Routes = [
  { 
    path: 'home', 
    component: HomeComponent 
  },
  { 
    path: 'cuidados', 
    component: CuidadosComponent, 
  },
  {
    path: 'cuidado-detalle',
    component: CuidadoDetalleComponent,
    resolve: {
      cuidadoHogar: CuidadosResolverService
    }
  },
  { 
    path: 'cuestionario', 
    component: CuestionarioComponent 
  },
  { 
    path: 'alimentos', 
    component: AlimentosComponent 
  },
  { 
    path: 'recetas', 
    component: RecetasComponent 
  },
  { 
    path: 'usuarios', 
    component: RecetasComponent 
  },
];
