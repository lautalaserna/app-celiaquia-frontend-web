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
import { RecetasService } from '../../../../services/recetas.service';

@Component({
  selector: 'app-modal-ingrediente',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, PaginatorModule, MatPaginatorModule],
  templateUrl: './modal-ingrediente.component.html',
  styleUrl: './modal-ingrediente.component.css'
})
export class ModalIngredienteComponent {
  @Output() ingredienteSeleccionado = new EventEmitter<Ingrediente>();
  @Input() showDialog: boolean = false;
  @Output() showDialogChange = new EventEmitter<boolean>();

  formFiltrosModal!: FormGroup;
  nombreFilter: string = '';
  tipoFilter: string = '';
  tipos = Object.values(TipoAlimento)

  formIngrediente!: FormGroup;
  listAlimentos: Alimento[] = [];
  alimentoSeleccionado: Alimento | null = null;
  porcionSeleccionada: Porcion | null = null;
  cantidad: number = 1;
  searchQuery: string = '';
  porcionesDisponibles: any[] = [];
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;

  constructor(
    private fb: FormBuilder, 
    private _recetasService: RecetasService
  ) {}

  ngOnInit() {
    this.crearFormIngrediente();
    this.crearFormFiltros();
    this.listarAlimentos();
  }

  crearFormIngrediente() {
    this.formIngrediente = this.fb.group({
      ingrediente_id: new FormControl({ value: 0, disabled: false }), 
      alimento: new FormControl({ value: null, disabled: false },  Validators.required ),
      porcion: new FormControl({ value: null, disabled: true },  Validators.required ),
      cantidad: new FormControl({ value: null, disabled: true },  [Validators.required, Validators.min(1)]),
    });
  }

  crearFormFiltros() {
    this.formFiltrosModal = this.fb.group({
      nombre: new FormControl({ value: this.nombreFilter, disabled: false },  Validators.required ),
      tipo: new FormControl({ value: this.tipoFilter, disabled: false },  Validators.required ),
    });
  }

  listarAlimentos() {
    this.loading = true;
    this.nombreFilter = this.formFiltrosModal.get('nombre')?.value 
      ? this.formFiltrosModal.get('nombre')?.value 
      : '';

    this.tipoFilter = this.formFiltrosModal.get('tipo')?.value 
      ? this.formFiltrosModal.get('tipo')?.value 
      : '';

    this._recetasService
      .listAlimentos(
        this.page, 
        this.size, 
        this.nombreFilter,
        //this.tipoFilter
      ).subscribe({
        next: (data: any) => {
          this.listAlimentos = data.content;
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

  seleccionarAlimento(alimento: Alimento) {
    this.formIngrediente.patchValue({ alimento });
    this.alimentoSeleccionado = alimento;
    this.porcionesDisponibles = alimento.porciones;
    this.porcionSeleccionada = alimento.porciones[0];
    this.formIngrediente.patchValue({ porcion: this.porcionSeleccionada });
    this.formIngrediente.get('porcion')?.enable();
    this.formIngrediente.get('cantidad')?.setValue(1);
    this.formIngrediente.get('cantidad')?.enable();
  }

  guardar() {
    if (this.formIngrediente.valid) {
      const ingrediente = this.formIngrediente.getRawValue() as Ingrediente;
      this.ingredienteSeleccionado.emit(ingrediente);
      this.closeDialog();
    }
  }

  closeDialog() {
    this.formIngrediente.reset(); 
    this.formFiltrosModal.reset(); 
    this.formIngrediente.get('porcion')?.disable();
    this.formIngrediente.get('cantidad')?.disable();
    this.alimentoSeleccionado = null;
    this.porcionSeleccionada = null;
    this.showDialog = false;
    this.showDialogChange.emit(this.showDialog);
  }

  onPageChange(event: PageEvent): void {
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarAlimentos();
  }
}
