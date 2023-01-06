import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';
import { InvoiceModel } from '../models/invoice-model';

@Injectable({
  providedIn: 'root'
})
export class InvoiceService {

  constructor(private http:HttpClient) { }

////Customer Enty
saveCustomer(customer){
 return this.http.post(environment.apiUrl+'/Invoice/SaveCustomer',customer);
}
getCustomers(){
  return this.http.get(environment.apiUrl+'/Invoice/GetCustomers');
}

//Product Enty
saveProduct(product){
  return this.http.post(environment.apiUrl+'/Invoice/SaveProduct',product);
}
getWarehouses(){
  return this.http.get(environment.apiUrl+'/Invoice/GetWarehouses');
}
getProducts(id:number=0){
  return this.http.get(environment.apiUrl+'/Invoice/GetProducts/'+id);
}
///Invoice
getUnits(){
  return this.http.get(environment.apiUrl+'/Invoice/GetUnits');
}
saveInvoice(invoice:InvoiceModel){
  return this.http.post(environment.apiUrl+'/Invoice/SaveInvoice',invoice);
}
}
