import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../auth/services/auth.service';
import { Solicitudes } from 'src/app/models/solicitudes';
import { AngularFirestore } from '@angular/fire/compat/firestore';

import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';
import { SolicitudesService } from 'src/app/solicitudes/services/solicitudes.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent implements OnInit {
  //lo tengo sin corchetes
  solicitud: any[] = [];
  solicitudOne: any;
  selectedValue = null;
  estado:string = '';
  filtroEstado = '';
  boolEstado = false;
  signup = false;
  uid = '';
  displayStyle = 'none';
  pdfStyle = 'none';
  pdfSoli = new Solicitudes();
  public page?: number;
  showSpinner = '0';
  cantiSoli = 5;
  listaEstados = [
    { id: 0, name: 'Enviado' },
    { id: 1, name: 'Aceptado' },
    { id: 2, name: 'Revision' },
    { id: 3, name: 'Rechazado' },
  ];

  constructor(
    private _solicitudService: SolicitudesService,
    public authService: AuthService,
    public db: AngularFirestore
  ) {}

  ngOnInit(): void {
    this.obtenerSolicitudes();
  }

  getSolicitudesFiltradas(event: any) {
    this.solicitud = [];
    this._solicitudService
      .filtroSolicitudes(event.target.value)
      .subscribe((data) => {
        data.map((data: any) => {
          this.solicitud.push({
            id: data.payload.doc.id,
            ...data.payload.doc.data(),
          });
        });
      });
  }
  obtenerSolicitudes() {
    this._solicitudService.getSolicitudes().subscribe((data) => {
      data.map((soli: any) => {
        this.solicitud.push({
          id: soli.payload.doc.id,
          ...soli.payload.doc.data(),
        });
      });
    });
  }

  generarPdf(uid: string) {
    this.uid = uid;
    const ref = this.db.collection('solicitudes').doc(uid);
    ref.get().subscribe((soliData) => {
      this.solicitudOne = soliData.data();
      this.pdfSoli = new Solicitudes(
        this.solicitudOne.uid,
        this.solicitudOne.nombre,
        this.solicitudOne.salario,
        this.solicitudOne.edad,
        this.solicitudOne.barrio,
        this.solicitudOne.direccionCasa,
        this.solicitudOne.telefono,
        this.solicitudOne.direccionTrabajo,
        this.solicitudOne.email,
        this.solicitudOne.descripcion
      );
      this.pdfStyle = 'inline-flex';
    });
  }

  public downloadPDF(): void {
    const DATA = document.getElementById('htmlData');
    const doc = new jsPDF('p', 'pt', 'a4');
    const options = {
      background: 'white',
      scale: 3,
    };

    html2canvas(DATA!, options)
      .then((canvas) => {
        const img = canvas.toDataURL('image/PNG');

        //Add image Canvas to PDF
        const bufferX = 15;
        const bufferY = 15;
        const imgProps = (doc as any).getImageProperties(img);
        const pdfWidth = doc.internal.pageSize.getWidth() - 2 * bufferX;
        const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;
        doc.addImage(
          img,
          'PNG',
          bufferX,
          bufferY,
          pdfWidth,
          pdfHeight,
          undefined,
          'FAST'
        );
        return doc;
      })
      .then((docResult) => {
        docResult.save(
          `${this.pdfSoli._uid}_${new Date().toISOString()}_tutorial.pdf`
        );
      });
    this.pdfStyle = 'none';
    /*  doc.text(`${soli.nombre}`, 10, 10);
     doc.save(`${soli._uid}.pdf`);  */
  }
  openPopupEstado(uid: string) {
    this.uid = uid;
    this.displayStyle = 'block';
  }
 
  ActualizarEstado(uid: string, estado: string) {
    this._solicitudService.actualizarSolicitud(uid, estado).then(() => {
      this.displayStyle = 'none';
      this.solicitud = [];
      console.log('Actualizado con exito');
    }, error => {
      console.log(error);
    })
  }
  cancelarPopUpEstado() {
    this.displayStyle = 'none';
    this.pdfStyle = 'none';
  }
  asignarEstado(e: any) {
    this.estado = e.target.value;
  }

  restablecer() {
    this.solicitud = [];
    this.filtroEstado = '';
    this.boolEstado = false;
    this.obtenerSolicitudes();
    this.cantiSoli = 5;
  }
  anadir() {
    this.signup = true;
  }
  anadirC() {
    this.signup = false;
  }
}
