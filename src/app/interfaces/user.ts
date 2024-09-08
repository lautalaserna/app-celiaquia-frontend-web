export class Usuario {
  usuario_id!: number;
  nombre!: string | null;
  apellido!: string | null;
  dni!: string | null;
  fnac!: Date | null;
  email!: string | null;
  username!: string | null;
  roles!: Rol[];
}

export class Rol {
  rol_id!: number;
  nombre!: string;
} 