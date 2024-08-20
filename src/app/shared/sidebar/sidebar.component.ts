import { Component } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { Usuario } from '../../interfaces/user';
import { UserService } from '../../services/user.service';
import { DialogModule } from 'primeng/dialog';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, DialogModule],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css'
})
export class SidebarComponent {
  displayConfigModal: boolean = false;
  userLogeado!: Usuario;

  constructor(
    private router: Router,
    private _userService: UserService,
  ){}

  ngOnInit(): void {
    this._userService.getUserData().subscribe(user => {
      this.userLogeado = user;
      this.userLogeado.nombre = 'Lautaro';
      this.userLogeado.apellido = 'Laserna';
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
