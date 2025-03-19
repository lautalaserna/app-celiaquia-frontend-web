import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { CuidadosComponent } from './cuidados/cuidados.component';
import { AlimentosComponent } from './alimentos/alimentos.component';
import { CuestionarioComponent } from './cuestionario/cuestionario.component';
import { RecetasComponent } from './recetas/recetas.component';
import { CuidadoDetalleComponent } from './cuidados/cuidado-detalle/cuidado-detalle.component';
import { CuidadosResolverService } from '../services/cuidados-resolver.service';
import { UsuariosComponent } from './usuarios/usuarios.component';
import { UsuarioDetalleComponent } from './usuarios/usuario-detalle/usuario-detalle.component';
import { CuestionarioResolverService } from '../services/cuestionario-resolver.service';
import { CuestionarioDetalleComponent } from './cuestionario/cuestionario-detalle/cuestionario-detalle.component';
import { UsuariosResolverService } from '../services/usuarios-resolver.service';
import { AlimentoDetalleComponent } from './alimentos/alimento-detalle/alimento-detalle.component';
import { AlimentoResolverService } from '../services/alimento-resolver.service';
import { RecetaResolverService } from '../services/receta-resolver.service';
import { RecetaDetalleComponent } from './recetas/receta-detalle/receta-detalle.component';
import { AdminGuard } from '../utils/guards/admin.guard';
import { PuntoCompraDetalleComponent } from './puntos-compra/punto-compra-detalle/punto-compra-detalle.component';
import { PuntosCompraComponent } from './puntos-compra/puntos-compra.component';
import { PuntosCompraResolverService } from '../services/puntos-compra-resolver.service';
import { EstadisticasComponent } from './estadisticas/estadisticas.component';

export const pagesRoutes: Routes = [
  { 
    path: '', 
    redirectTo: 'home',
    pathMatch: 'full'
  },
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
    path: 'cuestionario-detalle',
    component: CuestionarioDetalleComponent,
    resolve: {
      cuestionario: CuestionarioResolverService
    }
  },
  { 
    path: 'alimentos', 
    component: AlimentosComponent 
  },
  {
    path: 'alimento-detalle',
    component: AlimentoDetalleComponent,
    resolve: {
      alimento: AlimentoResolverService
    }
  },
  { 
    path: 'recetas', 
    component: RecetasComponent 
  },
  {
    path: 'receta-detalle',
    component: RecetaDetalleComponent,
    resolve: {
      receta: RecetaResolverService
    }
  },
  { 
    path: 'puntos-compra', 
    component: PuntosCompraComponent 
  },
  {
    path: 'punto-compra-detalle',
    component: PuntoCompraDetalleComponent,
    resolve: {
      puntoCompra: PuntosCompraResolverService
    }
  },
  { 
    path: 'usuarios', 
    component: UsuariosComponent,
    canActivate: [AdminGuard]
  },
  {
    path: 'usuario-detalle',
    component: UsuarioDetalleComponent,
    canActivate: [AdminGuard],
    resolve: {
      usuario: UsuariosResolverService
    }
  },
  { 
    path: 'estadisticas', 
    component: EstadisticasComponent 
  },
];
