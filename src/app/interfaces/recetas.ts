export class Receta {
  receta_id!: number;
  titulo!: string;
  preparacion!: string;
  
  caloriasTotales!: number;
  proteinasTotales!: number;
  carbohidratosTotales!: number;
  
  grasasTotales!: number;
  grasasSaturadasTotales!: number;
  grasasMonoinsaturadasTotales!: number;
  grasasPoliinsaturadasTotales!: number;
  
  fibraTotal!: number;
  sodioTotal!: number; 
  colesterolTotal!: number; 

  ingredientes!: Ingrediente[]; 
}

export class Ingrediente {
  ingrediente_id!: number;
  alimento!: Alimento;
  cantidad!: number;
}

export class Alimento {
  alimento_id!: number;
  
  nombre!: string;
  genero!: string;
  apto_celiaco!: boolean;
  apto_vegetariano!: boolean;
  apto_vegano!: boolean;

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
  numero!: number;
  potasio!: number;
  rivoflavina!: number;
  sodio!: number;
  tiamina!: number;
  vitamina_c!: number;
  zinc!: number;
  colesterol!: number;
  fibra_dietetica!: number;
}

/* export class Alimento {
  alimento_id!: number;
  nombre!: string;

  um!: UnidadMedida;
  calorias!: number;
  proteinas!: number;
  carbohidratos!: number;
  grasas!: number;
  grasasSaturadas!: number;
  grasasMonoinsaturadas!: number;
  grasasPoliinsaturadas!: number;

  vitaminas!: Vitaminas;
  minerales!: Minerales;
  
  fibra!: number;
  sodio!: number;
  colesterol!: number;
} */

/* export class Vitaminas {
  vitaminaA!: number;
  vitaminaC!: number;
  vitaminaD!: number;
  vitaminaE!: number;
  vitaminaK!: number;
  vitaminaB1!: number;
  vitaminaB2!: number;
  vitaminaB3!: number;
  vitaminaB6!: number;
  vitaminaB12!: number;
} */

/* export class Minerales {
  calcio!: number;
  hierro!: number;
  magnesio!: number;
  fosforo!: number;
  potasio!: number;
  sodio!: number;
  zinc!: number;
  cobre!: number;
  manganeso!: number;
  selenio!: number;
} */

export class UnidadMedida {
  unidadMedida_id!: number;
  nombre!: string;
  abreviatura!: string;
}