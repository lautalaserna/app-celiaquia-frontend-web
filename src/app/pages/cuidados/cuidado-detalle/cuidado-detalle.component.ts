import { Component } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router, RouterLink } from '@angular/router';
import { CuidadoHogar } from '../../../interfaces/cuidados';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { CuidadosService } from '../../../services/cuidados.service';
import { ToastrService } from 'ngx-toastr';
import { FooterComponent } from '../../../shared/footer/footer.component';

@Component({
  selector: 'app-cuidado-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink, FooterComponent],
  templateUrl: './cuidado-detalle.component.html',
  styleUrl: './cuidado-detalle.component.css'
})
export class CuidadoDetalleComponent {
  cuidadoHogar!: CuidadoHogar;
  formCuidados!: FormGroup;
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private router: Router,
    private route: ActivatedRoute,
    private _cuidadosService: CuidadosService
  ){}

  ngOnInit() {
    const id = this.route.snapshot.queryParamMap.get('id');

    if(id){
      this.soloLectura = true;
      this.cuidadoHogar = this.route.snapshot.data['cuidadoHogar'];
    } else {
      this.esNuevo = true;
    }

    this.crearForm();
  }

  crearForm() {
    this.formCuidados = this.formBuilder.group({
      cuidado_id: new FormControl({value: this.cuidadoHogar?.cuidado_id ? this.cuidadoHogar.cuidado_id : 0, disabled: true}),
      titulo: new FormControl({value: this.cuidadoHogar?.titulo ? this.cuidadoHogar.titulo : null, disabled: false}, [Validators.required, Validators.maxLength(200)]),
      descripcion: new FormControl({value: this.cuidadoHogar?.descripcion ? this.cuidadoHogar.descripcion : null, disabled: false}, [Validators.required, Validators.maxLength(2000)]),
      //isactive: new FormControl({value: this.cuidadoHogar?.isactive ? this.cuidadoHogar.isactive : true, disabled: true}),
      posicion: new FormControl({value: this.cuidadoHogar?.posicion ? this.cuidadoHogar.posicion : 0, disabled: true}),
    })
  }

  limpiarCuidado() {
    localStorage.removeItem('cuidadoHogar');
    this.router.navigate(['/cuidados']);
  }
  
  guardarCuidado() {
    const body = this.formCuidados.getRawValue() as CuidadoHogar;
    this.loading= true;

    this._cuidadosService.createCuidadoHogar(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.router.navigate(['/cuidados'])
      },
      error: (err:any) => {
        this.loading= false;
        if(err && err.message) {
          this.toastr.error(err.message,'Guardado');
        } else {
          this.toastr.error('No se pudo guardar el cuidado','Guardado');
        }
      },
    });
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    /* this.formCuidados.get('titulo')?.enable();
    this.formCuidados.get('descripcion')?.enable(); */
  }

}
