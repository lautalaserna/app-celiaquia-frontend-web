import { Injectable } from '@angular/core';
import { Alimento } from '../interfaces/recetas';
import { RecetasService } from './recetas.service';
import { ActivatedRouteSnapshot } from '@angular/router';
import { map, Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AlimentoResolverService {
  alimento: Alimento | undefined;

  constructor(private _recetasService: RecetasService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<Alimento> {
    const id = Number(route.queryParamMap.get('id'));

    if (id) {
      return this._recetasService.getAlimento(id).pipe(
        map(response => response.data)
      );
    }
      
    return of (new Alimento());
  }
}
