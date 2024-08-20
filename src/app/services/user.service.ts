import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { env } from '../../env/environment';
import { Usuario } from '../interfaces/user';
import { Observable, Observer } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  appUrl = env.endpoint;
  apiUrl = '/api/auth';

  constructor(private http: HttpClient) {}

   login(user: any): Observable<any> {
    return this.http.post<any>(`${this.appUrl}${this.apiUrl}/login`, user);
   }

   getUserData(): Observable<any> {;
    return this.http.get<any>(`${this.appUrl}${this.apiUrl}/user`);
   }
}
