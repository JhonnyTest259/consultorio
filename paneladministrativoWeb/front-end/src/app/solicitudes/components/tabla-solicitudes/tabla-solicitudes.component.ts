import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
@Component({
  selector: 'app-tabla-solicitudes',
  templateUrl: './tabla-solicitudes.component.html',
  styleUrls: ['./tabla-solicitudes.component.css'],
})
export class TablaSolicitudesComponent implements OnInit {
  @Input() solicitud: any[] = [];
  @Output() estados: EventEmitter<any> = new EventEmitter();
  cantiSoli: number = 5;
  displayStyle: string = 'none';
  estado: string = '';
  uid: string = '';
  public page?: number;
  listaEstados = [
    { id: 0, name: 'Enviado' },
    { id: 1, name: 'Aceptado' },
    { id: 2, name: 'Revision' },
    { id: 3, name: 'Rechazado' },
  ];
  constructor() {}

  ngOnInit(): void {}

  openPopupEstado(uid: string) {
    this.uid = uid;
    this.displayStyle = 'block';
  }

  ActualizarEstado(uid: string, estado: string) {
    this.estados.emit({uid, estado});
    this.displayStyle = 'none';
  }
  cancelarPopUpEstado() {
    this.displayStyle = 'none';
  }
  asignarEstado(e: any) {
    this.estado = e.target.value;
  }
}
