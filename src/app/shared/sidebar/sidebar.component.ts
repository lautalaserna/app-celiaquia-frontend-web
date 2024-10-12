import { Component } from '@angular/core';
import { Router, RouterLink, RouterLinkActive } from '@angular/router';
import { Usuario } from '../../interfaces/user';
import { UserRoles, UserService } from '../../services/user.service';
import { DialogModule } from 'primeng/dialog';
import { Subscription } from 'rxjs';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, DialogModule, CommonModule],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css'
})
export class SidebarComponent {
  subscription: Subscription = new Subscription();
  displayConfigModal: boolean = false;
  UserRoles = UserRoles
  userName: string = '';

  constructor(
    private router: Router,
    public _userService: UserService,
  ){}

  ngOnInit(): void {
    this.subscription = this._userService.user$.subscribe((user: Usuario | null) => {
      this.userName = user ? `${user.nombre} ${user.apellido}` : 'Usuario';
    });
  }

  logOut(): void {
    this._userService.logOut();
    this.router.navigate(['/login']);
  }

  toggleConfigModal() {
    this.displayConfigModal = !this.displayConfigModal
  }

  ngOnDestroy(): void {
    this.subscription.unsubscribe();
  }
}
