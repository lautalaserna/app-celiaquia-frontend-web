import { Component } from '@angular/core';
import { CuidadoHogar } from '../../interfaces/cuidados';

@Component({
  selector: 'app-cuidados',
  standalone: true,
  imports: [],
  templateUrl: './cuidados.component.html',
  styleUrl: './cuidados.component.css'
})
export class CuidadosComponent {
  listCuidados: CuidadoHogar[] = [];

  constructor() {}

  ngOnInit() {

  }

}
