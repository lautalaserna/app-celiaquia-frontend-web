import { Injectable } from '@angular/core';
import { env } from '../../env/environment';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Estadisticas } from '../interfaces/estadisticas';

@Injectable({
  providedIn: 'root'
})
export class EstadisticasService {
  baseUrl = env.endpoint;
  apiUrl = '/api/estadisticas';

  constructor(private http: HttpClient) { }

  getEstadisticas(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}`);
  }
}
