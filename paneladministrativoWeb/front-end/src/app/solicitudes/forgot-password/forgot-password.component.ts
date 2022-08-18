import { Component } from '@angular/core';
import { AuthService } from "../../auth/services/auth.service";
import { SignInComponent } from '../../auth/pages/sign-in/sign-in.component';
@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.css']
})
export class ForgotPasswordComponent{
  visible = "block";
  constructor(
    public authService: AuthService,
    public signin: SignInComponent,
  ) { }
}