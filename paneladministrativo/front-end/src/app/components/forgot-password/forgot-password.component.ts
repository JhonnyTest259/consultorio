import { Component, OnInit } from '@angular/core';
import { AuthService } from "../../shared/services/auth.service";
import { SignInComponent } from '../sign-in/sign-in.component';
@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.css']
})
export class ForgotPasswordComponent implements OnInit {
  visible = "block";
  constructor(
    public authService: AuthService,
    public signin: SignInComponent,
  ) { }
  ngOnInit() {
  }
}