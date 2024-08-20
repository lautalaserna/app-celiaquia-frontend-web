import { Component } from '@angular/core';
import { CuidadoHogar } from '../../interfaces/cuidados';
import { DialogModule } from 'primeng/dialog';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { PaginatorModule } from 'primeng/paginator';
import { ActivatedRoute, NavigationStart, Router, RouterLink } from '@angular/router';
import { CuidadosService } from '../../services/cuidados.service';
import { ToastrService } from 'ngx-toastr';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { SpinnerComponent } from "../../shared/spinner/spinner.component";

@Component({
  selector: 'app-cuidados',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, SpinnerComponent],
  templateUrl: './cuidados.component.html',
  styleUrl: './cuidados.component.css'
})
export class CuidadosComponent {
  listCuidados: CuidadoHogar[] = [];
  displayEliminarModal: boolean = false;
  cuidadoSeleccionadoId: number = 0;
  formFiltros!: FormGroup;
  tituloFilter: string = '';
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;
  puedeCambiarPosicion: boolean = true;

  constructor(
    private formBuilder: FormBuilder,
    private _cuidadosService: CuidadosService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    this.listarCuidados();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      titulo: new FormControl({ value: this.tituloFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void{
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarCuidados();
  }

  listarCuidados() {
    this.loading = true;
    this.tituloFilter = this.formFiltros.get('titulo')?.value 
      ? this.formFiltros.get('titulo')?.value 
      : '';
    
    (this.tituloFilter != '') ? this.puedeCambiarPosicion = false : this.puedeCambiarPosicion = true; 
    
    this._cuidadosService
      .listCuidadosHogar(
        this.page, 
        this.size, 
        this.tituloFilter
      ).subscribe({
        next: (data: any) => {
          this.listCuidados = data.content;
          console.log(this.listCuidados);
          
          this.total = data.totalElements;
        },
        error: (err) => {
          this.loading = false;
          console.error('Error al obtener los datos', err);
        },
        complete: () => {
          this.loading = false;
        }
      }
    );
  }

  toggleEliminarModal(id: number) {
    this.cuidadoSeleccionadoId = id;
    this.displayEliminarModal = !this.displayEliminarModal;
  }

  eliminarCuidado() {
    this._cuidadosService.deleteCuidadoHogar(this.cuidadoSeleccionadoId).subscribe({
      next: (data: any) => {        
        this.toastr.success('Cuidado eliminado con éxito','Eliminación')
      },
      error: (err) => {
        this.toastr.error('No se pudo eliminar el cuidado','Eliminación')
      },
      complete: () => {
        this.cuidadoSeleccionadoId = 0;
        this.displayEliminarModal = false;
        this.listarCuidados();
      },
    });
  }

  nuevoCuidado() {
    localStorage.removeItem('cuidadoHogar');
  }
  
  verCuidadoSeleccionado(cuidadoId: number) {
    this.router.navigate(['/cuidado-detalle'],{ queryParams: { id: cuidadoId } });
  }

}

