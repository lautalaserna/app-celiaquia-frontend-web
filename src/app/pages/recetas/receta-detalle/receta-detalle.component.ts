import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Ingrediente, Receta } from '../../../interfaces/recetas';
import { RecetasService } from '../../../services/recetas.service';

@Component({
  selector: 'app-receta-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink],
  templateUrl: './receta-detalle.component.html',
  styleUrl: './receta-detalle.component.css'
})
export class RecetaDetalleComponent {
  receta!: Receta;
  formReceta!: FormGroup;
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
      this.receta = this.route.snapshot.data['receta'];
      console.log(this.receta);
    } else {
      this.esNuevo = true;
    }

    this.crearForm();
  }

  crearForm() {
    this.formReceta = this.formBuilder.group({
      receta_id: new FormControl({ value: this.receta?.receta_id ? this.receta.receta_id : 0, disabled: true }),
      titulo: new FormControl({ value: this.receta?.titulo ? this.receta.titulo : null, disabled: this.soloLectura }, [Validators.required, Validators.maxLength(200)]),
      preparación: new FormControl({ value: this.receta?.preparacion ? this.receta.preparacion : null, disabled: this.soloLectura }, [Validators.required, Validators.maxLength(1000)]),
      
      caloriasTotales: new FormControl({ value: this.receta?.caloriasTotales ? this.receta.caloriasTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      proteinasTotales: new FormControl({ value: this.receta?.proteinasTotales ? this.receta.proteinasTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      carbohidratosTotales: new FormControl({ value: this.receta?.carbohidratosTotales ? this.receta.carbohidratosTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
  
      grasasTotales: new FormControl({ value: this.receta?.grasasTotales ? this.receta.grasasTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      grasasSaturadasTotales: new FormControl({ value: this.receta?.grasasSaturadasTotales ? this.receta.grasasSaturadasTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      grasasMonoinsaturadasTotales: new FormControl({ value: this.receta?.grasasMonoinsaturadasTotales ? this.receta.grasasMonoinsaturadasTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      grasasPoliinsaturadasTotales: new FormControl({ value: this.receta?.grasasPoliinsaturadasTotales ? this.receta.grasasPoliinsaturadasTotales : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
  
      fibraTotal: new FormControl({ value: this.receta?.fibraTotal ? this.receta.fibraTotal : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      sodioTotal: new FormControl({ value: this.receta?.sodioTotal ? this.receta.sodioTotal : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
      colesterolTotal: new FormControl({ value: this.receta?.colesterolTotal ? this.receta.colesterolTotal : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0)]),
  
      ingredientes: this.formBuilder.array(this.receta?.ingredientes ? this.receta.ingredientes.map(ingrediente => this.crearIngrediente(ingrediente)) : [])
    });
  }
  
  crearIngrediente(ingrediente?: Ingrediente): FormGroup {
    return this.formBuilder.group({
      ingrediente_id: new FormControl({ value: ingrediente?.ingrediente_id ? ingrediente.ingrediente_id : 0, disabled: this.soloLectura }),
      alimento: new FormControl({ value: ingrediente?.alimento ? ingrediente.alimento : null, disabled: this.soloLectura }, Validators.required),
      cantidad: new FormControl({ value: ingrediente?.cantidad ? ingrediente.cantidad : 0, disabled: this.soloLectura }, [Validators.required, Validators.min(0.1)])
    });
  }
  
  get ingredientes(): FormArray {
    return this.formReceta.get('ingredientes') as FormArray;
  }
  
  agregarIngrediente() {
    this.ingredientes.push(this.crearIngrediente());
  }
  
  eliminarIngrediente(index: number) {
    this.ingredientes.removeAt(index);
  }  

  limpiarCuestionario() {
    localStorage.removeItem('receta');
    this.router.navigate(['/recetas']);
  }
  
  guardarCuestionario() {
    const body = this.formReceta.getRawValue() as Receta;
    this.loading= true;

   this._recetasService.createReceta(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.router.navigate(['/recetas'])
      },
      error: (err:any) => {
        this.loading= false;
        this.toastr.error('No se pudo guardar la receta','Guardado');
      },
    });
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    //this.formCuestionario.get('pregunta')?.enable();
    //this.formCuestionario.get('opciones')?.enable();
  }
}
