import { Component } from '@angular/core';
import { Alimento, Porcion } from '../../../interfaces/recetas';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { RecetasService } from '../../../services/recetas.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-alimento-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink],
  templateUrl: './alimento-detalle.component.html',
  styleUrl: './alimento-detalle.component.css'
})
export class AlimentoDetalleComponent {
  alimento!: Alimento;
  formAlimento!: FormGroup;
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;

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
      this.alimento = this.route.snapshot.data['alimento'];
    } else {
      this.esNuevo = true;
    }

    this.crearForm();
  }

  crearForm() {
    this.formAlimento = this.formBuilder.group({
      alimento_id: new FormControl({ value: this.alimento?.alimento_id ? this.alimento.alimento_id : 0, disabled: true }),
      nombre: new FormControl({ value: this.alimento?.nombre ? this.alimento.nombre : null, disabled: this.soloLectura }, [Validators.required, Validators.maxLength(200)]),
      genero: new FormControl({ value: this.alimento?.genero ? this.alimento.genero : null, disabled: this.soloLectura }),
      apto_celiaco: new FormControl({ value: this.alimento?.apto_celiaco ? this.alimento.apto_celiaco : false, disabled: this.soloLectura }),
      apto_vegetariano: new FormControl({ value: this.alimento?.apto_vegetariano ? this.alimento.apto_vegetariano : false, disabled: this.soloLectura }),
      apto_vegano: new FormControl({ value: this.alimento?.apto_vegano ? this.alimento.apto_vegano : false, disabled: this.soloLectura }),
      energia_kcal: new FormControl({ value: this.alimento?.energia_kcal ? this.alimento.energia_kcal : 0, disabled: this.soloLectura }, [Validators.required]),
      energia_kj: new FormControl({ value: this.alimento?.energia_kj ? this.alimento.energia_kj : 0, disabled: this.soloLectura }, [Validators.required]),
      proteinas: new FormControl({ value: this.alimento?.proteinas ? this.alimento.proteinas : 0, disabled: this.soloLectura }, [Validators.required]),
      carbohidratos_totales: new FormControl({ value: this.alimento?.carbohidratos_totales ? this.alimento.carbohidratos_totales : 0, disabled: this.soloLectura }, [Validators.required]),
      carbohidratos_disponibles: new FormControl({ value: this.alimento?.carbohidratos_disponibles ? this.alimento.carbohidratos_disponibles : 0, disabled: this.soloLectura }, [Validators.required]),
      grasa_total: new FormControl({ value: this.alimento?.grasa_total ? this.alimento.grasa_total : 0, disabled: this.soloLectura }, [Validators.required]),
      ac_grasos_monoinsaturados: new FormControl({ value: this.alimento?.ac_grasos_monoinsaturados ? this.alimento.ac_grasos_monoinsaturados : 0, disabled: this.soloLectura }, [Validators.required]),
      ac_grasos_poliinsaturados: new FormControl({ value: this.alimento?.ac_grasos_poliinsaturados ? this.alimento.ac_grasos_poliinsaturados : 0, disabled: this.soloLectura }, [Validators.required]),
      ac_grasos_saturados: new FormControl({ value: this.alimento?.ac_grasos_saturados ? this.alimento.ac_grasos_saturados : 0, disabled: this.soloLectura }, [Validators.required]),
      agua: new FormControl({ value: this.alimento?.agua ? this.alimento.agua : null, disabled: this.soloLectura }),
      calcio: new FormControl({ value: this.alimento?.calcio ? this.alimento.calcio : null, disabled: this.soloLectura }),
      cenizas: new FormControl({ value: this.alimento?.cenizas ? this.alimento.cenizas : null, disabled: this.soloLectura }),
      fosforo: new FormControl({ value: this.alimento?.fosforo ? this.alimento.fosforo : null, disabled: this.soloLectura }),
      hierro: new FormControl({ value: this.alimento?.hierro ? this.alimento.hierro : null, disabled: this.soloLectura }),
      niacina: new FormControl({ value: this.alimento?.niacina ? this.alimento.niacina : null, disabled: this.soloLectura }),
      numero: new FormControl({ value: this.alimento?.numero ? this.alimento.numero : null, disabled: this.soloLectura }),
      potasio: new FormControl({ value: this.alimento?.potasio ? this.alimento.potasio : null, disabled: this.soloLectura }),
      rivoflavina: new FormControl({ value: this.alimento?.rivoflavina ? this.alimento.rivoflavina : null, disabled: this.soloLectura }),
      sodio: new FormControl({ value: this.alimento?.sodio ? this.alimento.sodio : null, disabled: this.soloLectura }),
      tiamina: new FormControl({ value: this.alimento?.tiamina ? this.alimento.tiamina : null, disabled: this.soloLectura }),
      vitamina_c: new FormControl({ value: this.alimento?.vitamina_c ? this.alimento.vitamina_c : null, disabled: this.soloLectura }),
      zinc: new FormControl({ value: this.alimento?.zinc ? this.alimento.zinc : null, disabled: this.soloLectura }),
      colesterol: new FormControl({ value: this.alimento?.colesterol ? this.alimento.colesterol : null, disabled: this.soloLectura }),
      fibra_dietetica: new FormControl({ value: this.alimento?.fibra_dietetica ? this.alimento.fibra_dietetica : null, disabled: this.soloLectura }),
      porciones: this.formBuilder.array(this.alimento?.porciones ? this.alimento.porciones.map(porcion => this.crearPorcion(porcion)) : [])
    });

    if (this.esNuevo) {
      this.agregarPorcion();
    }
  }
  
  crearPorcion(porcion?: Porcion): FormGroup {
    return this.formBuilder.group({
      porcion_id: new FormControl({value: porcion?.porcion_id ? porcion.porcion_id : 0, disabled: this.soloLectura}),
      nombre: new FormControl({value: porcion?.nombre ? porcion.nombre : null, disabled: this.soloLectura}, Validators.required),
      peso: new FormControl({value: porcion?.peso ? porcion.peso : null, disabled: this.soloLectura}, Validators.required),
    });
  }

  get porciones(): FormArray {
    return this.formAlimento.get('porciones') as FormArray;
  }
  
  agregarPorcion() {
    this.porciones.push(this.crearPorcion());
  }
  
  eliminarPorcion(index: number) {
    this.porciones.removeAt(index);
  }

  limpiarAlimento() {
    localStorage.removeItem('alimento');
    this.router.navigate(['/alimentos']);
  }
  
  guardarAlimento() {
    const body = this.formAlimento.getRawValue() as Alimento;
    this.loading= true;

    this._recetasService.createAlimento(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.router.navigate(['/alimentos'])
      },
      error: (err:any) => {
        this.loading= false;
        this.toastr.error('No se pudo guardar el alimento','Guardado');
      },
    });
  }

  validarPorciones(): boolean {
    return this.porciones.length > 0;
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    this.formAlimento.get('nombre')?.enable();
    this.formAlimento.get('genero')?.enable();
    this.formAlimento.get('apto_celiaco')?.enable();
    this.formAlimento.get('apto_vegetariano')?.enable();
    this.formAlimento.get('apto_vegano')?.enable();
    this.formAlimento.get('energia_kcal')?.enable();
    this.formAlimento.get('energia_kj')?.enable();
    this.formAlimento.get('proteinas')?.enable();
    this.formAlimento.get('carbohidratos_totales')?.enable();
    this.formAlimento.get('carbohidratos_disponibles')?.enable();
    this.formAlimento.get('grasa_total')?.enable();
    this.formAlimento.get('ac_grasos_monoinsaturados')?.enable();
    this.formAlimento.get('ac_grasos_poliinsaturados')?.enable();
    this.formAlimento.get('ac_grasos_saturados')?.enable();
    this.formAlimento.get('agua')?.enable();
    this.formAlimento.get('calcio')?.enable();
    this.formAlimento.get('cenizas')?.enable();
    this.formAlimento.get('fosforo')?.enable();
    this.formAlimento.get('hierro')?.enable();
    this.formAlimento.get('niacina')?.enable();
    this.formAlimento.get('numero')?.enable();
    this.formAlimento.get('potasio')?.enable();
    this.formAlimento.get('rivoflavina')?.enable();
    this.formAlimento.get('sodio')?.enable();
    this.formAlimento.get('tiamina')?.enable();
    this.formAlimento.get('vitamina_c')?.enable();
    this.formAlimento.get('zinc')?.enable();
    this.formAlimento.get('colesterol')?.enable();
    this.formAlimento.get('fibra_dietetica')?.enable();
  }

}
