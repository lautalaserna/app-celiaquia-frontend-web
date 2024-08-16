import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { DialogModule } from 'primeng/dialog';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [DialogModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css'
})
export class NavbarComponent {
  displayConfigModal: boolean = false;
  
  constructor(private router: Router) { }

  ngOnInit(): void {
  }

  logOut() {
    localStorage.removeItem('token');
    this.router.navigate(['/login'])
  }

  toggleConfigModal() {
    this.displayConfigModal = !this.displayConfigModal
  }
}
