export class CuidadoHogar {
  cuidado_id!: number;
  titulo!: string;
  descripcion!: string;
  posicion!:number;
  isactive!:boolean;
}

export interface ICuidadoHogar {
  cuidado_id: number,
  titulo: string,
  descripcion: string,
  posicion:number,
  isactive:boolean,
}