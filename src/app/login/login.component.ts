import { Component, ElementRef, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Usuario } from '../interfaces/user';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { UserService } from '../services/user.service';
import { ErrorService } from '../services/error.service';
import { HttpErrorResponse } from '@angular/common/http';

@Component({
    selector: 'app-login',
    standalone: true,
    templateUrl: './login.component.html',
    styleUrl: './login.component.css',
    imports: [CommonModule, ReactiveFormsModule]
})
export class LoginComponent {
  @ViewChild('usernameInput') usernameInput!: ElementRef;
  formLogin!: FormGroup;
  loading: boolean = false;
  
  constructor(
    private toastr: ToastrService,
    private router: Router,
    private formBuilder: FormBuilder,
    private _userService: UserService,
    private _errorService: ErrorService
    ) { }

  ngOnInit(): void {
    this.createForm();
  }

  createForm(){
    this.formLogin = this.formBuilder.group({
      username: new FormControl('',Validators.required),
      password: new FormControl('',Validators.required),
    })
  }

  // Getters para las variables del FormControl
  get username() { return this.formLogin.get('username') as FormControl}
  get password() { return this.formLogin.get('password') as FormControl}

  login() {
    if (this.username.value == '' || this.password.value == '') {
      this.toastr.error('Campos incompletos', 'Error');
      this.usernameInput.nativeElement.focus();
      return
    }

    // Creamos el body
    const user: any = {
      username: this.username.value,
      password: this.password.value,
    }

    this.loading = true;
    this._userService.login(user).subscribe({
      next: (data) => {
        this.loading = false;
        this.router.navigate(['/home'])
      },
      error: (e: HttpErrorResponse) => {
        this.loading = false;
        this._errorService.msjError(e);
      }
    })
  }

  onEnterKey(): void {
    if (this.formLogin.valid) {
      this.login();
    } else {
      this.usernameInput.nativeElement.focus();
      this.toastr.error('Campos incompletos', 'Error');
    }
  }
}