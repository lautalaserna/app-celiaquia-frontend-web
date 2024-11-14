import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { DialogModule } from 'primeng/dialog';
import { PaginatorModule } from 'primeng/paginator';
import { ModalConfirmarComponent } from '../../shared/modal-confirmar/modal-confirmar.component';
import { Receta } from '../../interfaces/recetas';
import { RecetasService } from '../../services/recetas.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-recetas',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, ModalConfirmarComponent],
  templateUrl: './recetas.component.html',
  styleUrl: './recetas.component.css'
})
export class RecetasComponent {
  listRecetas: Receta[] = [];
  displayEliminarModal: boolean = false;
  recetaSeleccionadaId: number = 0;
  formFiltros!: FormGroup;
  tituloFilter: string = '';
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private _recetasService: RecetasService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    this.listarRecetas();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      titulo: new FormControl({ value: this.tituloFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void {
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarRecetas();
  }

  listarRecetas() {
   this.loading = true;
    this.tituloFilter = this.formFiltros.get('titulo')?.value 
      ? this.formFiltros.get('titulo')?.value 
      : '';
    
    this._recetasService
      .listRecetas(
        this.page, 
        this.size, 
        this.tituloFilter
      ).subscribe({
        next: (data: any) => {
          this.listRecetas = data.content;
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
    this.recetaSeleccionadaId = id;
    this.displayEliminarModal = !this.displayEliminarModal;
  }

  eliminarReceta() {
    this._recetasService.deleteReceta(this.recetaSeleccionadaId).subscribe({
      next: (data: any) => {        
        this.toastr.success('Receta eliminada con éxito','Eliminación');
      },
      error: (err) => {
        this.toastr.error('No se pudo eliminar la receta','Eliminación');
      },
      complete: () => {
        this.recetaSeleccionadaId = 0;
        this.displayEliminarModal = false;
        this.listarRecetas();
      },
    });
  }

  nuevaReceta() {
    localStorage.removeItem('receta');
  }

  verRecetaSeleccionada(recetaId: number) {
    this.router.navigate(['/receta-detalle'],{ queryParams: { id: recetaId } });
  }
}
