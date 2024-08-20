import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DialogModule } from 'primeng/dialog';
import { UserService } from '../../services/user.service';
import { Usuario } from '../../interfaces/user';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [DialogModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {
  displayConfigModal: boolean = false;
  userLogeado!: Usuario;
  
  constructor(
    private router: Router,
    private _userService: UserService,
  ) { }

  ngOnInit(): void {
    this._userService.getUserData().subscribe(user => {
      this.userLogeado = user;
      this.userLogeado.nombre = 'Lautaro';
    })
  }

  logOut() {
    localStorage.removeItem('token');
    this.router.navigate(['/login'])
  }

  toggleConfigModal() {
    this.displayConfigModal = !this.displayConfigModal
  }
}
