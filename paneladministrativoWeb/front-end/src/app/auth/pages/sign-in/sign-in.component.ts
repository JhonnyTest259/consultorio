import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/auth/services/auth.service';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.css']
})
export class SignInComponent implements OnInit {

  showForgotModal= false;
  constructor(
    public authService: AuthService
  ) { }

  ngOnInit(): void {
  }

  showFModal(){
    this.showForgotModal = true;
  }
  hiddenFModal(){
    this.showForgotModal = false;
  }

}
