import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EstadisticasService } from '../../services/estadisticas.service';
import { Estadisticas } from '../../interfaces/estadisticas';

@Component({
  selector: 'app-estadisticas',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './estadisticas.component.html',
  styleUrls: ['./estadisticas.component.css']
})
export class EstadisticasComponent implements OnInit {
  estadisticas!: Estadisticas;
  loading: boolean = true;

  constructor(
    private _estadisticasService: EstadisticasService
  ) { }

  ngOnInit() {
    this.loadEstadisticas();
  }

  loadEstadisticas() {
    this.loading = true;

    this._estadisticasService.getEstadisticas().subscribe({
      next: (data: any) => {
        this.estadisticas = data.data;
      },
      error: (err) => {
        this.loading = false;
        console.error('Error al obtener los datos', err);
      },
      complete: () => {
        this.loading = false;
      }
    });
  }
  
  formatNumber(value: number): string {
    if (value >= 1000) {
      return (value / 1000).toFixed(1) + 'K';
    }
    return value.toString();
  }

  getIcon(key: string): string {
    switch (key) {
      case 'TOTALES':
        return 'fas fa-users';
      case 'VEGETARIANOS':
        return 'fas fa-carrot';
      case 'VEGANOS':
        return 'fas fa-leaf';
      case 'ACTIVOS':
        return 'fas fa-user-check';
      default:
        return 'fas fa-users';
    }
  }

  capitalize(key: string): string {
    if (!key) return key;
    return key.charAt(0).toUpperCase() + key.slice(1).toLowerCase();
  }
}