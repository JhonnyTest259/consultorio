import { Component, OnInit } from '@angular/core';
import { AuthService } from "../../shared/services/auth.service";
import { DashboardComponent } from '../dashboard/dashboard.component';
@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrls: ['./sign-up.component.css']
})
export class SignUpComponent implements OnInit {
  visible = "block";
  veri = false;
  constructor(
    public authService: AuthService, public dash: DashboardComponent
  ) { 
  }
  ngOnInit() {this.veri = false; }

  show(){
    this.veri= true;
  }
  
}