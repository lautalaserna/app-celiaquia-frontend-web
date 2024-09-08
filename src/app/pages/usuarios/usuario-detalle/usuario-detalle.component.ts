import { Component } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router, RouterLink } from '@angular/router';
import { CuidadoHogar } from '../../../interfaces/cuidados';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { ToastrService } from 'ngx-toastr';
import { Usuario } from '../../../interfaces/user';
import { AdminService } from '../../../services/admin.service';

@Component({
  selector: 'app-usuario-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterLink],
  templateUrl: './usuario-detalle.component.html',
  styleUrl: './usuario-detalle.component.css'
})
export class UsuarioDetalleComponent {
  usuario!: Usuario;
  formUsuarios!: FormGroup;
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private router: Router,
    private route: ActivatedRoute,
    private _adminService: AdminService
  ){}

  ngOnInit() {
    const id = this.route.snapshot.queryParamMap.get('id');

    if(id){
      this.soloLectura = true;
      this.usuario = this.route.snapshot.data['usuario'];
      console.log(this.usuario);
      
    } else {
      this.esNuevo = true;
    }

    this.crearForm();
  }

  crearForm() {
    this.formUsuarios = this.formBuilder.group({
      usuario_id: new FormControl({value: this.usuario?.usuario_id ? this.usuario.usuario_id : 0, disabled: true}, [Validators.required, Validators.maxLength(200)]),
      nombre: new FormControl({value: this.usuario?.nombre ? this.usuario.nombre : null, disabled: true}, [Validators.required, Validators.maxLength(200)]),
      apellido: new FormControl({value: this.usuario?.apellido ? this.usuario.apellido : null, disabled: true}, [Validators.required, Validators.maxLength(200)]),
      dni: new FormControl({value: this.usuario?.dni ? this.usuario.dni : null, disabled: true}, [Validators.required, Validators.minLength(8), Validators.maxLength(8), Validators.pattern(/^\d{8}$/)]),
      fnac: new FormControl({value: this.usuario?.fnac ? this.usuario.fnac : null, disabled: true}, [Validators.required]),
      email: new FormControl({value: this.usuario?.email ? this.usuario.email : null, disabled: true}, [Validators.required, Validators.email, Validators.maxLength(200)]),
      username: new FormControl({value: this.usuario?.username ? this.usuario.username : null, disabled: true}, [Validators.required, Validators.maxLength(200)]),
      password: new FormControl({value: null, disabled: true}, [Validators.minLength(8), Validators.maxLength(200)]),
      confirmPassword: new FormControl({value: null, disabled: true}, [Validators.minLength(8), Validators.maxLength(200)]),
    });
  }  

  limpiarCuidado() {
    localStorage.removeItem('usuario');
    this.router.navigate(['/usuarios']);
  }
  
  guardarCuidado() {
    const body = this.formUsuarios.getRawValue() as Usuario;
    this.loading= true;

    this._adminService.createUsuario(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.router.navigate(['/usuarios'])
      },
      error: (err:any) => {
        this.loading= false;
        this.toastr.error('No se pudo guardar el usuario','Guardado');
      },
    });
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
    this.formUsuarios.get('nombre')?.enable();
    this.formUsuarios.get('apellido')?.enable();
    this.formUsuarios.get('dni')?.enable();
    this.formUsuarios.get('fnac')?.enable();
    this.formUsuarios.get('email')?.enable();
    this.formUsuarios.get('username')?.enable();
    this.formUsuarios.get('password')?.enable();
    this.formUsuarios.get('confirmPassword')?.enable();
  }

}
