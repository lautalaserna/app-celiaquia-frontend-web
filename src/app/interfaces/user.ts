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

export interface IUsuario {
  usuario_id: number,
  username: string,
  password: string,
  email: string,
  fnac: Date,
  roles: Rol[],
}

export interface Rol {
  rol_id: number,
  nombre: string,
}