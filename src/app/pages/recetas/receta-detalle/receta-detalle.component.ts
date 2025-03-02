import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { DificultadReceta, Ingrediente, Receta } from '../../../interfaces/recetas';
import { RecetasService } from '../../../services/recetas.service';
import { ModalIngredienteComponent } from './modal-ingrediente/modal-ingrediente.component';
import { FooterComponent } from '../../../shared/footer/footer.component';

@Component({
  selector: 'app-receta-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, ModalIngredienteComponent, FooterComponent],
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
  listDificultad: string[] = Object.values(DificultadReceta);

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
  }

  crearForm() {
    this.formReceta = this.formBuilder.group({
      receta_id: new FormControl({ value: this.receta?.receta_id || 0, disabled: true }),
      titulo: new FormControl({ value: this.receta?.titulo || null, disabled: false }, [Validators.required, Validators.maxLength(50)]),
      descripcion: new FormControl({ value: this.receta?.descripcion || null, disabled: false }, [Validators.required, Validators.maxLength(100)]),
      tiempo_preparacion: new FormControl({ value: this.receta?.tiempo_preparacion || null, disabled: false }, [Validators.required, Validators.min(0)]),
      tiempo_coccion: new FormControl({ value: this.receta?.tiempo_coccion || null, disabled: false }, [Validators.required, Validators.min(0)]),
      dificultad: new FormControl({ value: this.receta?.dificultad ? this.receta.dificultad : null, disabled: this.soloLectura }, [Validators.required]),
      isbalanceado: new FormControl({ value: this.receta?.isbalanceado || false, disabled: this.soloLectura }),
      cant_raciones: new FormControl({ value: this.receta?.cant_raciones || 1, disabled: false }, [Validators.required, Validators.min(1)]),
      nombre_racion: new FormControl({ value: this.receta?.nombre_racion || 'Plato', disabled: false }, [Validators.required, Validators.maxLength(30)]),
      preparacion: new FormControl({ value: this.receta?.preparacion || null, disabled: false }, [Validators.required, Validators.maxLength(1000)]),
      autocalcular: new FormControl({ value: this.receta?.autocalcular, disabled: this.soloLectura }),
      apto_vegetariano: new FormControl({ value: this.receta?.apto_vegetariano || false, disabled: this.soloLectura }),
      apto_vegano: new FormControl({ value: this.receta?.apto_vegano || false, disabled: this.soloLectura }),
      calorias_totales: new FormControl({ value: this.receta?.calorias_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      proteinas_totales: new FormControl({ value: this.receta?.proteinas_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      carbohidratos_totales: new FormControl({ value: this.receta?.carbohidratos_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      grasas_totales: new FormControl({ value: this.receta?.grasas_totales || 0, disabled: true }, [Validators.required, Validators.min(0)]),
      imagen: new FormControl(this.receta?.imagen || null),
      ingredientes: this.formBuilder.array(this.receta?.ingredientes ? this.receta.ingredientes.map(i => this.crearIngrediente(i)) : [])
    });

    if (this.formReceta.get('imagen')?.value) {
      this.imagenUrl = this.formReceta.get('imagen')?.value;
    }

    if(!this.formReceta.get('autocalcular')?.value) {
      this.formReceta.get('calorias_totales')?.enable();
      this.formReceta.get('proteinas_totales')?.enable();
      this.formReceta.get('carbohidratos_totales')?.enable();
      this.formReceta.get('grasas_totales')?.enable();
    }
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
    this.ingredientes.push(this.crearIngrediente(ingrediente));
    this.mostrarModal = false;
    if(this.formReceta.get('autocalcular')?.value) this.recalcularDatos();
    this.toastr.success('Ingrediente agregado con éxito!');
  }

  eliminarIngrediente(index: number) {
    this.ingredientes.removeAt(index);
    if(this.formReceta.get('autocalcular')?.value) this.recalcularDatos();
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
    if(!this.formReceta.get('autocalcular')?.value) return;
    
    let energiaKcal: number = 0;
    let proteinas_totales: number = 0;
    let carbohidratos_totales: number = 0;
    let grasas_totales: number = 0;
  
    this.ingredientes.controls.forEach(ingrediente => {
      const alimento = ingrediente.value.alimento;
      const cantidad = ingrediente.value.cantidad;
      const porcionRate = ingrediente.value.porcion.peso ? ingrediente.value.porcion.peso / 100 : 1;
  
      energiaKcal += (alimento.energia_kcal ?? 0) * cantidad * porcionRate;
      proteinas_totales += (alimento.proteinas ?? 0) * cantidad * porcionRate;
      grasas_totales += (alimento.grasa_total ?? 0) * cantidad * porcionRate;
      carbohidratos_totales += (alimento.carbohidratos_totales ?? 0) * cantidad * porcionRate;
    });
  
    const cantRaciones = this.formReceta.get('cant_raciones')?.value || 1;
    const divisor = cantRaciones > 0 ? cantRaciones : 1;
  
    const caloriasPorRacion = energiaKcal / divisor;
    const proteinasPorRacion = proteinas_totales / divisor;
    const carbohidratosPorRacion = carbohidratos_totales / divisor;
    const grasasPorRacion = grasas_totales / divisor;

    this.formReceta.get('calorias_totales')?.setValue(caloriasPorRacion.toFixed(2));
    this.formReceta.get('proteinas_totales')?.setValue(proteinasPorRacion.toFixed(2));
    this.formReceta.get('carbohidratos_totales')?.setValue(carbohidratosPorRacion.toFixed(2));
    this.formReceta.get('grasas_totales')?.setValue(grasasPorRacion.toFixed(2));
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
      descripcion: body.descripcion,
      dificultad: body.dificultad,
      tiempo_preparacion: body.tiempo_preparacion,
      tiempo_coccion: body.tiempo_coccion,
      isbalanceado: body.isbalanceado,
      cant_raciones: body.cant_raciones,
      nombre_racion: body.nombre_racion,
      preparacion: body.preparacion,
      autocalcular: body.autocalcular,
      apto_vegetariano: body.apto_vegetariano,
      apto_vegano: body.apto_vegano,
      calorias_totales: body.calorias_totales,
      proteinas_totales: body.proteinas_totales,
      carbohidratos_totales: body.carbohidratos_totales,
      grasas_totales: body.grasas_totales,
      ingredientes: ingredientes,
    };
  
    return receta;
  }

  toggleAutocalcular() {
    if (this.formReceta.get('autocalcular')?.value) {
      this.formReceta.get('calorias_totales')?.disable();
      this.formReceta.get('proteinas_totales')?.disable();
      this.formReceta.get('carbohidratos_totales')?.disable();
      this.formReceta.get('grasas_totales')?.disable();
      this.recalcularDatos();
    } else {
      this.formReceta.get('calorias_totales')?.enable();
      this.formReceta.get('proteinas_totales')?.enable();
      this.formReceta.get('carbohidratos_totales')?.enable();
      this.formReceta.get('grasas_totales')?.enable();
    }
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    this.formReceta.get('apto_vegetariano')?.enable();
    this.formReceta.get('apto_vegano')?.enable();
    this.formReceta.get('dificultad')?.enable();
    this.formReceta.get('autocalcular')?.enable();
  }
}
