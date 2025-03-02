import { Injectable } from '@angular/core';
import { env } from '../../env/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Alimento, Receta } from '../interfaces/recetas';

@Injectable({
  providedIn: 'root'
})
export class RecetasService {
  baseUrl = env.endpoint;
  apiAlimentosUrl = '/api/alimentos';
  apiRecetasUrl = '/api/recetas';
  
  constructor(private http: HttpClient) { }

  getReceta(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiRecetasUrl}/${id}/detail`);
  }

  listRecetas(page:number, size:number, titulo:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiRecetasUrl}?page=${page}&size=${size}&titulo=${titulo}&sort=titulo`);
  }

  createReceta(receta: Receta): Observable<Receta> {
    return this.http.post<Receta>(`${this.baseUrl}${this.apiRecetasUrl}`, receta);
  }

  deleteReceta(id: number): Observable<Receta> {
    return this.http.delete<Receta>(`${this.baseUrl}${this.apiRecetasUrl}/${id}`);
  }

  getAlimento(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiAlimentosUrl}/${id}`);
  }

  listAlimentos(page:number, size:number, nombre:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiAlimentosUrl}?page=${page}&size=${size}&nombre=${nombre}&sort=nombre`);
  }

  createAlimento(alimento: Alimento): Observable<Alimento> {
    return this.http.post<Alimento>(`${this.baseUrl}${this.apiAlimentosUrl}`, alimento);
  }

  deleteAlimento(id: number): Observable<Alimento> {
    return this.http.delete<Alimento>(`${this.baseUrl}${this.apiAlimentosUrl}/${id}`);
  }
}
