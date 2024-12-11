import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { env } from '../../env/environment';
import { PuntoCompra } from '../interfaces/puntos-compra';

@Injectable({
  providedIn: 'root'
})
export class PuntosCompraService {
  baseUrl = env.endpoint;
  apiUrl = '/api/puntos-compra';

  constructor(private http: HttpClient) { }

  getPuntoCompra(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

  listAllPuntosCompra(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}`);
  }

  listPuntosCompra(page:number, size:number, nombre:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}?page=${page}&size=${size}&pregunta=${nombre}`);
  }

  createPuntoCompra(puntoCompra: PuntoCompra): Observable<PuntoCompra> {
    return this.http.post<PuntoCompra>(`${this.baseUrl}${this.apiUrl}`, puntoCompra);
  }

  deletePuntoCompra(id: number): Observable<PuntoCompra> {
    return this.http.delete<PuntoCompra>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

}
