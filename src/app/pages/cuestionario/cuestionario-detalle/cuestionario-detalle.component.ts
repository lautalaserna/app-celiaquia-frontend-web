import { Component } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router, RouterLink } from '@angular/router';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ToastrService } from 'ngx-toastr';
import { CuestionarioService } from '../../../services/cuestionario.service';
import { Cuestionario, Opcion } from '../../../interfaces/cuestionario';

@Component({
  selector: 'app-cuestionario-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink],
  templateUrl: './cuestionario-detalle.component.html',
  styleUrl: './cuestionario-detalle.component.css'
})
export class CuestionarioDetalleComponent {
  cuestionario!: Cuestionario;
  formCuestionario!: FormGroup;
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private router: Router,
    private route: ActivatedRoute,
    private _cuestionarioService: CuestionarioService
  ){}

  ngOnInit() {
    const id = this.route.snapshot.queryParamMap.get('id');

    if(id){
      this.soloLectura = true;
      this.cuestionario = this.route.snapshot.data['cuestionario'];
    } else {
      this.esNuevo = true;
    }

    this.crearForm();
  }

  crearForm() {
    this.formCuestionario = this.formBuilder.group({
      cuestionario_id: new FormControl({value: this.cuestionario?.cuestionario_id ? this.cuestionario.cuestionario_id : 0, disabled: true}),
      pregunta: new FormControl({value: this.cuestionario?.pregunta ? this.cuestionario.pregunta : null, disabled: this.soloLectura}, [Validators.required, Validators.maxLength(200)]),
      //isactive: new FormControl({value: this.cuestionario?.isactive ? this.cuestionario.isactive : true, disabled: true}),
      posicion: new FormControl({value: this.cuestionario?.posicion ? this.cuestionario.posicion : 0, disabled: true}),
      opciones: this.formBuilder.array(this.cuestionario?.opciones ? this.cuestionario.opciones.map(opcion => this.crearOpciones(opcion)) : [])
    });
  }
  
  crearOpciones(opcion?: Opcion): FormGroup {
    return this.formBuilder.group({
      opcion_id: new FormControl({value: opcion?.opcion_id ? opcion.opcion_id : 0, disabled: this.soloLectura}),
      opcion: new FormControl({value: opcion?.opcion ? opcion.opcion : null, disabled: this.soloLectura}, Validators.required)
    });
  }
  
  get opciones(): FormArray {
    return this.formCuestionario.get('opciones') as FormArray;
  }
  
  agregarOpcion() {
    this.opciones.push(this.crearOpciones());
  }
  
  eliminarOpcion(index: number) {
    this.opciones.removeAt(index);
  }

  limpiarCuestionario() {
    localStorage.removeItem('cuestionario');
    this.router.navigate(['/cuestionario']);
  }
  
  guardarCuestionario() {
    const body = this.formCuestionario.getRawValue() as Cuestionario;
    this.loading= true;

   this._cuestionarioService.createCuestionario(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.router.navigate(['/cuestionario'])
      },
      error: (err:any) => {
        this.loading= false;
        this.toastr.error('No se pudo guardar la pregunta','Guardado');
      },
    });
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    this.formCuestionario.get('pregunta')?.enable();
    this.formCuestionario.get('opciones')?.enable();
  }

}
