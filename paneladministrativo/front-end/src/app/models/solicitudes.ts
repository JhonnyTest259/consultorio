export class Solicitudes {
    _uid: string;
    nombre: string;
    salario: string;
    edad: string;
    barrioResidencia: string;
    direccionCasa: string;
    telefonoCasa: string;
    direccionTrabajo: string;
    email: string;
    descripcionConsulta: string;
    estado: string;

    constructor(_uid="", nombre="", salario="", edad="",barrioResidencia="",
    direccionCasa="",telefonoCasa="", direccionTrabajo="", email="",
    descripcionConsulta="", estado=""){
        this._uid = _uid;
        this.nombre = nombre;
        this.salario = salario;
        this.edad = edad;
        this.barrioResidencia = barrioResidencia;
        this.direccionCasa = direccionCasa;
        this.telefonoCasa = telefonoCasa;
        this.direccionTrabajo = direccionTrabajo;
        this.email = email;
        this.descripcionConsulta = descripcionConsulta;
        this.estado = estado;
    }
}
