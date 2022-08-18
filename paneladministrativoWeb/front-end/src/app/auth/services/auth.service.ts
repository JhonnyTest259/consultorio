import { Injectable, NgZone } from '@angular/core';
import { User } from '../interfaces/user';
import * as auth from 'firebase/auth';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import {
  AngularFirestore,
  AngularFirestoreDocument,
} from '@angular/fire/compat/firestore';
import { Router } from '@angular/router';
import { Observable, of } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  userData: any; // datos de usuario con sesion iniciada
  constructor(
    public afs: AngularFirestore, // Servicio de firestore
    public afAuth: AngularFireAuth, // servicio de autenticacion fire
    public router: Router,
    public ngZone: NgZone
  ) {
    /* guarda un usuario localmente y retorna null cuando cierra sesion */
    this.afAuth.authState.subscribe((user) => {
      if (user) {
        this.userData = user;
        localStorage.setItem('user', JSON.stringify(this.userData));
        JSON.parse(localStorage.getItem('user')!);
      } else {
        localStorage.setItem('user', 'null');
        JSON.parse(localStorage.getItem('user')!);
      }
    });
  }
  // Inicia sesion con correo y contraseña
  SignIn(email: string, password: string) {
    return this.afAuth
      .signInWithEmailAndPassword(email, password)
      .then((result) => {
        this.isLoggedIn(result.user);
        this.SetUserData(result.user);
      })
      .catch((error) => {
        window.alert(error.message);
      });
  }
  // Crear usuario con correo y contraseña
  SignUp(email: string, password: string) {
    return this.afAuth
      .createUserWithEmailAndPassword(email, password)
      .then((result) => {
        /* Llama a sendverificationmail cada que un nuevo usuario crea una cuenta*/
        this.SendVerificationMail();
        this.SetUserData(result.user);
      })
      .catch((error) => {
        window.alert(error.message);
      });
  }
  // Crea un correo de verificacion cuando hay un nuevo usuario
  SendVerificationMail() {
    return this.afAuth.currentUser
      .then((u: any) => u.sendEmailVerification())
      .then(() => {
        //this.router.navigate(['dashboard']);
      });
  }
  // Restablece la contraseña
  ForgotPassword(passwordResetEmail: string) {
    return this.afAuth
      .sendPasswordResetEmail(passwordResetEmail)
      .then(() => {
        window.alert('Email de restablecimiento enviado, revisa tu correo.');
      })
      .catch((error) => {
        window.alert(error);
      });
  }
  // Retorna verdadero cuando hay un usuario y esta verificado su correo
  isLoggedIn(sesionUser?: any): Observable<boolean> {
    const user = JSON.parse(localStorage.getItem('user')!);
    if (user) {
      console.log(user);
      return of(user && user.emailVerified ? true : false);
    }
    console.log(sesionUser);
    return of(sesionUser && sesionUser.emailVerified ? true : false);
  }

  // Logica de autenticacion
  AuthLogin(provider: any) {
    return this.afAuth
      .signInWithPopup(provider)
      .then((result) => {
        this.ngZone.run(() => {
          this.router.navigate(['dashboard']);
        });
        this.SetUserData(result.user);
      })
      .catch((error) => {
        window.alert(error);
      });
  }
  /* Configuracion de datos de usuario cuando inician sesion*/
  SetUserData(user: any) {
    const userRef: AngularFirestoreDocument<any> = this.afs.doc(
      `users/${user.uid}`
    );
    const userData: User = {
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,
    };
    return userRef.set(userData, {
      merge: true,
    });
  }
  // Cierre  de sesion
  SignOut() {
    return this.afAuth.signOut().then(() => {
      localStorage.removeItem('user');
      this.router.navigate(['sign-in']);
    });
  }
}
