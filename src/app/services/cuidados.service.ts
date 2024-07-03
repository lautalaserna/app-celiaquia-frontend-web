import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { CuidadoHogar } from '../interfaces/cuidados';
import { HttpClient } from '@angular/common/http';
import { env } from '../../env/environment';

@Injectable({
  providedIn: 'root'
})
export class CuidadosService {
  baseUrl = env.endpoint;
  apiUrl = '/api/cuidados';

  constructor(private http: HttpClient) {}

  getCuidadosHogar(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

  listCuidadoHogar(paginaActual:number, totalRegistros:number, titulo:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}?paginaActual=${paginaActual}&totalRegistros=${totalRegistros}&titulo=${titulo}`);
  }

  createCuidadoHogar(cuidado: CuidadoHogar): Observable<CuidadoHogar> {
    return this.http.post<CuidadoHogar>(`${this.baseUrl}${this.apiUrl}/crear`, cuidado);
  }

  editCuidadoHogar(cuidado: CuidadoHogar): Observable<CuidadoHogar> {
    return this.http.post<CuidadoHogar>(`${this.baseUrl}${this.apiUrl}/editar`, cuidado);
  }
}
