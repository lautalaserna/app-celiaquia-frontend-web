import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { PuntosCompraService } from '../../../services/puntos-compra.service';
import { PuntoCompra, Tag } from '../../../interfaces/puntos-compra';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';

@Component({
  selector: 'app-punto-compra-detalle',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, ReactiveFormsModule, MatFormFieldModule, MatSelectModule, MatOptionModule,],
  templateUrl: './punto-compra-detalle.component.html',
  styleUrl: './punto-compra-detalle.component.css'
})
export class PuntoCompraDetalleComponent {
  puntoCompra!: PuntoCompra;
  formPuntoCompra!: FormGroup;
  esNuevo: boolean = false;
  soloLectura: boolean = false;
  loading: boolean = false;
  imagenUrl: string | null = null;
  tagsEnum = Tag;
  tagKeys: (keyof typeof Tag)[] = [];

  constructor(
    private formBuilder: FormBuilder,
    private toastr: ToastrService,
    private router: Router,
    private route: ActivatedRoute,
    private _puntosCompraService: PuntosCompraService
  ){
    this.tagKeys = Object.keys(this.tagsEnum) as (keyof typeof Tag)[];
  }

  ngOnInit() {
    const id = this.route.snapshot.queryParamMap.get('id');

    if(id){
      this.soloLectura = true;
      this.puntoCompra = this.route.snapshot.data['puntoCompra'];
    } else {
      this.esNuevo = true;
    }
    this.crearForm();
  }

  crearForm() {
    this.formPuntoCompra = this.formBuilder.group({
      punto_de_compra_id: new FormControl({value: this.puntoCompra?.punto_de_compra_id ? this.puntoCompra.punto_de_compra_id : 0, disabled: true}),
      nombre: new FormControl({value: this.puntoCompra?.nombre ? this.puntoCompra.nombre : null, disabled: false}, [Validators.required, Validators.maxLength(50)]),
      direccion: new FormControl({value: this.puntoCompra?.direccion ? this.puntoCompra.direccion : null, disabled: false}, Validators.required),
      link: new FormControl({value: this.puntoCompra?.link ? this.puntoCompra.link : null, disabled: false}),
      imagen: new FormControl({value: this.puntoCompra?.imagen ? this.puntoCompra.imagen : null, disabled: false}),
      tags: new FormControl({value: this.puntoCompra?.tags ? this.puntoCompra.tags : [], disabled: false}),
    });

    if (this.formPuntoCompra.get('imagen')?.value) {
      this.imagenUrl = this.formPuntoCompra.get('imagen')?.value;
    }
  }

  limpiarPuntoCompra() {
    localStorage.removeItem('puntoCompra');
    this.router.navigate(['/puntos-compra']);
  }
  
  guardarPuntoCompra() {
    const body = this.formPuntoCompra.getRawValue() as PuntoCompra;
    console.log(body);
    this.loading= true;

   this._puntosCompraService.createPuntoCompra(body).subscribe({
      next: (data) => {
        this.loading= false;
        this.router.navigate(['/puntos-compra'])
      },
      error: (err:any) => {
        this.loading= false;
        this.toastr.error('No se pudo guardar el punto de compra','Guardado');
      },
    });
  }

  onFileChange(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length) {
        const file = input.files[0];
        if (file.size > 1048576) {
            this.toastr.error('La imagen es super el tamaño máximo de 1Mb', 'Error');
            return;
        }
        const reader = new FileReader();
        reader.onload = () => {
            const base64String = reader.result as string;
            this.imagenUrl = base64String; 
            this.formPuntoCompra.patchValue({ imagen: base64String });
        };
        reader.readAsDataURL(file);
    }
  }

  toggleSoloLectura() {
    this.soloLectura = !this.soloLectura;
  }
}
