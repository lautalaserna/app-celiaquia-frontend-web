import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';
import { map, Observable, of } from 'rxjs';
import { Usuario } from '../interfaces/user';
import { AdminService } from './admin.service';

@Injectable({
  providedIn: 'root'
})
export class UsuariosResolverService {
  usuario: Usuario | undefined;

  constructor(private _adminService: AdminService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<Usuario> {
    const id = Number(route.queryParamMap.get('id'));

    if (id) {
      return this._adminService.getUsuario(id).pipe(
        map(response => response.data)
      );
    }
      
    return of (new Usuario());
  }
}
