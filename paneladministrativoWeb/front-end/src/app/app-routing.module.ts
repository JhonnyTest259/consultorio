import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SignInComponent } from './auth/pages/sign-in/sign-in.component';
import { DashboardComponent } from './solicitudes/dashboard/dashboard.component';
import { ForgotPasswordComponent } from './auth/pages/forgot-password/forgot-password.component';
// route guard
import { AuthGuard } from './auth/guard/auth.guard';
const routes: Routes = [
  { path: '', redirectTo: '/sign-in', pathMatch: 'full' },
  { path: 'sign-in', component: SignInComponent },
  {
    path: 'dashboard',
    component: DashboardComponent,
    canActivate: [AuthGuard],
  },
  { path: 'forgot-password', component: ForgotPasswordComponent },
  { path: '**', redirectTo: 'dashboard', canActivate: [AuthGuard] },
];
@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
