import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../auth/services/auth.service';
import { Solicitudes } from 'src/app/solicitudes/interfaces/solicitudes';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import {MatSnackBar} from '@angular/material/snack-bar';

import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';
import { SolicitudesService } from 'src/app/solicitudes/services/solicitudes.service';
import { MensajeComponent } from '../../components/mensaje/mensaje.component';

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
  signup = false;
  uid = '';
  pdfStyle = 'none';
  pdfSoli = new Solicitudes();
  listaEstados = [
    { id: 0, name: 'Enviado' },
    { id: 1, name: 'Aceptado' },
    { id: 2, name: 'Revision' },
    { id: 3, name: 'Rechazado' },
  ];

  constructor(
    private _solicitudService: SolicitudesService,
    public authService: AuthService,
    public db: AngularFirestore,
    private _snackBar: MatSnackBar
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

  ActualizarEstado(event: any) {
    this._solicitudService.actualizarSolicitud(event.uid, event.estado).then(
      () => {
        this.solicitud = [];
        this._snackBar.openFromComponent(MensajeComponent, {
          duration: 3000,
        })
      },
      (error) => {
        console.log(error);
      }
    );
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

  cancelarPopUpEstado() {
    this.pdfStyle = 'none';
  }

  restablecer() {
    this.solicitud = [];
    this.filtroEstado = '';
    this.obtenerSolicitudes();
  }
  anadir() {
    this.signup = true;
  }
  anadirC() {
    this.signup = false;
  }
}
