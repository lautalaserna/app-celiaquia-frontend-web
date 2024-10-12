import { Component } from '@angular/core';
import { DialogModule } from 'primeng/dialog';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { PaginatorModule } from 'primeng/paginator';
import { ActivatedRoute, NavigationStart, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { Cuestionario } from '../../interfaces/cuestionario';
import { ActionCuestionario, CuestionarioService } from '../../services/cuestionario.service';
import { ModalConfirmarComponent } from "../../shared/modal-confirmar/modal-confirmar.component";

@Component({
  selector: 'app-cuestionario',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, ModalConfirmarComponent],
  templateUrl: './cuestionario.component.html',
  styleUrl: './cuestionario.component.css'
})
export class CuestionarioComponent {
  listCuestionario: Cuestionario[] = [];
  displayEliminarModal: boolean = false;
  cuestionarioSeleccionadoId: number = 0;
  formFiltros!: FormGroup;
  preguntaFilter: string = '';
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;
  puedeCambiarPosicion: boolean = true;

  constructor(
    private formBuilder: FormBuilder,
    private _cuestionarioService: CuestionarioService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    this.listarCuestionario();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      pregunta: new FormControl({ value: this.preguntaFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void{
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarCuestionario();
  }

  listarCuestionario() {
    this.loading = true;
    this.preguntaFilter = this.formFiltros.get('pregunta')?.value 
      ? this.formFiltros.get('pregunta')?.value 
      : '';
    
    this._cuestionarioService
      .listCuestionario(
        this.page, 
        this.size, 
        this.preguntaFilter
      ).subscribe({
        next: (data: any) => {
          this.listCuestionario = data.content;
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
    this.cuestionarioSeleccionadoId = id;
    this.displayEliminarModal = !this.displayEliminarModal;
  }

  eliminarCuestionario() {
    this._cuestionarioService.deleteCuestionario(this.cuestionarioSeleccionadoId).subscribe({
      next: (data: any) => {        
        this.toastr.success('Cuestionario eliminado con éxito','Eliminación')
      },
      error: (err) => {
        this.toastr.error('No se pudo eliminar el cuestionario','Eliminación')
      },
      complete: () => {
        this.cuestionarioSeleccionadoId = 0;
        this.displayEliminarModal = false;
        this.listarCuestionario();
      },
    });
  }

  nuevoCuestionario() {
    localStorage.removeItem('cuestionario');
  }
  
  verCuestionarioSeleccionado(cuestionarioId: number) {
    this.router.navigate(['/cuestionario-detalle'],{ queryParams: { id: cuestionarioId } });
  }

  switchCuestionarioUp(id:number) {
    this._cuestionarioService.switchCuestionario(id, ActionCuestionario.UP).subscribe(res => {
      this.listarCuestionario();
    });
  }

  switchCuestionarioDown(id:number) {
    this._cuestionarioService.switchCuestionario(id, ActionCuestionario.DOWN).subscribe(res => {
      this.listarCuestionario();
    });
  }

  disableMoverAbajo(i:number ): boolean {
    const posActual = (this.page) * this.size + i;
    return posActual === this.total - 1;
  }
}

