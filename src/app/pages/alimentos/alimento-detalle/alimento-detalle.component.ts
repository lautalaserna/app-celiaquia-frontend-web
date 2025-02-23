import { Component } from '@angular/core';
import { Accesibilidad, Alimento, Porcion, TipoAlimento, ValoracionAlimento } from '../../../interfaces/recetas';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { ActivatedRoute, Router } from '@angular/router';
import { RecetasService } from '../../../services/recetas.service';
import { CommonModule } from '@angular/common';
import { FooterComponent } from '../../../shared/footer/footer.component';

@Component({
  selector: 'app-alimento-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FooterComponent],
  templateUrl: './alimento-detalle.component.html',
  styleUrl: './alimento-detalle.component.css'
})
export class AlimentoDetalleComponent {
  alimento!: Alimento;
  formAlimento!: FormGroup;
  listTipoAlimento: string[] = Object.values(TipoAlimento);
  listAccesibilidad: string[] = Object.values(Accesibilidad);
  listValoracionAlimento: string[] = Object.values(ValoracionAlimento);
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;
  imagenUrl: string | null = null;

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
      nombre: new FormControl({ value: this.alimento?.nombre ? this.alimento.nombre : null, disabled: false }, [Validators.required, Validators.maxLength(200)]),
      genero: new FormControl({ value: this.alimento?.genero ? this.alimento.genero : null, disabled: false }),
      tipo: new FormControl({ value: this.alimento?.tipo ? this.alimento.tipo : null, disabled: this.soloLectura }, [Validators.required]),
      valoracion: new FormControl({ value: this.alimento?.valoracion ? this.alimento.valoracion : null, disabled: this.soloLectura }, [Validators.required]),
      accesibilidad: new FormControl({ value: this.alimento?.accesibilidad ? this.alimento.accesibilidad : null, disabled: this.soloLectura }, [Validators.required]),
      apto_celiaco: new FormControl({ value: this.alimento?.apto_celiaco ? this.alimento.apto_celiaco : false, disabled: this.soloLectura }),
      apto_vegetariano: new FormControl({ value: this.alimento?.apto_vegetariano ? this.alimento.apto_vegetariano : false, disabled: this.soloLectura }),
      is_procesado: new FormControl({ value: this.alimento?.is_procesado ? this.alimento.is_procesado : false, disabled: this.soloLectura }),
      preparacion: new FormControl({value: this.alimento?.preparacion ? this.alimento.preparacion : null, disabled: false}, [Validators.maxLength(2000)]),
      apto_vegano: new FormControl({ value: this.alimento?.apto_vegano ? this.alimento.apto_vegano : false, disabled: this.soloLectura }),
      imagen: new FormControl(this.alimento?.imagen || null),
      energia_kcal: new FormControl({ value: this.alimento?.energia_kcal ? this.alimento.energia_kcal : 0, disabled: false }, [Validators.required]),
      energia_kj: new FormControl({ value: this.alimento?.energia_kj ? this.alimento.energia_kj : 0, disabled: false }, [Validators.required]),
      proteinas: new FormControl({ value: this.alimento?.proteinas ? this.alimento.proteinas : 0, disabled: false }, [Validators.required]),
      carbohidratos_totales: new FormControl({ value: this.alimento?.carbohidratos_totales ? this.alimento.carbohidratos_totales : 0, disabled: false }, [Validators.required]),
      carbohidratos_disponibles: new FormControl({ value: this.alimento?.carbohidratos_disponibles ? this.alimento.carbohidratos_disponibles : 0, disabled: false }, [Validators.required]),
      grasa_total: new FormControl({ value: this.alimento?.grasa_total ? this.alimento.grasa_total : 0, disabled: false }, [Validators.required]),
      ac_grasos_monoinsaturados: new FormControl({ value: this.alimento?.ac_grasos_monoinsaturados ? this.alimento.ac_grasos_monoinsaturados : 0, disabled: false }, [Validators.required]),
      ac_grasos_poliinsaturados: new FormControl({ value: this.alimento?.ac_grasos_poliinsaturados ? this.alimento.ac_grasos_poliinsaturados : 0, disabled: false }, [Validators.required]),
      ac_grasos_saturados: new FormControl({ value: this.alimento?.ac_grasos_saturados ? this.alimento.ac_grasos_saturados : 0, disabled: false }, [Validators.required]),
      grasas_trans: new FormControl({ value: this.alimento?.grasas_trans ? this.alimento.grasas_trans : 0, disabled: false }, [Validators.required]),
      agua: new FormControl({ value: this.alimento?.agua ? this.alimento.agua : null, disabled: false }),
      calcio: new FormControl({ value: this.alimento?.calcio ? this.alimento.calcio : null, disabled: false }),
      cenizas: new FormControl({ value: this.alimento?.cenizas ? this.alimento.cenizas : null, disabled: false }),
      fosforo: new FormControl({ value: this.alimento?.fosforo ? this.alimento.fosforo : null, disabled: false }),
      hierro: new FormControl({ value: this.alimento?.hierro ? this.alimento.hierro : null, disabled: false }),
      niacina: new FormControl({ value: this.alimento?.niacina ? this.alimento.niacina : null, disabled: false }),
      numero: new FormControl({ value: this.alimento?.numero ? this.alimento.numero : null, disabled: false }),
      potasio: new FormControl({ value: this.alimento?.potasio ? this.alimento.potasio : null, disabled: false }),
      rivoflavina: new FormControl({ value: this.alimento?.rivoflavina ? this.alimento.rivoflavina : null, disabled: false }),
      sodio: new FormControl({ value: this.alimento?.sodio ? this.alimento.sodio : null, disabled: false }),
      tiamina: new FormControl({ value: this.alimento?.tiamina ? this.alimento.tiamina : null, disabled: false }),
      vitamina_c: new FormControl({ value: this.alimento?.vitamina_c ? this.alimento.vitamina_c : null, disabled: false }),
      zinc: new FormControl({ value: this.alimento?.zinc ? this.alimento.zinc : null, disabled: false }),
      colesterol: new FormControl({ value: this.alimento?.colesterol ? this.alimento.colesterol : null, disabled: false }),
      fibra_dietetica: new FormControl({ value: this.alimento?.fibra_dietetica ? this.alimento.fibra_dietetica : null, disabled: false }),
      porciones: this.formBuilder.array(this.alimento?.porciones ? this.alimento.porciones.map(porcion => this.crearPorcion(porcion)) : [])
    });

    if (this.formAlimento.get('imagen')?.value) {
      this.imagenUrl = this.formAlimento.get('imagen')?.value;
    }

    if (this.esNuevo) {
      this.agregarPorcion();
    }
  }
  
  crearPorcion(porcion?: Porcion): FormGroup {
    return this.formBuilder.group({
      porcion_id: new FormControl({value: porcion?.porcion_id ? porcion.porcion_id : 0, disabled: false}),
      nombre: new FormControl({value: porcion?.nombre ? porcion.nombre : null, disabled: false}, Validators.required),
      peso: new FormControl({value: porcion?.peso ? porcion.peso : null, disabled: false}, Validators.required),
    });
  }

  get porciones(): FormArray {
    return this.formAlimento.get('porciones') as FormArray;
  }
  
  agregarPorcion() {
    this.porciones.push(this.crearPorcion({
      porcion_id: 0,
      nombre: 'Gramo',
      peso: 1,
    }));
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
    this.formAlimento.get('tipo')?.enable();
    this.formAlimento.get('accesibilidad')?.enable();
    this.formAlimento.get('valoracion')?.enable();
    this.formAlimento.get('apto_celiaco')?.enable();
    this.formAlimento.get('apto_vegetariano')?.enable();
    this.formAlimento.get('apto_vegano')?.enable();
    this.formAlimento.get('is_procesado')?.enable();
  }

  onFileChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length) {
        const file = input.files[0];
        if (file.size > 1048576) {
            this.toastr.error('La imagen es super el tamaño máximo de 1Mb', 'Error');
            return;
        }
        const reader = new FileReader();
        reader.onload = () => {
            const base64String = reader.result as string;
            this.imagenUrl = base64String; 
            this.formAlimento.patchValue({ imagen: base64String });
        };
        reader.readAsDataURL(file);
    }
  }
}
