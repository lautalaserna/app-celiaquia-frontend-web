import { Component } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router, RouterLink } from '@angular/router';
import { FormArray, FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ToastrService } from 'ngx-toastr';
import { SpinnerComponent } from '../../../shared/spinner/spinner.component';
import { CuestionarioService } from '../../../services/cuestionario.service';
import { Cuestionario, Respuesta } from '../../../interfaces/cuestionario';

@Component({
  selector: 'app-cuestionario-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink, SpinnerComponent],
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

    // Borrar este hardcode :)
    this.cuestionario = {
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
    }

    this.crearForm();
  }

  crearForm() {
    this.formCuestionario = this.formBuilder.group({
      cuestionario_id: new FormControl({value: this.cuestionario?.cuestionario_id ? this.cuestionario.cuestionario_id : 0, disabled: true}),
      pregunta: new FormControl({value: this.cuestionario?.pregunta ? this.cuestionario.pregunta : null, disabled: this.soloLectura}, [Validators.required, Validators.maxLength(200)]),
      isactive: new FormControl({value: this.cuestionario?.isactive ? this.cuestionario.isactive : true, disabled: true}),
      posicion: new FormControl({value: this.cuestionario?.posicion ? this.cuestionario.posicion : 0, disabled: true}),
      respuestas: this.formBuilder.array(this.cuestionario?.respuestas ? this.cuestionario.respuestas.map(respuesta => this.crearRespuesta(respuesta)) : [])
    });
  }
  
  crearRespuesta(respuesta?: Respuesta): FormGroup {
    return this.formBuilder.group({
      respuesta_id: new FormControl(respuesta?.respuesta_id || 0),
      descripcion: new FormControl(respuesta?.descripcion || '', Validators.required)
    });
  }
  
  get respuestas(): FormArray {
    return this.formCuestionario.get('respuestas') as FormArray;
  }
  
  agregarRespuesta() {
    this.respuestas.push(this.crearRespuesta());
  }
  
  eliminarRespuesta(index: number) {
    this.respuestas.removeAt(index);
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
    this.formCuestionario.get('titulo')?.enable();
    this.formCuestionario.get('descripcion')?.enable();
  }

}
