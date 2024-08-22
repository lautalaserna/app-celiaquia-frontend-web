import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { UserService } from '../../services/user.service';
import { CommonModule } from '@angular/common';
import { DialogModule } from 'primeng/dialog';
import { PaginatorModule } from 'primeng/paginator';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { SpinnerComponent } from '../../shared/spinner/spinner.component';
import { AdminService } from '../../services/admin.service';
import { Usuario } from '../../interfaces/user';

@Component({
  selector: 'app-usuarios',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, SpinnerComponent],
  templateUrl: './usuarios.component.html',
  styleUrl: './usuarios.component.css'
})

export class UsuariosComponent {
  listUsuarios: Usuario[] = [];
  displayEliminarModal: boolean = false;
  usuarioSeleccionadoId: number = 0;
  formFiltros!: FormGroup;
  dniFilter: string = '';
  emailFilter: string = '';
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private _userService: UserService,
    private _adminService: AdminService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    // this.listarUsuarios();
    this.listarUsuariosFake();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      dni: new FormControl({ value: this.dniFilter, disabled: false },  Validators.required ),
      email: new FormControl({ value: this.emailFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void{
    this.page = event.pageIndex;
    this.size = event.pageSize;
    //this.listarUsuarios();
    this.listarUsuariosFake();
  }

  listarUsuariosFake() {
    this.total = 3;
    this.listUsuarios = [
      {
        usuario_id: 1,
        nombre: "Juan",
        apellido: "Pérez",
        dni: "12345678",
        fnac: new Date(1985, 4, 15),
        email: "juan.perez@example.com",
        username: "jperez",
        roles: [
          { rol_id: 1, nombre: "Admin" },
          { rol_id: 2, nombre: "Usuario" }
        ]
      },
      {
        usuario_id: 2,
        nombre: "María",
        apellido: "García",
        dni: "87654321",
        fnac: new Date(1990, 9, 22),
        email: "maria.garcia@example.com",
        username: "mgarcia",
        roles: [
          { rol_id: 2, nombre: "Usuario" }
        ]
      },
      {
        usuario_id: 3,
        nombre: "Carlos",
        apellido: "López",
        dni: "11223344",
        fnac: new Date(1978, 1, 5),
        email: "carlos.lopez@example.com",
        username: "clopez",
        roles: [
          { rol_id: 3, nombre: "Editor" }
        ]
      }
    ];
  }

  listarUsuarios() {
    this.loading = true;
    // this.usernameFilter = this.formFiltros.get('username')?.value ? this.formFiltros.get('username')?.value : '';
    // this.emailFilter = this.formFiltros.get('email')?.value ? this.formFiltros.get('email')?.value : '';
    
    this._adminService
      // .listUsuarios(
      .listAllUsuarios(
        // this.page, 
        // this.size, 
        // this.dniFilter, 
        // this.emailFilter
      ).subscribe({
        next: (data: any) => {
          this.listUsuarios = data.content;
          this.total = data.totalElements;
        },
        error: (err) => {
          this.loading = false;
          console.error('Error al obtener los datos', err);
        },
        complete: () => {
          this.loading = false;
        }
      }
    );
  }

  toggleEliminarModal(id: number) {
    this.usuarioSeleccionadoId = id;
    this.displayEliminarModal = !this.displayEliminarModal;
  }

  eliminarUsuario() {
    this._adminService.deleteUsuario(this.usuarioSeleccionadoId).subscribe({
      next: (data: any) => {        
        this.toastr.success('Usuario eliminado con éxito','Eliminación')
      },
      error: (err) => {
        this.toastr.error('No se pudo eliminar el Usuario','Eliminación')
      },
      complete: () => {
        this.usuarioSeleccionadoId = 0;
        this.displayEliminarModal = false;
        this.listarUsuarios();
      },
    });
  }

  nuevoUsuario() {
    localStorage.removeItem('usuario');
  }
  
  verUsuarioSeleccionado(usuarioId: number) {
    this.router.navigate(['/usuario-detalle'],{ queryParams: { id: usuarioId } });
  }
}
