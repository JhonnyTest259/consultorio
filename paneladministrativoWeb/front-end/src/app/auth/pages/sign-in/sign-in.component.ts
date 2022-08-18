import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/auth/services/auth.service';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.css'],
})
export class SignInComponent implements OnInit {
  showForgotModal = false;
  user: any;
  constructor(public authService: AuthService, private route: Router) {
    this.user = localStorage.getItem('user');
    if (this.user) {
      this.route.navigate(['/dashboard']);
    }
  }

  ngOnInit(): void {}

  showFModal() {
    this.showForgotModal = true;
  }
  hiddenFModal() {
    this.showForgotModal = false;
  }

  singIn(name: string, password: string) {
    if (name === '' || password === '') {
      console.log('error al iniciar sesion');
      return;
    }

    this.authService.SignIn(name, password);
  }
}
