import { Component } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router, RouterLink } from '@angular/router';
import { CuidadoHogar } from '../../../interfaces/cuidados';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { CuidadosService } from '../../../services/cuidados.service';
import { ToastrService } from 'ngx-toastr';
import { SpinnerComponent } from '../../../shared/spinner/spinner.component';

@Component({
  selector: 'app-cuidado-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink, SpinnerComponent],
  templateUrl: './cuidado-detalle.component.html',
  styleUrl: './cuidado-detalle.component.css'
})
export class CuidadoDetalleComponent {
  cuidadoHogar!: CuidadoHogar;
  formCuidados!: FormGroup;
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
      // Obtener el cuidadoHogar
      //this.cuidadoHogar = this.route.snapshot.data['cuidadoHogar'];

      this.cuidadoHogar = { 
        id: 1, 
        titulo: 'Item 1', 
        descripcion: 'Descripción del Item 1' 
      };
    }

    this.crearForm();
  }

  crearForm() {
    this.formCuidados = this.formBuilder.group({
      id: new FormControl({value: this.cuidadoHogar?.id, disabled: true}),
      titulo: new FormControl({value: this.cuidadoHogar?.titulo , disabled: this.soloLectura}, [Validators.required, Validators.maxLength(200)]),
      descripcion: new FormControl({value: this.cuidadoHogar?.descripcion, disabled: this.soloLectura}, [Validators.required, Validators.maxLength(2000)]),
    })
  }

  limpiarCuidado() {
    localStorage.removeItem('itemData');
    this.router.navigate(['/cuidados'])
  }

  guardarCuidado() {
    const body = this.formCuidados.getRawValue() as CuidadoHogar;
    console.log(body);

    this.router.navigate(['/cuidados']);
  }

  crearNuevoCuidado() {
    this.loading= true;
    let body = this.formCuidados.getRawValue() as CuidadoHogar;
    console.log(body);

    this._cuidadosService.createCuidadoHogar(body).subscribe({
      next: (data: CuidadoHogar) => {
        this.cuidadoHogar = data;
        this.crearItemSuccess();
      },
      error: (err:any) => {
        console.error(err);
        this.crearItemFail();
      },
    });
  }

  crearItemSuccess() {
    this.loading= false;
    this.router.navigate(['/cuidados'])
  }

  crearItemFail() {
    this.toastr.error('Error. No se pudo crear el ítem');
    this.loading= false;
  }

  toggleEnEdicion(){
    this.soloLectura = !this.soloLectura;
    this.formCuidados.get('titulo')?.enable();
    this.formCuidados.get('descripcion')?.enable();
  }

}
