import { InvoiceDetailsModel } from "./invoice-details-model";

export class InvoiceModel {
    customerId:number;
    invoiceDate:any;
    invoiceNo:number;
    outletId:number;
    salesTypeId:number;
    paymentTypeId:number;
    invoiceTypeId:number;
    refNo:string;
    invoiceAmount:number;
    shippingAmount:number;
    discountRate:number;
    discountAmt:number;
    totalVat:number;
    lessAmt:number;
    cashAmt:number;
    advAmt:number;
    chgeAmt:number;
    total:number;
    details:InvoiceDetailsModel[];
}
