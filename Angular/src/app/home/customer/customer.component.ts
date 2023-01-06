import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NgbDateStruct, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastrService } from 'ngx-toastr';
import { InvoiceService } from '../../services/invoice.service';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.scss','../../../vendor/libs/ng-select/ng-select.scss']
})
export class CustomerComponent implements OnInit {

  constructor(
    private modalService:NgbModal,
    private formBuilder:FormBuilder,
    private toasterService:ToastrService,
    private invoiceService:InvoiceService
  ) { }
  @Output() customers=new EventEmitter<any>();
    customerForm:FormGroup;
    minDate:NgbDateStruct = {year:1900, month:1, day:1};
    maxDate:NgbDateStruct = {year:2100, month:12, day:31};
    entyDate:any;
    isSubmit:boolean=false;
    isSaved:boolean=false;
  ngOnInit() {
    this.createForm();
  }
  ngbDateToDate(ngbDate: NgbDateStruct): Date {
    if (ngbDate == null) { return null };
    let date = new Date(ngbDate.year, ngbDate.month - 1, ngbDate.day);
    return date;
}
  onSelectDate(){
    if(this.f['entyDateNgb'].value==null){return;}
   let date=this.ngbDateToDate(this.f['entyDateNgb'].value).toLocaleDateString()
    this.customerForm.patchValue({
      entyDate:date
    })
  }
  saveCustomer(){
    this.isSubmit = true;
    if (this.customerForm.invalid) {
      this.toasterService.error("Please fill the all required fields", "Invalid submission");
      return;
    } else{
      this.isSaved=true;
    this.invoiceService.saveCustomer(this.customerForm.value).subscribe((response:any)=>{
      if(response.status){
        this.toasterService.success(response.result,"Success!");
        this.customers.emit(response.customerList);
        this.reset();
        this.modalService.dismissAll();
      }else{
        this.toasterService.error(response.result,"Failed!");
        this.isSaved=false;
      }
    },(err:any)=>{
      this.toasterService.error(err.error,"Error!");
      this.isSaved=false;
    })
  } 
  }
  reset(){
    this.isSaved=false;
    this.isSubmit=false;
    this.customerForm.reset();
    this.createForm();
  }
  cancel(){
    this.modalService.dismissAll();

  }
  createForm(){
    this.customerForm=this.formBuilder.group({
      id  :[0,[]],
      customerName  :[,[Validators.required]],
      customerType  :[,[]],
      entyDate :[,[]],
      entyDateNgb:[,[Validators.required]],
      address  :[,[]],
      mobile  :[,[]],
      phoneNo  :[,[]],
      fax  :[,[]],
      email  :[,[Validators.email,Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')]],
    })
  }
  get f(){
    return this.customerForm.controls;
  }
}
