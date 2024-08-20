import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/internal/Observable';
import { env } from '../../env/environment';
import { Usuario } from '../interfaces/user';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  baseUrl = env.endpoint;
  apiUrl = '/api/admin';

  constructor(private http: HttpClient) { }

  getUsuario(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }

  listAllUsuarios(): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}/users`);
  }

  listUsuarios(page:number, size:number, username:string, email:string): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}${this.apiUrl}?page=${page}&size=${size}&username=${username}&email=${email}`);
  }

  createUsuario(usuario: Usuario): Observable<Usuario> {
    return this.http.post<Usuario>(`${this.baseUrl}${this.apiUrl}`, usuario);
  }

  deleteUsuario(id: number): Observable<Usuario> {
    return this.http.delete<Usuario>(`${this.baseUrl}${this.apiUrl}/${id}`);
  }
}
