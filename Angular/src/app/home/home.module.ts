
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { PerfectScrollbarModule } from 'ngx-perfect-scrollbar';
import { ChartsModule as Ng2ChartsModule } from 'ng2-charts/ng2-charts';
import { HomeRoutingModule } from './home-routing.module';
import { StartupComponent } from './startup/startup.component';
import { BlockUIModule } from 'ng-block-ui';
import { NgSelectModule } from '@ng-select/ng-select';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import { LaddaModule } from 'angular2-ladda';
import { SweetAlert2Module } from '@toverux/ngx-sweetalert2';
import { LayoutModule } from '../layout/layout.module';
import { CustomerComponent } from './customer/customer.component';
import { ProductComponent } from './product/product.component';
import { InvoiceComponent } from './invoice/invoice.component';

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    NgbModule,
    Ng2ChartsModule,
    PerfectScrollbarModule,
    HomeRoutingModule,
    SweetAlert2Module,
    LaddaModule,
    BlockUIModule,
    NgSelectModule,
    NgxDatatableModule,
    LayoutModule,
    ReactiveFormsModule
  ],
  declarations: [
    StartupComponent,
    CustomerComponent,
    ProductComponent,
    InvoiceComponent
  ]
})
export class HomeModule { }
