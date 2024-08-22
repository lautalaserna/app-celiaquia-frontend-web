import { Component } from '@angular/core';
import { DialogModule } from 'primeng/dialog';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { PaginatorModule } from 'primeng/paginator';
import { ActivatedRoute, NavigationStart, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { SpinnerComponent } from "../../shared/spinner/spinner.component";
import { Cuestionario } from '../../interfaces/cuestionario';
import { CuestionarioService } from '../../services/cuestionario.service';

@Component({
  selector: 'app-cuestionario',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, SpinnerComponent],
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
    // this.listarCuestionario();
    this.listarCuestionarioFake();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      pregunta: new FormControl({ value: this.preguntaFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void{
    this.page = event.pageIndex;
    this.size = event.pageSize;
    // this.listarCuestionario();
    this.listarCuestionarioFake();
  }

  listarCuestionarioFake() {
    this.total = 5;
    this.listCuestionario = [
      {
        cuestionario_id: 1,
        pregunta: "¿Cuánto tiempo hace que te diagnosticaron con enfermedad celíaca?",
        posicion: 1,
        isactive: true,
        respuestas: [
          { respuesta_id: 1, descripcion: "Menos de 1 año" },
          { respuesta_id: 2, descripcion: "1-3 años" },
          { respuesta_id: 3, descripcion: "3-5 años" },
          { respuesta_id: 4, descripcion: "Más de 5 años" }
        ]
      },
      {
        cuestionario_id: 2,
        pregunta: "¿Qué tipo de dieta sigues actualmente?",
        posicion: 2,
        isactive: true,
        respuestas: [
          { respuesta_id: 1, descripcion: "Estrictamente sin gluten" },
          { respuesta_id: 2, descripcion: "Sin gluten, pero con algunos descuidos" },
          { respuesta_id: 3, descripcion: "No sigo una dieta específica" }
        ]
      },
      {
        cuestionario_id: 3,
        pregunta: "¿Tienes alguna otra alergia o intolerancia alimentaria además del gluten?",
        posicion: 3,
        isactive: true,
        respuestas: [
          { respuesta_id: 1, descripcion: "Sí, alergias alimentarias" },
          { respuesta_id: 2, descripcion: "Sí, intolerancia a la lactosa" },
          { respuesta_id: 3, descripcion: "No, solo soy celíaco" }
        ]
      },
      {
        cuestionario_id: 4,
        pregunta: "¿Qué tan frecuentemente revisas las etiquetas de los alimentos para asegurarte de que sean sin gluten?",
        posicion: 4,
        isactive: true,
        respuestas: [
          { respuesta_id: 1, descripcion: "Siempre" },
          { respuesta_id: 2, descripcion: "A veces" },
          { respuesta_id: 3, descripcion: "Nunca" }
        ]
      },
      {
        cuestionario_id: 5,
        pregunta: "¿Cuánto conoces sobre la contaminación cruzada con gluten?",
        posicion: 5,
        isactive: true,
        respuestas: [
          { respuesta_id: 1, descripcion: "Muy bien informado" },
          { respuesta_id: 2, descripcion: "Tengo conocimientos básicos" },
          { respuesta_id: 3, descripcion: "No estoy seguro" }
        ]
      }
    ];
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

  moverCuestionarioArriba(id:number) {
    // this._cuidadosService.moveCuestionario(id, MovimientoCuidado.ARRIBA); 
    this.listarCuestionario();
  }

  moverCuestionarioAbajo(id:number) {
    // this._cuidadosService.moveCuestionario(id, MovimientoCuidado.ABAJO);
    this.listarCuestionario();
  }

  disableMoverAbajo(i:number ): boolean {
    const posActual = (this.page) * this.size + i;
    return posActual === this.total - 1;
  }
}

