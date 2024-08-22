import { Injectable } from '@angular/core';
import { env } from '../../env/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Cuestionario } from '../interfaces/cuestionario';

@Injectable({
  providedIn: 'root'
})
export class CuestionarioService {
  baseUrl = env.endpoint;
  apiUrl = '/api/cuestionario';

  constructor(private http: HttpClient) { }

  getCuestionario(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

  listAllCuestionario(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}`);
  }

  listCuestionario(page:number, size:number, pregunta:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}?page=${page}&size=${size}&pregunta=${pregunta}`);
  }

  createCuestionario(usuario: Cuestionario): Observable<Cuestionario> {
    return this.http.post<Cuestionario>(`${this.baseUrl}${this.apiUrl}`, usuario);
  }

  deleteCuestionario(id: number): Observable<Cuestionario> {
    return this.http.delete<Cuestionario>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

  moveCuestionario(id: number, dir: MovimientoCuestionario) {
    const body = {
      cuestionario_id: id,
      movimiento: dir
    }
    return this.http.post<Cuestionario>(`${this.baseUrl}${this.apiUrl}/mover`,body);
  }
}

export enum MovimientoCuestionario {
  ARRIBA = 'ARRIBA',
  ABAJO = 'ABAJO'
}