import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NoPageComponent } from './error/no-page/no-page.component';
import { AppErrorComponent } from './error/app-error/app-error.component';
import { Layout1Component } from './layout/layout-1/layout-1.component';
import { LoginGuard } from './guards/login.guard';
import { ForbiddenComponent } from './error/forbidden/forbidden.component';

const routes: Routes = [
  { path: '', component:  Layout1Component,  canActivate: [LoginGuard], loadChildren: './home/home.module#HomeModule' },
  { path: 'error', component: AppErrorComponent },
  { path: 'forbidden', component: ForbiddenComponent },
  { path: '**', component: NoPageComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
