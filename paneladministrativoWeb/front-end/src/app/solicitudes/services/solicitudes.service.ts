import { Injectable } from '@angular/core';
import { AngularFirestore } from '@angular/fire/compat/firestore';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class SolicitudesService {
  constructor(private firestore: AngularFirestore) {}

  getSolicitudes(): Observable<any> {
    return this.firestore
      .collection('solicitudes', (ref) => ref.orderBy('creado', 'desc'))
      .snapshotChanges();
  }

  filtroSolicitudes(termino: string) {
    return this.firestore
      .collection('solicitudes', (ref) => ref.where('estado', '==', termino))
      .snapshotChanges();
  }

  actualizarSolicitud(uid:string, termino:string): Promise<any>{
    return this.firestore.collection('solicitudes').doc(uid).update({
      estado: termino
    });
  }
}
