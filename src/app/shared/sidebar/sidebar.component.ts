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
  subscription = new Subscription();
  displayConfigModal: boolean = false;
  UserRoles = UserRoles
  userName: string = '';

  constructor(
    private router: Router,
    public _userService: UserService,
  ){}

  ngOnInit(): void {
    this.userName = this._userService.getUserFullName();
  }

  logOut() {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    this.router.navigate(['/login']);
  }

  toggleConfigModal() {
    this.displayConfigModal = !this.displayConfigModal
  }
}
