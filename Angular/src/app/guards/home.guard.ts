import { AppService } from './../app.service';
import { Injectable } from '@angular/core';
import { CanActivate } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class HomeGuard implements CanActivate {

  constructor(public authService: AuthService, private appService: AppService) { }

  canActivate(): boolean {
    if (!this.authService.isAuthenticated()) {
      this.appService.redirect('home/dashboard');
      return false;
    }
    if (this.authService.isLocked()) {
      this.appService.redirect('home/locked');
      return false;
    }
    return true;
  }
}
