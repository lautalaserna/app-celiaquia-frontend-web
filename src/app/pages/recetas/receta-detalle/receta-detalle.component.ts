import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Ingrediente, Receta, TipoAlimento } from '../../../interfaces/recetas';
import { RecetasService } from '../../../services/recetas.service';
import { ModalIngredienteComponent } from './modal-ingrediente/modal-ingrediente.component';

@Component({
  selector: 'app-receta-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink, ModalIngredienteComponent],
  templateUrl: './receta-detalle.component.html',
  styleUrl: './receta-detalle.component.css'
})
export class RecetaDetalleComponent {
  receta!: Receta;
  formReceta!: FormGroup;
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;
  mostrarModal: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private router: Router,
    private route: ActivatedRoute,
    private _recetasService: RecetasService
  ){}

  ngOnInit() {
    const id = this.route.snapshot.queryParamMap.get('id');

    if(id){
      this.soloLectura = true;
      this.receta = this.route.snapshot.data['receta'];
    } else {
      this.esNuevo = true;
    }

    this.hardcodearReceta();
    this.crearForm();
  }

  hardcodearReceta() {
   this.receta = {
      receta_id: 1,
      titulo: 'Ensalada de Quinoa',
      preparacion: 'Cocina la quinoa en agua hirviendo hasta que esté tierna. Mezcla con los demás ingredientes y aliña al gusto.',
      apto_vegetariano: true,
      apto_vegano: true,
      energia_total_kcal: 320,
      energia_total_kj: 1340,
      proteinas_totales: 12,
      carbohidratos_totales: 40,
      grasas_totales: 12,
      ingredientes: [
        {
          ingrediente_id: 1,
          alimento: {
            alimento_id: 101,
            numero: 1,
            nombre: 'Quinoa',
            genero: 'Grano',
            tipo: TipoAlimento.HIDRATOS,
            apto_celiaco: true,
            apto_vegetariano: true,
            apto_vegano: true,
            porciones: [
              {
                porcion_id: 1,
                nombre: 'Taza',
                peso: 185
              }
            ],
            energia_kcal: 222,
            energia_kj: 927,
            proteinas: 8,
            carbohidratos_totales: 39,
            carbohidratos_disponibles: 35,
            grasa_total: 4,
            ac_grasos_monoinsaturados: 1,
            ac_grasos_poliinsaturados: 2,
            ac_grasos_saturados: 0.5,
            agua: 72,
            calcio: 31,
            cenizas: 2,
            fosforo: 281,
            hierro: 2.8,
            niacina: 0.4,
            potasio: 318,
            rivoflavina: 0.1,
            sodio: 5,
            tiamina: 0.2,
            vitamina_c: 0,
            zinc: 1.1,
            colesterol: 0,
            fibra_dietetica: 5
          },
          porcion: {
            porcion_id: 1,
            nombre: 'Taza',
            peso: 185
          },
          cantidad: 1
        },
        {
          ingrediente_id: 2,
          alimento: {
            alimento_id: 102,
            numero: 2,
            nombre: 'Tomate cherry',
            genero: 'Fruta',
            tipo: TipoAlimento.VERDES,
            apto_celiaco: true,
            apto_vegetariano: true,
            apto_vegano: true,
            porciones: [
              {
                porcion_id: 2,
                nombre: 'Unidad',
                peso: 150
              }
            ],
            energia_kcal: 30,
            energia_kj: 126,
            proteinas: 1,
            carbohidratos_totales: 7,
            carbohidratos_disponibles: 5,
            grasa_total: 0.3,
            ac_grasos_monoinsaturados: 0,
            ac_grasos_poliinsaturados: 0,
            ac_grasos_saturados: 0,
            agua: 94,
            calcio: 10,
            cenizas: 0.5,
            fosforo: 24,
            hierro: 0.4,
            niacina: 0.6,
            potasio: 290,
            rivoflavina: 0.02,
            sodio: 5,
            tiamina: 0.03,
            vitamina_c: 15,
            zinc: 0.1,
            colesterol: 0,
            fibra_dietetica: 1.5
          },
          porcion: {
            porcion_id: 2,
            nombre: 'Unidad',
            peso: 150
          },
          cantidad: 10
        },
        {
          ingrediente_id: 3,
          alimento: {
            alimento_id: 103,
            numero: 3,
            nombre: 'Aguacate',
            genero: 'Fruta',
            tipo: TipoAlimento.PROTEINAS,
            apto_celiaco: true,
            apto_vegetariano: true,
            apto_vegano: true,
            porciones: [
              {
                porcion_id: 3,
                nombre: 'Unidad',
                peso: 75
              }
            ],
            energia_kcal: 120,
            energia_kj: 502,
            proteinas: 1.5,
            carbohidratos_totales: 6,
            carbohidratos_disponibles: 3,
            grasa_total: 11,
            ac_grasos_monoinsaturados: 7,
            ac_grasos_poliinsaturados: 1.5,
            ac_grasos_saturados: 1.5,
            agua: 70,
            calcio: 10,
            cenizas: 0.5,
            fosforo: 30,
            hierro: 0.3,
            niacina: 1,
            potasio: 400,
            rivoflavina: 0.1,
            sodio: 5,
            tiamina: 0.05,
            vitamina_c: 10,
            zinc: 0.3,
            colesterol: 0,
            fibra_dietetica: 3
          },
          porcion: {
            porcion_id: 3,
            nombre: 'Unidad',
            peso: 75
          },
          cantidad: 0.5
        },
        {
          ingrediente_id: 4,
          alimento: {
            alimento_id: 104,
            numero: 4,
            nombre: 'Aceite de oliva',
            genero: 'Aceite',
            tipo: TipoAlimento.PROTEINAS,
            apto_celiaco: true,
            apto_vegetariano: true,
            apto_vegano: true,
            porciones: [
              {
                porcion_id: 4,
                nombre: 'Cucharada',
                peso: 13.5
              }
            ],
            energia_kcal: 120,
            energia_kj: 502,
            proteinas: 0,
            carbohidratos_totales: 0,
            carbohidratos_disponibles: 0,
            grasa_total: 13.5,
            ac_grasos_monoinsaturados: 10,
            ac_grasos_poliinsaturados: 1,
            ac_grasos_saturados: 2,
            agua: 0,
            calcio: 0,
            cenizas: 0,
            fosforo: 0,
            hierro: 0,
            niacina: 0,
            potasio: 0,
            rivoflavina: 0,
            sodio: 0,
            tiamina: 0,
            vitamina_c: 0,
            zinc: 0,
            colesterol: 0,
            fibra_dietetica: 0
          },
          porcion: {
            porcion_id: 4,
            nombre: 'Cucharada',
            peso: 13.5
          },
          cantidad: 1
        }
      ]
    };
  }

  crearForm() {
    this.formReceta = this.formBuilder.group({
      receta_id: new FormControl({ value: this.receta?.receta_id || 0, disabled: true }),
      titulo: new FormControl({ value: this.receta?.titulo || null, disabled: this.soloLectura }, [Validators.required, Validators.maxLength(200)]),
      preparacion: new FormControl({ value: this.receta?.preparacion || null, disabled: this.soloLectura }, [Validators.required, Validators.maxLength(1000)]),
      apto_vegetariano: new FormControl({ value: this.receta?.apto_vegetariano || false, disabled: this.soloLectura }),
      apto_vegano: new FormControl({ value: this.receta?.apto_vegano || false, disabled: this.soloLectura }),
      energia_total_kcal: new FormControl({ value: this.receta?.energia_total_kcal || 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      energia_total_kj: new FormControl({ value: this.receta?.energia_total_kj || 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      proteinas_totales: new FormControl({ value: this.receta?.proteinas_totales || 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      carbohidratos_totales: new FormControl({ value: this.receta?.carbohidratos_totales || 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      grasas_totales: new FormControl({ value: this.receta?.grasas_totales || 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      ingredientes: this.formBuilder.array(this.receta?.ingredientes ? this.receta.ingredientes.map(i => this.crearIngrediente(i)) : [])
    });
  }

  crearIngrediente(ingrediente?: Ingrediente): FormGroup {
    return this.formBuilder.group({
      ingrediente_id: new FormControl({ value: ingrediente?.ingrediente_id || 0, disabled: this.soloLectura }),
      alimento: new FormControl({ value: ingrediente?.alimento.nombre || null, disabled: this.soloLectura }, Validators.required),
      porcion: new FormControl({ value: ingrediente?.porcion.nombre || null, disabled: this.soloLectura }, Validators.required),
      cantidad: new FormControl({ value: ingrediente?.cantidad || 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0.1)])
    });
  }

  get ingredientes(): FormArray {
    return this.formReceta.get('ingredientes') as FormArray;
  }

  abrirModalIngrediente() {
    this.mostrarModal = true;
  }

  agregarIngredienteSeleccionado(ingrediente: any) {
    this.ingredientes.push(this.crearIngrediente(ingrediente));
    this.mostrarModal = false;
    this.toastr.success('Ingrediente agregado con éxito!');
  }

  eliminarIngrediente(index: number) {
    this.ingredientes.removeAt(index);
  }  

  limpiarReceta() {
    localStorage.removeItem('receta');
    this.router.navigate(['/recetas']);
  }

  guardarReceta() {
    const body = this.formReceta.getRawValue() as Receta;
    this.loading = true;

    this._recetasService.createReceta(body).subscribe({
      next: (data) => {
        this.loading = false;
        this.router.navigate(['/recetas'])
      },
      error: (err: any) => {
        this.loading = false;
        this.toastr.error('No se pudo guardar la receta', 'Guardado');
      },
    });
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
  }
}
