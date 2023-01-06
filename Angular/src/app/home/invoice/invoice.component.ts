import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { NgbDateStruct, NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { ToastrService } from 'ngx-toastr';
import { InvoiceDetailsModel } from '../../models/invoice-details-model';
import { InvoiceModel } from '../../models/invoice-model';
import { InvoiceService } from '../../services/invoice.service';

@Component({
  selector: 'app-invoice',
  templateUrl: './invoice.component.html',
  styleUrls: ['./invoice.component.scss','../../../vendor/libs/ng-select/ng-select.scss']
})
export class InvoiceComponent implements OnInit {

  constructor(
    private modalService:NgbModal,
    private invoiceService:InvoiceService,
    private formBuilder:FormBuilder,
    private toasterService:ToastrService
  ) {
    this.productForm=this.formBuilder.array([]);
   }
  customerList:any[]=[];
  isLoading:boolean=false;
  productForm:FormArray;
  invoiceForm:FormGroup;
  productList:any[]=[];
  warehouseList:any[]=[];
  unitList:any[]=[];
  minDate:NgbDateStruct = {year:1900, month:1, day:1};
  maxDate:NgbDateStruct = {year:2100, month:12, day:31};
  totalDisCount:number=0;
  totalInvoiceAmount:number=0;
  totalVatAmount:number=0;
  isSubmit:boolean=false;
  isSaved:boolean=false;
  ngAfterViewInit() {
  }
  ngOnInit() {
    this.getCustomers();
    this.getProducts();
    this.getWarehouses();
    this.getUnits();
    this.createForm();
  }
  ngbDateToDate(ngbDate: NgbDateStruct): Date {
    if (ngbDate == null) { return null };
    let date = new Date(ngbDate.year, ngbDate.month - 1, ngbDate.day);
    return date;
}
  onSelectDate(){
    if(this.f['invoiceDateNgb'].value==null){return;}
   let date=this.ngbDateToDate(this.f['invoiceDateNgb'].value).toLocaleDateString()
    this.invoiceForm.patchValue({
      invoiceDate:date
    })
  }
  onNewCustomerAdd(item:any){
    this.customerList=item;
    this.ngAfterViewInit();
  }
  getCustomers(){
     this.invoiceService.getCustomers().subscribe((response:any)=>{
      if(response.status){
      this.customerList=response.result;
      }
      else{
        this.customerList=[];
      }
    })
  }
  getWarehouses(){
    this.invoiceService.getWarehouses().subscribe((response:any)=>{
     if(response.status){
     this.warehouseList=response.result;
     }
     else{
       this.warehouseList=[];
     }
   })
 }
 getUnits(){
  this.invoiceService.getUnits().subscribe((response:any)=>{
   if(response.status){
   this.unitList=response.result;
   }
   else{
     this.unitList=[];
   }
 })
}
  onSelectProduct(product:any){
    if(product){
      this.productForm.push(
        new FormGroup({
          productId:new FormControl(product.id,[]),
          warehouseId:new FormControl(product.warehouseId,[]),
          invoiceNo:new FormControl(this.formVal.invoiceNo,[]),
          productName:new FormControl(product.productName,[]),
          productDescription:new FormControl(product.description,[]),
          quantity:new FormControl(product.quantity,[]),
          unitId:new FormControl(null,[Validators.required]),
          price:new FormControl(0,[]),
          amount:new FormControl(0,[]),
          discountRate:new FormControl(0,[]),
          discountAmount:new FormControl(0,[]),
          vat:new FormControl(0,[]),
          vatAmount:new FormControl(0,[]),
          subTotal:new FormControl(0,[]),
        })
      )
    }
  }
  onChangeQty(rowIndex:number){
    let price = this.productForm.value[rowIndex]["price"]
    let quantity = this.productForm.value[rowIndex]["quantity"]
    let totalAmount = price * quantity;
    let discount = this.productForm.value[rowIndex]["discountRate"]
    let vat = this.productForm.value[rowIndex]["vat"]
    let disCountAmount = totalAmount * discount * 0.01;
    this.totalDisCount = this.totalDisCount + disCountAmount;
    let vatAmount=((price * quantity) - (price * quantity) * discount * 0.01) * vat * 0.01;
    this.productForm.controls[rowIndex].patchValue({
      amount:totalAmount,
      discountAmount:disCountAmount,
      vatAmount: vatAmount,
      subTotal:totalAmount-disCountAmount+vatAmount
    })
   let totalDiscountAmount = 0;
    this.totalInvoiceAmount = 0;
    this.totalVatAmount = 0;
    this.productForm.controls.forEach(frmGroup => {
      let quantity = Number(frmGroup.get('quantity').value);
      let price = Number(frmGroup.get('price').value);
      let invoiceAmount = Number(frmGroup.get('subTotal').value);
      let discount = Number(frmGroup.get('discountRate').value);
      let vat = Number(frmGroup.get('vat').value);
      this.totalInvoiceAmount += invoiceAmount;
      totalDiscountAmount += (price * quantity) * discount * 0.01;
      this.totalVatAmount += ((price * quantity) - (price * quantity) * discount * 0.01) * vat * 0.01;
    })
    this.invoiceForm.patchValue({
      totalVat: this.totalVatAmount,
      invoiceAmount: this.totalInvoiceAmount,
    })

  }
  onChangeDiscRate(index) {
    let discount = Number(this.productForm.value[index]["discountRate"]);
    if (discount > 100 || discount < 0) {
      this.productForm.controls[index].patchValue({
        discountRate: 0
      })
    }
  }
  onChangeVatRate(index) {
    let vat = Number(this.productForm.value[index]["vat"]);
    if (vat > 100 || vat < 0) {
      this.productForm.controls[index].patchValue({
        vat: 0
      })
    }
  }
  onInvoiceCalculation(){
    let invoiceAmount=Number(this.invoiceForm.value['invoiceAmount'])
    let shippingAmount=Number(this.invoiceForm.value['shippingAmount'])
    let discountRate=Number(this.invoiceForm.value['discountRate'])
    let discountAmt=Number(this.invoiceForm.value['discountAmt'])
    let totalVat=Number(this.invoiceForm.value['totalVat'])
    let lessAmt=Number(this.invoiceForm.value['lessAmt'])
    let cashAmt=Number(this.invoiceForm.value['cashAmt'])
    let advAmt=Number(this.invoiceForm.value['advAmt'])
    let chgeAmt=Number(this.invoiceForm.value['chgeAmt'])
    let discountAmount=(invoiceAmount+shippingAmount)*discountRate*0.01
    this.invoiceForm.patchValue({
      discountAmt:discountAmount,
      total:invoiceAmount+shippingAmount-discountAmount+totalVat-lessAmt-cashAmt+advAmt-chgeAmt
    })
  }
  onSelectCustomer(customer){
    if(customer){
      this.invoiceForm.patchValue({
        customerName:customer.customerName,
        customerMobile:customer.mobile,
        customerAddress:customer.address,
      })
    }
  }
  getProducts(){
    this.isLoading=true;
   this.invoiceService.getProducts().subscribe((response:any)=>{
    if(response.status){
    this.productList=response.result;
    }
    else{
      this.productList=[];
    }
  })
 }
  createNewItem(tempName){
    this.modalService.open(tempName,{size: 'lg', windowClass: 'my-class'})
  }

saveInvoice(){
    this.isSubmit = true;
    if (this.invoiceForm.invalid && this.productForm.invalid) {
      this.toasterService.error("Please fill the all required fields", "Invalid submission");
      return;
    } else{
      this.isSaved=true;
      let invoice=new InvoiceModel();
      invoice=this.invoiceForm.value;
      invoice.details=(this.productForm.value as InvoiceDetailsModel[]).filter(p => p.productId && Number(p.quantity) > 0) 
    this.invoiceService.saveInvoice(invoice).subscribe((response:any)=>{
      if(response.status){
        this.toasterService.success(response.result,"Success!");
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
    this.isLoading=false;
    this.isSaved=false;
    this.isSubmit=false;
    this.invoiceForm.reset();
    this.productForm=this.formBuilder.array([]);
    this.createForm();
  }
  createForm(){
    this.invoiceForm=this.formBuilder.group({
      customerId:[,[]],
      customerName:[,[]],
      customerMobile:[,[]],
      customerAddress:[,[]],
      invoiceDate:[,[]],
      invoiceDateNgb:[,[]],
      invoiceNo:[,[Validators.required]],
      outletId:[,[]],
      salesTypeId:[,[]],
      paymentTypeId:[,[]],
      invoiceTypeId:[,[]],
      refNo:[,[]],
      invoiceAmount:[,[]],
      shippingAmount:[,[]],
      discountRate:[,[]],
      discountAmt:[,[]],
      totalVat:[,[]],
      lessAmt:[,[]],
      cashAmt:[,[]],
      advAmt:[,[]],
      chgeAmt:[,[]],
      total:[,[]]

    })
  }
  removeRow(index: number) {  
    let deletedDiscount = this.productForm.value[index]['vatAmount'];
    let deletedRowTotalAmount = this.productForm.value[index]["subTotal"];
    this.invoiceForm.patchValue({
      totalVat: this.formVal.totalVat - deletedDiscount,
      invoiceAmount: this.formVal.invoiceAmount - deletedRowTotalAmount
    })
    this.productForm.removeAt(index);
  }
  get f(){
    return this.invoiceForm.controls;
  }
  get formVal() {
    return this.invoiceForm.value;
  }
}
