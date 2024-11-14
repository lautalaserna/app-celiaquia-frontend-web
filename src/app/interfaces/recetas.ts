export class Receta {
  receta_id!: number;
  titulo!: string;
  preparacion!: string;
  apto_vegetariano!: boolean;
  apto_vegano!: boolean;
  energia_total_kcal!: number;
  energia_total_kj!: number;
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
  apto_celiaco!: boolean;
  apto_vegetariano!: boolean;
  apto_vegano!: boolean;
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
  VERDES = "Verdes",
  PROTEINAS = "Proteinas",
  HIDRATOS = "Hidratos",
  COLASION = "Colasión"
}