import { Component } from '@angular/core';
import { CuidadoHogar } from '../../interfaces/cuidados';
import { DialogModule } from 'primeng/dialog';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { PaginatorModule } from 'primeng/paginator';
import { ActivatedRoute, NavigationStart, Router, RouterLink } from '@angular/router';
import { CuidadosService } from '../../services/cuidados.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-cuidados',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink],
  templateUrl: './cuidados.component.html',
  styleUrl: './cuidados.component.css'
})
export class CuidadosComponent {
  listCuidados: CuidadoHogar[] = [];
  displayEliminarModal: boolean = false;
  formFiltros!: FormGroup;
  paginaActual: number = 0;
  totalRegistros: number = 5;
  tituloFilter: string = '';

  constructor(
    private formBuilder: FormBuilder,
    private _cuidadosService: CuidadosService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    this.listarCuidadosFake();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      titulo: new FormControl({ value: this.tituloFilter, disabled: false },  Validators.required ),
    });
  }

  listarCuidadosFake() {
    this.listCuidados = [
      { id: 1, titulo: 'Cuidado para el Hogar 1', descripcion: 'Descripción del Cuidado para el Hogar 1' },
      { id: 2, titulo: 'Cuidado para el Hogar 2', descripcion: 'Descripción del Cuidado para el Hogar 2' },
      { id: 3, titulo: 'Cuidado para el Hogar 3', descripcion: 'Descripción del Cuidado para el Hogar 3' },
      { id: 4, titulo: 'Cuidado para el Hogar 4', descripcion: 'Descripción del Cuidado para el Hogar 4' },
      { id: 5, titulo: 'Cuidado para el Hogar 5', descripcion: 'Descripción del Cuidado para el Hogar 5' }
    ]
  }

  listarCuidados() {
    this.tituloFilter = this.formFiltros.get('titulo')?.value 
      ? this.formFiltros.get('titulo')?.value 
      : '';
    
    this._cuidadosService
      .listCuidadoHogar(
        this.paginaActual, 
        this.totalRegistros, 
        this.tituloFilter
      ).subscribe({
        next: (data: any) => {
          this.listCuidados = data.listCuidados;
          console.log(this.listCuidados);
          
          // TODO: Utilizar el paginador para mostrar los datos paginados
        },
        error: (err) => {
          console.error('Error al obtener los datos', err);
        },
      }
    );
  }

  toggleEliminarModal() {
    this.displayEliminarModal = !this.displayEliminarModal
  }

  nuevoCuidado() {
    localStorage.removeItem('itemData');
  }
  
  verCuidadoSeleccionado(cuidadoId: number) {
    this.router.navigate(['/cuidado-detalle'],{ queryParams: { id: cuidadoId } });
  }

}

