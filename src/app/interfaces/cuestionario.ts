export class Cuestionario {
  cuestionario_id!: number;
  pregunta!: string;
  posicion!:number;
  isactive!:boolean;
  respuestas!: Respuesta[];
}

export class Respuesta {
  respuesta_id!: number;
  descripcion!: string;
}