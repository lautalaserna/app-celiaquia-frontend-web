import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { env } from '../../env/environment';
import { Usuario } from '../interfaces/user';
import { BehaviorSubject, Observable, Observer, tap } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  appUrl = env.endpoint;
  apiUrl = '/api/auth';
  userLogeado = null;

  constructor(private http: HttpClient) {}

  login(user: any): Observable<any> {
    return this.http.post<any>(`${this.appUrl}${this.apiUrl}/login`, user).pipe(
      tap(response => {
        if (response && response.token) {
          this.storeToken(response.token);
          this.getUser().subscribe(user => {
            if(user && user.data){
              localStorage.setItem('user', JSON.stringify(user.data));
              this.userLogeado = user.data;
            }
          });
        }
      })
    );
  }

  private storeToken(token: string): void {
    localStorage.setItem('token', token);
  }

  getUser(): Observable<any> {
    return this.http.get<any>(`${this.appUrl}${this.apiUrl}/user`)
  }

  getUserData(): Usuario | null {
    const storedUser = localStorage.getItem('user');
    if (storedUser) return JSON.parse(storedUser);
    return null;
  }
  
  getUserFullName():string {
    const user = this.getUserData();
    if(!user) return 'Usuario'
    return user.nombre + ' ' + user.apellido; 
  }

  validateRoles(roles: UserRoles[]): boolean {
    const user = this.getUserData();
    if(user && user.roles){
      return roles.every(roleParam => 
        user.roles.some(userRole => userRole.nombre === roleParam)
      );
    }
    return false;
  }
}

export enum UserRoles {
  ROL_DEFAULT = "ROL_DEFAULT",
  ROL_ADMIN = "ROL_ADMIN"
}