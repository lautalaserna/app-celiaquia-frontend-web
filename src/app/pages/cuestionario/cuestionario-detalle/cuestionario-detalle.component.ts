import { Component } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router, RouterLink } from '@angular/router';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
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

  respuestas: Respuesta[] = [];

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
      isactive: new FormControl({value: this.cuestionario?.isactive ? this.cuestionario.isactive : true, disabled: true}),
      posicion: new FormControl({value: this.cuestionario?.posicion ? this.cuestionario.posicion : 0, disabled: true}),
    })
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
