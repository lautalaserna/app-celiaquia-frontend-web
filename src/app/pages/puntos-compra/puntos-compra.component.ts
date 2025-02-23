import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { PuntosCompraService } from '../../services/puntos-compra.service';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { PuntoCompra } from '../../interfaces/puntos-compra';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { CommonModule } from '@angular/common';
import { DialogModule } from 'primeng/dialog';
import { PaginatorModule } from 'primeng/paginator';
import { ModalConfirmarComponent } from '../../shared/modal-confirmar/modal-confirmar.component';
import { FooterComponent } from '../../shared/footer/footer.component';

@Component({
  selector: 'app-puntos-compra',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, DialogModule, FormsModule, PaginatorModule, RouterLink, MatPaginatorModule, ModalConfirmarComponent, FooterComponent],
  templateUrl: './puntos-compra.component.html',
  styleUrl: './puntos-compra.component.css'
})
export class PuntosCompraComponent {
  listPuntoCompra: PuntoCompra[] = [];
  displayEliminarModal: boolean = false;
  puntoCompraSeleccionadoId: number = 0;
  formFiltros!: FormGroup;
  nombreFilter: string = '';
  size: number = 5;
  page: number = 0;
  total: number = 0;
  loading: boolean = false;

  constructor(
    private formBuilder: FormBuilder,
    private _puntoCompraService: PuntosCompraService,
    private router: Router,
    private route: ActivatedRoute,
    private toastr: ToastrService,
  ) {}

  ngOnInit() {
    this.crearFormFiltros();
    this.listarPuntosCompra();
  }

  crearFormFiltros() {
    this.formFiltros = this.formBuilder.group({
      nombre: new FormControl({ value: this.nombreFilter, disabled: false },  Validators.required ),
    });
  }

  onPageChange(event: PageEvent): void{
    this.page = event.pageIndex;
    this.size = event.pageSize;
    this.listarPuntosCompra();
  }

  listarPuntosCompra() {
    this.loading = true;
    this.nombreFilter = this.formFiltros.get('nombre')?.value 
      ? this.formFiltros.get('nombre')?.value 
      : '';
    
    this._puntoCompraService
      .listPuntosCompra(
        this.page, 
        this.size, 
        this.nombreFilter
      ).subscribe({
        next: (data: any) => {
          this.listPuntoCompra = data.content;
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
    this.puntoCompraSeleccionadoId = id;
    this.displayEliminarModal = !this.displayEliminarModal;
  }

  eliminarPuntoCompra() {
    this._puntoCompraService.deletePuntoCompra(this.puntoCompraSeleccionadoId).subscribe({
      next: (data: any) => {        
        this.toastr.success('Punto de Compra eliminado con éxito','Eliminación')
      },
      error: (err) => {
        this.toastr.error('No se pudo eliminar el Punto de Compra','Eliminación')
      },
      complete: () => {
        this.puntoCompraSeleccionadoId = 0;
        this.displayEliminarModal = false;
        this.listarPuntosCompra();
      },
    });
  }

  nuevoPuntoCompra() {
    localStorage.removeItem('punto-compra');
  }
  
  verPuntoCompraSeleccionado(puntoCompraId: number) {
    this.router.navigate(['/punto-compra-detalle'],{ queryParams: { id: puntoCompraId } });
  }
}
