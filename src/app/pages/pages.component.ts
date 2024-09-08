import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { SidebarComponent } from '../shared/sidebar/sidebar.component';

@Component({
  selector: 'app-pages',
  standalone: true,
  templateUrl: './pages.component.html',
  styleUrls: ['./pages.component.css'],
  imports: [SidebarComponent, RouterOutlet]
})
export class PagesComponent implements OnInit {
  showSideBar:boolean = true;

  constructor(){}
  
  async ngOnInit() {
  }

  toggleSideBar() {
    this.showSideBar = !this.showSideBar;
  }
}