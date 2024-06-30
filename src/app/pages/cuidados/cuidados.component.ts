import { Component } from '@angular/core';
import { CuidadoHogar } from '../../interfaces/cuidados';
import { DialogModule } from 'primeng/dialog';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-cuidados',
  standalone: true,
  imports: [CommonModule, DialogModule, FormsModule],
  templateUrl: './cuidados.component.html',
  styleUrl: './cuidados.component.css'
})
export class CuidadosComponent {
  listCuidados: CuidadoHogar[] = [];
  displayEliminarModal:boolean = false;

  constructor() {}

  ngOnInit() {
    this.listarCuidados();
  }

  listarCuidados() {
    this.listCuidados = [
      { id: 1, titulo: 'Item 1', descripcion: 'Descripción del Item 1' },
      { id: 2, titulo: 'Item 2', descripcion: 'Descripción del Item 2' },
      { id: 3, titulo: 'Item 3', descripcion: 'Descripción del Item 3' },
      { id: 4, titulo: 'Item 4', descripcion: 'Descripción del Item 4' },
      { id: 5, titulo: 'Item 5', descripcion: 'Descripción del Item 5' }
    ]
  }

  toggleEliminarModal() {
    this.displayEliminarModal = !this.displayEliminarModal
  }

}

