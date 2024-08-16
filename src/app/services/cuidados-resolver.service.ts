import { Injectable } from '@angular/core';
import { CuidadosService } from './cuidados.service';
import { ActivatedRouteSnapshot } from '@angular/router';
import { map, Observable, of } from 'rxjs';
import { CuidadoHogar } from '../interfaces/cuidados';

@Injectable({
  providedIn: 'root'
})
export class CuidadosResolverService {
  cuidado: CuidadoHogar | undefined;

  constructor(private _cuidadosService: CuidadosService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<CuidadoHogar> {
    const id = Number(route.queryParamMap.get('id'));

    if (id) {
      return this._cuidadosService.getCuidadoHoga(id).pipe(
        map(response => response.data)
      );
    }
      
    return of (new CuidadoHogar());
  }
}
