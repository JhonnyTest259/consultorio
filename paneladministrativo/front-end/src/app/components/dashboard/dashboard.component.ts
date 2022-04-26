import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../shared/services/auth.service';
import { Solicitudes } from 'src/app/models/solicitudes';
import { SolicitudService } from 'src/app/services/solicitud.service';

import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent implements OnInit {
  solicitud: any;
  solicitudOne: any;
  listaEstados = [
    { id: 0, name: "Enviado" },
    { id: 1, name: "Aceptado" },
    { id: 2, name: "Revision" },
    { id: 3, name: "Rechazado" },
  ]
  selectedValue = null;

  estado = "";
  uid = "";
  displayStyle = "none";
  constructor(public authService: AuthService, private solicitudService: SolicitudService) { 
    
  }

 

  ngOnInit(): void {
    this.getSolicitudes();
  }
  getSolicitudes() {
    this.solicitudService.getSolicitudes().subscribe((solicitud) => {
      this.solicitud = solicitud;
     //console.log(solicitud);
    })
  }

  generarPdf(uid: string) {
    let soli = new Solicitudes();
    this.solicitudService.getSolicitud(uid).subscribe((solicitud) => {
      this.solicitudOne = solicitud;
    });
    
    //this.downloadPDF();
    console.log(this.solicitudOne);
  }
  public downloadPDF(): void {
    const doc = new jsPDF();

    doc.text('Hello world!', 10, 10);
    doc.save('hello-world.pdf');
  }

  openPopupEstado(uid: string) {
    this.uid = uid;
    this.displayStyle = "block";
  }
  closePopupEstado(uid: string, estado:string) {
    //console.log(uid +"  "+ estado);
    this.solicitudService.putState(new Solicitudes,uid,estado).subscribe(()=> 
    this.getSolicitudes());
    this.displayStyle = "none";
  }
  cancelarPopUpEstado(){
    this.displayStyle = "none";
  }
  asignarEstado(e: any){
    this.estado = e.target.value;
  }


}