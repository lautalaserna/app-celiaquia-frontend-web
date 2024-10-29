import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, Output } from '@angular/core';
import { DialogModule } from 'primeng/dialog';
import { ModalConfirmarComponent } from "../modal-confirmar/modal-confirmar.component";
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { UserService } from '../../services/user.service';
import { ToastrService } from 'ngx-toastr';
import { Router } from '@angular/router';

@Component({
  selector: 'app-configuraciones',
  standalone: true,
  imports: [DialogModule, CommonModule, ModalConfirmarComponent, ReactiveFormsModule],
  templateUrl: './configuraciones.component.html',
  styleUrl: './configuraciones.component.css'
})
export class ConfiguracionesComponent {
  @Input() showDialog: boolean = false;
  @Output() showDialogChange = new EventEmitter<boolean>();
  formContrasenia!: FormGroup;
  formBaja!: FormGroup;
  displayConfirmarBaja: boolean = false;
  displayConfirmarContrasenia: boolean = false;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private _userService: UserService,
    private router: Router
  ) {}

  ngOnInit() {
    this.crearForms();
  }

  crearForms() {
    this.formContrasenia = this.formBuilder.group({
      oldPassword: new FormControl(null, [Validators.required, Validators.minLength(8), Validators.maxLength(200)]),
      newPassword: new FormControl(null, [Validators.required, Validators.minLength(8), Validators.maxLength(200)]),
      confirmPassword: new FormControl(null, [Validators.required, Validators.minLength(8), Validators.maxLength(200)]),
    });

    this.formBaja = this.formBuilder.group({
      password: new FormControl(null, [Validators.required, Validators.minLength(8), Validators.maxLength(200)]),
      confirmPassword: new FormControl(null, [Validators.required, Validators.minLength(8), Validators.maxLength(200)]),
    });
  }

  closeDialog() {
    this.showDialog = false;
    this.showDialogChange.emit(this.showDialog);
    this.formBaja.reset();
    this.formContrasenia.reset();
  }

  openModalConfirmarBaja() {
    this.displayConfirmarBaja = true;
  }

  openModalConfirmarContrasenia() {
    this.displayConfirmarContrasenia = true;
  }

  cambiarContrasenia(){
    const body = this.formContrasenia.getRawValue() as any;
    this.loading= true;

    this._userService.changePassword(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.toastr.success('Contraseña actualizada con éxito','Cambio de Contraseña');
        this.closeDialog();
      },
      error: (err:any) => {
        this.loading= false;
        if(err && err.message) {
          this.toastr.error(err.message,'Cambio de Contraseña');
        } else {
          this.toastr.error('No se pudo cambiar la contraseña','Cambio de Contraseña');
        }
        this.closeDialog();
      },
    })
  }

  darseDeBaja() {
    const body = this.formBaja.getRawValue() as any;
    this.loading= true;

    this._userService.deleteMyUser(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.closeDialog();
        this._userService.logOut();
        this.router.navigate(['/login']);
      },
      error: (err:any) => {
        this.loading= false;
        if(err && err.message) {
          this.toastr.error(err.message,'Baja de Usuario');
        } else {
          this.toastr.error('No se pudo dar de baja el usuario','Baja de Usuario');
        }
        this.closeDialog();
      },
    })
  }
}
