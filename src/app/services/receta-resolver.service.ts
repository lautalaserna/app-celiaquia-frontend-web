import { Injectable } from '@angular/core';
import { Receta } from '../interfaces/recetas';
import { RecetasService } from './recetas.service';
import { ActivatedRouteSnapshot } from '@angular/router';
import { map, Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class RecetaResolverService {
  receta: Receta | undefined;

  constructor(private _recetasService: RecetasService) { }

  resolve(route: ActivatedRouteSnapshot): Observable<Receta> {
    const id = Number(route.queryParamMap.get('id'));

    if (id) {
      return this._recetasService.getAlimento(id).pipe(
        map(response => response.data)
      );
    }
      
    return of (new Receta());
  }
}
