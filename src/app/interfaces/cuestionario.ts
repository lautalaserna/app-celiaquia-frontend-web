export class Cuestionario {
  cuestionario_id!: number;
  pregunta!: string;
  posicion!:number;
  //isactive!:boolean;
  opciones!: Opcion[];
}

export class Opcion {
  opcion_id!: number;
  opcion!: string;
}