import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Solicitudes } from '../models/solicitudes';

@Injectable({
  providedIn: 'root'
})
export class SolicitudService {
  readonly urlApi = "http://localhost:8090/api/solicitudes/";
  constructor(private http: HttpClient) { }

  getSolicitudes() {
    return this.http.get(this.urlApi);
  }

  getSolicitud(_uid: string){
    const cod = _uid;
    return this.http.get(this.urlApi + cod);
  }

  putState(solicitud: Solicitudes, _uid: string, _estado: string) {
    const uid = _uid;
    const estado = _estado;
    return this.http.put(this.urlApi + "uid/" + uid+"/estado/" + estado, solicitud);
  }
}
