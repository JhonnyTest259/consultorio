import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { MaterialModule } from '../material/material.module';
import { FormsModule } from '@angular/forms';
import { SignUpComponent } from './pages/sign-up/sign-up.component';
import { NgxPaginationModule } from 'ngx-pagination';
import { TablaSolicitudesComponent } from './components/tabla-solicitudes/tabla-solicitudes.component';
import { MensajeComponent } from './components/mensaje/mensaje.component';



@NgModule({
  declarations: [
    DashboardComponent,
    SignUpComponent,
    TablaSolicitudesComponent,
    MensajeComponent
  ],
  exports:[
    DashboardComponent,
    SignUpComponent
  ],
  imports: [
    CommonModule,
    MaterialModule,
    FormsModule,
    NgxPaginationModule
  ]
})
export class SolicitudesModule { }
