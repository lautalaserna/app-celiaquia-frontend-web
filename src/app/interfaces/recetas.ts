export class Receta {
  receta_id!: number;
  titulo!: string;
  imagen!: string | null;
  dificultad!: string;
  isbalanceado!: boolean;
  cant_raciones!: number;
  nombre_racion!: string;
  tiempo_preparacion!: number;
  tiempo_coccion!: number;
  autocalcular!: boolean;
  preparacion!: string;
  descripcion!: string;
  apto_vegetariano!: boolean;
  apto_vegano!: boolean;
  calorias_totales!: number;
  proteinas_totales!: number;
  carbohidratos_totales!: number;
  grasas_totales!: number;
  ingredientes!: Ingrediente[]; 
}

export class Ingrediente {
  ingrediente_id!: number;
  alimento!: Alimento;
  porcion!: Porcion;
  cantidad!: number;
}

export class Alimento {
  alimento_id!: number;
  numero!: number;
  nombre!: string;
  genero!: string;
  tipo!: TipoAlimento;
  valoracion!: ValoracionAlimento;
  accesibilidad!: Accesibilidad;
  imagen!: any;
  apto_celiaco!: boolean;
  apto_vegetariano!: boolean;
  apto_vegano!: boolean;
  isprocesado!: boolean;
  preparacion!: string;
  porciones!: Porcion[];
  energia_kcal!: number;
  energia_kj!: number;
  proteinas!: number;
  carbohidratos_totales!: number;
  carbohidratos_disponibles!: number;
  grasa_total!: number;
  ac_grasos_monoinsaturados!: number;
  ac_grasos_poliinsaturados!: number;
  ac_grasos_saturados!: number;
  grasas_trans!: number;
  agua!: number;
  calcio!: number;
  cenizas!: number;
  fosforo!: number;
  hierro!: number;
  niacina!: number;
  potasio!: number;
  rivoflavina!: number;
  sodio!: number;
  tiamina!: number;
  vitamina_c!: number;
  zinc!: number;
  colesterol!: number;
  fibra_dietetica!: number;
}

export class Porcion {
  porcion_id!: number;
  nombre!: string;
  peso!: number;
}

export enum TipoAlimento {
  VERDES = "VERDES",
  PROTEINAS = "PROTEINAS",
  HIDRATOS = "HIDRATOS",
}

export enum ValoracionAlimento {
  EXCELENTE = "EXCELENTE",
  BUENO = "BUENO",
  REGULAR = "REGULAR",
}

export enum Accesibilidad {
  ALTA = "ALTA",
  MEDIA = "MEDIA",
  BAJA = "BAJA",
}

export enum DificultadReceta {
  FACIL = "FACIL",
  MEDIA = "MEDIA",
  DIFICIL = "DIFICIL",
}