import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Alimento, Ingrediente, Porcion, TipoAlimento } from '../../../../interfaces/recetas';
import { FormBuilder, FormControl, FormGroup, FormsModule, NgSelectOption, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { DialogModule } from 'primeng/dialog';
import { ButtonModule } from 'primeng/button';
import { PaginatorModule } from 'primeng/paginator';
import { RouterLink } from '@angular/router';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { ModalConfirmarComponent } from '../../../../shared/modal-confirmar/modal-confirmar.component';

@Component({
  selector: 'app-modal-ingrediente',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, ModalConfirmarComponent],
  templateUrl: './modal-ingrediente.component.html',
  styleUrl: './modal-ingrediente.component.css'
})
export class ModalIngredienteComponent {
  @Input() alimentos: any[] = [];
  @Output() ingredienteSeleccionado = new EventEmitter<Ingrediente>();
  @Input() showDialog: boolean = false;
  @Output() showDialogChange = new EventEmitter<boolean>();

  formFiltrosModal!: FormGroup;
  nombreFilter: string = '';
  tipoFilter: string = '';
  tipos = Object.values(TipoAlimento)

  formIngrediente!: FormGroup;
  alimentoFiltrado: any[] = [];
  alimentoSeleccionado!: any;
  porcionSeleccionada!: Porcion;
  cantidad: number = 1;
  searchQuery: string = '';
  porcionesDisponibles: Porcion[] = [];
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;

  constructor(private fb: FormBuilder,) {}

  ngOnInit() {
    this.crearFormIngrediente();
    this.crearFormFiltros();
    // this.alimentoFiltrado = this.alimentos;
    this.hardcodearAlimentos();
  }

  crearFormIngrediente() {
    this.formIngrediente = this.fb.group({
      ingrediente_id: new FormControl({ value: 0, disabled: false }), 
      alimento: new FormControl({ value: null, disabled: false },  Validators.required ),
      porcion: new FormControl({ value: null, disabled: false },  Validators.required ),
      cantidad: new FormControl({ value: null, disabled: false },  [Validators.required, Validators.min(1)]),
    });
  }

  crearFormFiltros() {
    this.formFiltrosModal = this.fb.group({
      nombre: new FormControl({ value: this.nombreFilter, disabled: false },  Validators.required ),
      tipo: new FormControl({ value: this.tipoFilter, disabled: false },  Validators.required ),
    });
  }

  hardcodearAlimentos() {
    this.alimentoFiltrado = [
      {
        "alimento_id": 1,
        "nombre": "Manzana",
        "tipo": "COLASION",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 1, "nombre": "Unidad", "peso": 150 },
          { "porcion_id": 2, "nombre": "Media unidad", "peso": 75 }
        ]
      },
      {
        "alimento_id": 2,
        "nombre": "Lechuga",
        "tipo": "VERDES",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 3, "nombre": "Taza", "peso": 50 },
          { "porcion_id": 4, "nombre": "Hojas", "peso": 10 }
        ]
      },
      {
        "alimento_id": 3,
        "nombre": "Pollo",
        "tipo": "PROTEINAS",
        "apto_celiaco": true,
        "apto_vegetariano": false,
        "apto_vegano": false,
        "porciones": [
          { "porcion_id": 5, "nombre": "Filete", "peso": 200 },
          { "porcion_id": 6, "nombre": "Media porción", "peso": 100 }
        ]
      },
      {
        "alimento_id": 4,
        "nombre": "Pan",
        "tipo": "HIDRATOS",
        "apto_celiaco": false,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 7, "nombre": "Rebanada", "peso": 30 },
          { "porcion_id": 8, "nombre": "Media rebanada", "peso": 15 }
        ]
      },
      {
        "alimento_id": 5,
        "nombre": "Arroz",
        "tipo": "HIDRATOS",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 9, "nombre": "Taza cocido", "peso": 150 },
          { "porcion_id": 10, "nombre": "Media taza cocido", "peso": 75 }
        ]
      }/* ,
      {
        "alimento_id": 6,
        "nombre": "Pescado",
        "tipo": "PROTEINAS",
        "apto_celiaco": true,
        "apto_vegetariano": false,
        "apto_vegano": false,
        "porciones": [
          { "porcion_id": 11, "nombre": "Filete", "peso": 200 },
          { "porcion_id": 12, "nombre": "Media porción", "peso": 100 }
        ]
      },
      {
        "alimento_id": 7,
        "nombre": "Zanahoria",
        "tipo": "VERDES",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 13, "nombre": "Taza picada", "peso": 130 },
          { "porcion_id": 14, "nombre": "Media taza picada", "peso": 65 }
        ]
      },
      {
        "alimento_id": 8,
        "nombre": "Lentejas",
        "tipo": "PROTEINAS",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 15, "nombre": "Taza cocidas", "peso": 200 },
          { "porcion_id": 16, "nombre": "Media taza cocidas", "peso": 100 }
        ]
      },
      {
        "alimento_id": 9,
        "nombre": "Yogur",
        "tipo": "LÁCTEOS",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": false,
        "porciones": [
          { "porcion_id": 17, "nombre": "Taza", "peso": 245 },
          { "porcion_id": 18, "nombre": "Media taza", "peso": 122.5 }
        ]
      },
      {
        "alimento_id": 10,
        "nombre": "Quinoa",
        "tipo": "HIDRATOS",
        "apto_celiaco": true,
        "apto_vegetariano": true,
        "apto_vegano": true,
        "porciones": [
          { "porcion_id": 19, "nombre": "Taza cocida", "peso": 185 },
          { "porcion_id": 20, "nombre": "Media taza cocida", "peso": 92.5 }
        ]
      } */
    ]    
  }

  listarAlimentos() {
    // TODO: Esto deberia llamar a un endpoint
  }

  seleccionarAlimento(alimento: Alimento) {
    this.formIngrediente.patchValue({ alimento });
    this.porcionesDisponibles = alimento.porciones;
    this.porcionSeleccionada = alimento.porciones[0];
    this.formIngrediente.patchValue({ porcion: this.porcionSeleccionada });
  }

  onPorcionChange() {
    // Logica adicional, no se si sera necesaria
  }

  guardar() {
    console.log(this.formIngrediente.getRawValue());
    if (this.formIngrediente.valid) {
      const ingrediente = this.formIngrediente.getRawValue();
      this.ingredienteSeleccionado.emit(ingrediente);
      this.formIngrediente.reset(); 
      this.closeDialog();
    }
  }

  closeDialog() {
    this.showDialog = false;
    this.showDialogChange.emit(this.showDialog);
  }

  onPageChange(event: PageEvent): void {
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarAlimentos();
  }
}
