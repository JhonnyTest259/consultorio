import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../shared/services/auth.service';
import { Solicitudes } from 'src/app/models/solicitudes';
import { AngularFirestore } from '@angular/fire/compat/firestore';

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
  selectedValue = null;
  estado = "";
  filtroEstado = "";
  boolEstado = false;
  signup = false;
  uid = "";
  displayStyle = "none";
  pdfStyle = "none";
  pdfSoli = new Solicitudes();
  public page?: number;
  showSpinner = "0";
  cantiSoli = 5;
  listaEstados = [
    { id: 0, name: "Enviado" },
    { id: 1, name: "Aceptado" },
    { id: 2, name: "Revision" },
    { id: 3, name: "Rechazado" },
  ];

  constructor(public authService: AuthService, public db: AngularFirestore) {
  }

  ngOnInit(): void {
    this.getSolicitudes();
  }

  getSolicitudesFiltradas(e: any) {
    this.filtroEstado = e.target.value;
    const reqfil = this.db.collection('solicitudes', ref => ref.where('estado', '==', this.filtroEstado));
    if (this.filtroEstado != "") {
      reqfil.valueChanges().subscribe((soliData) => {
        this.solicitud = soliData;
        if (this.solicitud == "") {
          this.boolEstado = true;
        } else {
          this.boolEstado = false;
        }
        this.showSpinner = "1";
        setTimeout(() => {
          this.showSpinner = "0";
        }, 300);
      });
    } else {
      this.getSolicitudes();
    }
  }
  getSolicitudes() {
    const ref = this.db.collection('solicitudes', ref => ref.orderBy('creado', 'desc'));
    ref.valueChanges().subscribe((soliData) => {
      this.solicitud = soliData;
      this.showSpinner = "1";
      setTimeout(() => {
        this.showSpinner = "0";
      }, 300);
    });
    this.showSpinner = "1";
    setTimeout(() => {
      this.showSpinner = "0";
    }, 800);
  }

  generarPdf(uid: string) {
    this.uid = uid;
    const ref = this.db.collection('solicitudes').doc(uid);
    ref.get().subscribe((soliData) => {
      this.solicitudOne = soliData.data();
      this.pdfSoli = new Solicitudes(this.solicitudOne.uid,
        this.solicitudOne.nombre, this.solicitudOne.salario,
        this.solicitudOne.edad, this.solicitudOne.barrio,
        this.solicitudOne.direccionCasa, this.solicitudOne.telefono,
        this.solicitudOne.direccionTrabajo, this.solicitudOne.email,
        this.solicitudOne.descripcion);
      this.pdfStyle = "inline-flex";
    });
  }

  public downloadPDF(): void {
    const DATA = document.getElementById('htmlData');
    const doc = new jsPDF('p', 'pt', 'a4');
    const options = {
      background: 'white',
      scale: 3
    };

    html2canvas(DATA!, options).then((canvas) => {
      const img = canvas.toDataURL('image/PNG');

      //Add image Canvas to PDF
      const bufferX = 15;
      const bufferY = 15;
      const imgProps = (doc as any).getImageProperties(img);
      const pdfWidth = doc.internal.pageSize.getWidth() - 2 * bufferX;
      const pdfHeight = (imgProps.height * pdfWidth) / imgProps.width;
      doc.addImage(img, 'PNG', bufferX, bufferY, pdfWidth, pdfHeight, undefined, 'FAST');
      return doc;
    }).then((docResult) => {
      docResult.save(`${this.pdfSoli._uid}_${new Date().toISOString()}_tutorial.pdf`);
    });
    this.pdfStyle = "none";
    /*  doc.text(`${soli.nombre}`, 10, 10);
     doc.save(`${soli._uid}.pdf`);  */
  }
  openPopupEstado(uid: string) {
    this.uid = uid;
    this.displayStyle = "block";
  }
  async closePopupEstado(uid: string, estado: string) {
    const solRef = this.db.collection('solicitudes').doc(uid);
    const data = await solRef.update({
      estado: estado,
    });
    this.displayStyle = "none";
  }
  cancelarPopUpEstado() {
    this.displayStyle = "none";
    this.pdfStyle = "none";
  }
  asignarEstado(e: any) {
    this.estado = e.target.value;
  }

  restablecer(){
    this.filtroEstado = "";
    this.boolEstado = false;
    this.getSolicitudes();
    this.cantiSoli = 5;
  }
  anadir(){
    this.signup = true;
  }
  anadirC(){
    this.signup = false;
  }
}