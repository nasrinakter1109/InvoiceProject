import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { InvoiceService } from '../../services/invoice.service';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.scss','../../../vendor/libs/ng-select/ng-select.scss']
})
export class ProductComponent implements OnInit {

  constructor(
    private formBuilder:FormBuilder,
    private toasterService:ToastrService,
    private invoiceService:InvoiceService
  ) { }
  productForm:FormGroup;
  warehouseList:any[]=[];
  productList:any[]=[];
  isLoading:boolean=false;
  btnSave:string="Create";
  isSaved:boolean=false;
  isSubmit:boolean=false;
  ngOnInit() {
    this.getWarehouses();
    this.getProducts();
    this.createForm();
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
 getProducts(){
   this.isLoading=true;
  this.invoiceService.getProducts().subscribe((response:any)=>{
   if(response.status){
   this.productList=response.result;
   this.isLoading=false;
   }
   else{
     this.productList=[];
     this.isLoading=false;
   }
 })
}
onSelectEdit(id:number){
  this.invoiceService.getProducts(id).subscribe((response:any)=>{
    if(response.status){
    this.productForm.patchValue(response.result[0]);
    this.btnSave="Update";
    }    
  })
}
  saveProduct(){
    this.isSubmit = true;
    if (this.productForm.invalid) {
      this.toasterService.error("Please fill the all required fields", "Invalid submission");
      return;
    } else{
    this.isSaved=true;
    this.invoiceService.saveProduct(this.productForm.value).subscribe((response:any)=>{
      if(response.status){
        this.toasterService.success(response.result,"Success!");
        this.reset();
      }else{
        this.toasterService.success(response.result,"Failed!");
        this.isSaved=false;
      }
    },(err:any)=>{
      this.toasterService.success(err.error,"Error!");
      this.isSaved=false;

    })}
  }
  reset(){
    this.isSaved=false;
    this.btnSave="Create";
    this.isSubmit=false;
    this.productForm.reset();
    this.createForm();
    this.getWarehouses();
    this.getProducts();
  }
  createForm(){
    this.productForm=this.formBuilder.group({
      id :[0,[]],
      warehouseId :[,[Validators.required]],
      description :[,[]],
      quantity :[0,[]],
      productName :[,[Validators.required]],
    })
  }
  get f(){
    return this.productForm.controls;
  }

}
