import { Component } from '@angular/core';
import { DialogModule } from 'primeng/dialog';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { PaginatorModule } from 'primeng/paginator';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { Alimento } from '../../interfaces/recetas';
import { RecetasService } from '../../services/recetas.service';
import { ModalConfirmarComponent } from "../../shared/modal-confirmar/modal-confirmar.component";

@Component({
  selector: 'app-alimentos',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, ModalConfirmarComponent],
  templateUrl: './alimentos.component.html',
  styleUrl: './alimentos.component.css'
})
export class AlimentosComponent {
  listAlimento: Alimento[] = [];
  displayEliminarModal: boolean = false;
  alimentoSeleccionadoId: number = 0;
  formFiltros!: FormGroup;
  nombreFilter: string = '';
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;
  puedeCambiarPosicion: boolean = true;

  constructor(
    private formBuilder: FormBuilder,
    private _recetasService: RecetasService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    this.listarAlimento();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      nombre: new FormControl({ value: this.nombreFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void {
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarAlimento();
  }

  listarAlimento() {
    this.loading = true;
    this.nombreFilter = this.formFiltros.get('nombre')?.value 
      ? this.formFiltros.get('nombre')?.value 
      : '';
    
    this._recetasService
      .listAlimentos(
        this.page, 
        this.size, 
        this.nombreFilter
      ).subscribe({
        next: (data: any) => {
          this.listAlimento = data.content;
          this.total = data.totalElements;
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

  toggleEliminarModal(id: number) {
    this.alimentoSeleccionadoId = id;
    this.displayEliminarModal = !this.displayEliminarModal;
  }

  eliminarAlimento() {
    this._recetasService.deleteAlimento(this.alimentoSeleccionadoId).subscribe({
      next: (data: any) => {        
        this.toastr.success('Alimento eliminado con éxito','Eliminación');
      },
      error: (err) => {
        this.toastr.error('No se pudo eliminar el alimento','Eliminación');
      },
      complete: () => {
        this.alimentoSeleccionadoId = 0;
        this.displayEliminarModal = false;
        this.listarAlimento();
      },
    });
  }

  nuevoAlimento() {
    localStorage.removeItem('alimento');
  }

  verAlimentoSeleccionado(alimentoId: number) {
    this.router.navigate(['/alimento-detalle'],{ queryParams: { id: alimentoId } });
  }
}
