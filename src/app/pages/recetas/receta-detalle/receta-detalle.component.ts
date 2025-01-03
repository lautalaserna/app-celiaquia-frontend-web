import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Ingrediente, Receta } from '../../../interfaces/recetas';
import { RecetasService } from '../../../services/recetas.service';
import { ModalIngredienteComponent } from './modal-ingrediente/modal-ingrediente.component';

@Component({
  selector: 'app-receta-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, ModalIngredienteComponent],
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
      this.receta = this.route.snapshot.data['receta'];
    } else {
      this.esNuevo = true;
    }

    this.crearForm();
    this.recalcularDatos();
  }

  crearForm() {
    this.formReceta = this.formBuilder.group({
      receta_id: new FormControl({ value: this.receta?.receta_id || 0, disabled: true }),
      titulo: new FormControl({ value: this.receta?.titulo || null, disabled: false }, [Validators.required, Validators.maxLength(200)]),
      preparacion: new FormControl({ value: this.receta?.preparacion || null, disabled: false }, [Validators.required, Validators.maxLength(1000)]),
      apto_vegetariano: new FormControl({ value: this.receta?.apto_vegetariano || false, disabled: this.soloLectura }),
      apto_vegano: new FormControl({ value: this.receta?.apto_vegano || false, disabled: this.soloLectura }),
      energia_total_kcal: new FormControl({ value: this.receta?.energia_total_kcal || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      energia_total_kj: new FormControl({ value: this.receta?.energia_total_kj || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      proteinas_totales: new FormControl({ value: this.receta?.proteinas_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      carbohidratos_totales: new FormControl({ value: this.receta?.carbohidratos_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      grasas_totales: new FormControl({ value: this.receta?.grasas_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      imagen: new FormControl({value: this.receta?.imagen ? this.receta.imagen : null, disabled: false}),
      ingredientes: this.formBuilder.array(this.receta?.ingredientes ? this.receta.ingredientes.map(i => this.crearIngrediente(i)) : [])
    });
  }

  crearIngrediente(ingrediente?: Ingrediente): FormGroup {
    return this.formBuilder.group({
      ingrediente_id: new FormControl({ value: ingrediente?.ingrediente_id || 0, disabled: true }),
      alimento: new FormControl({ value: ingrediente?.alimento || null, disabled: false }, Validators.required),
      porcion: new FormControl({ value: ingrediente?.porcion || null, disabled: false }, Validators.required),
      cantidad: new FormControl({ value: ingrediente?.cantidad || 0, disabled: false }, [Validators.required, Validators.min(0.1)]),
    });
  }

  get ingredientes(): FormArray {
    return this.formReceta.get('ingredientes') as FormArray;
  }

  abrirModalIngrediente() {
    this.mostrarModal = true;
  }

  agregarIngredienteSeleccionado(ingrediente: Ingrediente) {
    console.log(ingrediente);
    this.ingredientes.push(this.crearIngrediente(ingrediente));
    this.mostrarModal = false;
    this.recalcularDatos();
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
    const receta = this.crearReceta(body);

    this._recetasService.createReceta(receta).subscribe({
      next: (data) => {
        this.loading = false;
        this.router.navigate(['/recetas']);
      },
      error: (err: any) => {
        this.loading = false;
        this.toastr.error('No se pudo guardar la receta', 'Guardado');
      },
    });
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
            this.formReceta.patchValue({ imagen: base64String });
        };
        reader.readAsDataURL(file);
    }
  }

  recalcularDatos() {
    let energiaKcal: number = 0;
    let energiaKj: number = 0;
    let proteinas_totales: number = 0;
    let carbohidratos_totales: number = 0;
    let grasas_totales: number = 0;

    this.ingredientes.controls.forEach(ingrediente => {
      const alimento = ingrediente.value.alimento;
      const cantidad = ingrediente.value.cantidad;
      const porcionRate = ingrediente.value.peso ? ingrediente.value.peso / 100 : 1;

      energiaKcal += (alimento.energia_kcal ?? 0) * cantidad * porcionRate;
      energiaKj += (alimento.energia_kj ?? 0) * cantidad * porcionRate;
      proteinas_totales += (alimento.proteinas ?? 0) * cantidad * porcionRate;
      grasas_totales += (alimento.grasa_total ?? 0) * cantidad * porcionRate;
      carbohidratos_totales += (alimento.carbohidratos_totales ?? 0) * cantidad * porcionRate;
    });

    this.formReceta.get('energia_total_kcal')?.setValue(energiaKcal.toFixed(2));
    this.formReceta.get('energia_total_kj')?.setValue(energiaKj.toFixed(2));
    this.formReceta.get('proteinas_totales')?.setValue(proteinas_totales.toFixed(2));
    this.formReceta.get('carbohidratos_totales')?.setValue(carbohidratos_totales.toFixed(2));
    this.formReceta.get('grasas_totales')?.setValue(grasas_totales.toFixed(2));
  }

  crearReceta(body: any): Receta {
    const ingredientes = body.ingredientes.map((ing: Ingrediente) => ({
      ingrediente_id: ing.ingrediente_id,
      cantidad: ing.cantidad,
      porcion_id: ing.porcion?.porcion_id || 0,
    }));
  
    const receta: Receta = {
      receta_id: body.receta_id,
      titulo: body.titulo,
      imagen: body.imagen,
      preparacion: body.preparacion,
      apto_vegetariano: body.apto_vegetariano,
      apto_vegano: body.apto_vegano,
      energia_total_kcal: body.energia_total_kcal,
      energia_total_kj: body.energia_total_kj,
      proteinas_totales: body.proteinas_totales,
      carbohidratos_totales: body.carbohidratos_totales,
      grasas_totales: body.grasas_totales,
      ingredientes: ingredientes,
    };
  
    return receta;
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    this.formReceta.get('apto_vegetariano')?.enable();
    this.formReceta.get('apto_vegano')?.enable();
  }
}
