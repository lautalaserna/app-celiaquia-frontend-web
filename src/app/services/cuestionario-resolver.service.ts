import { Injectable } from '@angular/core';
import { Cuestionario } from '../interfaces/cuestionario';
import { CuestionarioService } from './cuestionario.service';
import { ActivatedRouteSnapshot } from '@angular/router';
import { map, Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CuestionarioResolverService {
  usuario: Cuestionario | undefined;

  constructor(private _cuestionarioService: CuestionarioService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<Cuestionario> {
    const id = Number(route.queryParamMap.get('id'));

    if (id) {
      return this._cuestionarioService.getCuestionario(id).pipe(
        map(response => response.data)
      );
    }
      
    return of (new Cuestionario());
  }
}
