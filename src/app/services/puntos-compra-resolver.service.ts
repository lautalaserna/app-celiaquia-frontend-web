import { Injectable } from '@angular/core';
import { PuntoCompra } from '../interfaces/puntos-compra';
import { PuntosCompraService } from './puntos-compra.service';
import { ActivatedRouteSnapshot } from '@angular/router';
import { map, Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PuntosCompraResolverService {
  puntoCompra: PuntoCompra | undefined;

  constructor(private _puntoCompraService: PuntosCompraService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<PuntoCompra> {
    const id = Number(route.queryParamMap.get('id'));

    if (id) {
      return this._puntoCompraService.getPuntoCompra(id).pipe(
        map(response => response.data)
      );
    }
      
    return of (new PuntoCompra());
  }
}
