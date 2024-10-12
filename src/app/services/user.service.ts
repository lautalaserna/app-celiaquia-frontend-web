import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { Usuario } from '../interfaces/user';
import { env } from '../../env/environment';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  appUrl = env.endpoint;
  apiUrl = '/api/auth';
  private userSubject = new BehaviorSubject<Usuario | null>(this.getUserData());
  public user$ = this.userSubject.asObservable();

  constructor(private http: HttpClient) {}

  login(user: any): Observable<any> {
    return this.http.post<any>(`${this.appUrl}${this.apiUrl}/login`, user).pipe(
      tap(response => {
        if (response && response.token) {
          this.storeToken(response.token);
          this.getUser().subscribe(user => {
            if (user && user.data) {
              this.storeUserData(user.data);
            }
          });
        }
      })
    );
  }

  private storeToken(token: string): void {
    localStorage.setItem('token', token);
  }

  private storeUserData(user: Usuario): void {
    localStorage.setItem('user', JSON.stringify(user));
    this.userSubject.next(user);
  }

  getUser(): Observable<any> {
    return this.http.get<any>(`${this.appUrl}${this.apiUrl}/user`);
  }

  getUserData(): Usuario | null {
    const storedUser = localStorage.getItem('user');
    return storedUser ? JSON.parse(storedUser) : null;
  }

  getUserFullName(): string {
    const user = this.getUserData();
    return user ? `${user.nombre} ${user.apellido}` : 'Usuario';
  }

  validateRoles(roles: UserRoles[]): boolean {
    const user = this.getUserData();
    return user && user.roles
      ? roles.every(role => user.roles.some(userRole => userRole.nombre === role))
      : false;
  }

  logOut(): void {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    this.userSubject.next(null);
  }
}

export enum UserRoles {
  ROL_DEFAULT = 'ROL_DEFAULT',
  ROL_ADMIN = 'ROL_ADMIN'
}
