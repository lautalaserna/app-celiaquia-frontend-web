import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { env } from '../../env/environment';
import { User } from '../interfaces/user';
import { Observable, Observer } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  private appUrl: string;
  private apiUrl: string;

  constructor(private http: HttpClient) {
    this.appUrl = env.endpoint;
    this.apiUrl =  '/api/auth'
   }

   login(user: User): Observable<any> {
    return this.http.post<any>(`${this.appUrl}${this.apiUrl}/login`, user);
   }

   getUserData(): Observable<any> {
    //const token = localStorage.getItem('token');
    //const headers = new HttpHeaders().set('Authorization',`Bearer ${token}`)
    //return this.http.get<any>(`${this.appUrl}${this.apiUrl}/user`, { headers: headers } );
    return this.http.get<any>(`${this.appUrl}${this.apiUrl}/user`);
   }
}
