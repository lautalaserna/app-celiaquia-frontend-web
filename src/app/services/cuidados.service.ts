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

  getCuidadoHoga(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

  listCuidadosHogar(page:number, size:number, titulo:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}?page=${page}&size=${size}&titulo=${titulo}`);
  }

  createCuidadoHogar(cuidado: CuidadoHogar): Observable<CuidadoHogar> {
    return this.http.post<CuidadoHogar>(`${this.baseUrl}${this.apiUrl}`, cuidado);
  }

  deleteCuidadoHogar(id: number): Observable<CuidadoHogar> {
    return this.http.delete<CuidadoHogar>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }
}
