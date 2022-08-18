import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import { FormsModule } from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';


import { AngularFireModule } from '@angular/fire/compat';
import { AngularFireAuthModule } from '@angular/fire/compat/auth';
import { AngularFireStorageModule } from '@angular/fire/compat/storage';
import { AngularFirestoreModule } from '@angular/fire/compat/firestore';
import { AngularFireDatabaseModule } from '@angular/fire/compat/database';
import { environment } from '../environments/environment';
import { NgxPaginationModule } from 'ngx-pagination';
import {MatSliderModule} from '@angular/material/slider';
import { DashboardComponent } from './solicitudes/dashboard/dashboard.component';
import { SignInComponent } from './auth/pages/sign-in/sign-in.component';
import { SignUpComponent } from './auth/pages/sign-up/sign-up.component';
import { ForgotPasswordComponent } from './solicitudes/forgot-password/forgot-password.component';
import { AuthService } from './auth/services/auth.service';

const MaterialComponents = [
  MatProgressSpinnerModule,
  MatSliderModule
]

@NgModule({
  declarations: [
    AppComponent,
    DashboardComponent,
    SignInComponent,
    SignUpComponent,
    ForgotPasswordComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    AngularFireModule.initializeApp(environment.firebase),
    AngularFireAuthModule,
    AngularFirestoreModule,
    AngularFireStorageModule,
    AngularFireDatabaseModule,
    FormsModule,
    NgxPaginationModule,
    MaterialComponents
    
  ],
  providers: [AuthService],
  bootstrap: [AppComponent]
})
export class AppModule { }
