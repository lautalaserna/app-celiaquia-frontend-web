import { Alimento, Receta } from "./recetas";

interface EstadisticasCuestionario {
  pregunta: string;
  opciones: Opcion[];
  totalRespuestas: number;
}

interface RecetaEstaditica {
  titulo: string;
  stat_consultas: number;
}

interface AlimentoEstadistica {
  nombre: string;
  stat_consultas: number;
}

interface Opcion {
  opcion: string;
  valor: number;
  porcentaje: number;
}

interface EstadisticasUsuarios {
  key: string;
  value: number;
}

export interface Estadisticas {
  cuestionarios: EstadisticasCuestionario[];
  recetas: RecetaEstaditica[];
  alimentos: AlimentoEstadistica[];
  usuarios: EstadisticasUsuarios[];
}
