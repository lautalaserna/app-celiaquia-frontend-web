export class PuntoCompra {
  punto_de_compra_id!: number;
  nombre!: string;
  direccion!: string;
  link!: string | null;
  imagen!: string | null;
  tags!: string[];
}

export enum Tag {
  CAFETERIA = 'Cafetería',
  DIETETICA = 'Dietética',
  FASTFOOD = 'Fastfood',
  PASTELERIA = 'Pastelería',
  ROTISERIA = 'Rotisería',
  HELADERIA = 'Heladería',
  SUPERMERCADO = 'Supermercado',
  ALMACEN = 'Almacén',
  RESTAURANT = 'Restaurant',
  TAKEAWAY = 'Takeaway',
  BAR = 'Bar',
}