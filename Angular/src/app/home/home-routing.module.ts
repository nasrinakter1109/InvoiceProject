import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { StartupComponent } from './startup/startup.component';
import { InvoiceComponent } from './invoice/invoice.component';
import { ProductComponent } from './product/product.component';



@NgModule({
  imports: [RouterModule.forChild([
    { path: '', component: StartupComponent },
    { path: 'invoice', component: InvoiceComponent},
    { path: 'product', component: ProductComponent}

  ])],
  exports: [RouterModule]
})
export class HomeRoutingModule { }
