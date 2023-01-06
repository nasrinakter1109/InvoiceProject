using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.Models
{
    public class InvoiceModel
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public DateTime InvoiceDate { get; set; }
        public int InvoiceNo { get; set; }
        public int OutletId { get; set; }
        public int SalesTypeId { get; set; }
        public int PaymentTypeId { get; set; }
        public int InvoiceTypeId { get; set; }
        public string RefNo { get; set; }
        public decimal InvoiceAmount { get; set; }
        public decimal ShippingAmount { get; set; }
        public decimal DiscountRate { get; set; }
        public decimal DiscountAmt { get; set; }
        public decimal TotalVat { get; set; }
        public decimal LessAmt { get; set; }
        public decimal CashAmt { get; set; }
        public decimal AdvAmt { get; set; }
        public decimal ChgeAmt { get; set; }
        public decimal Total { get; set; }
        public List<InvoiceDetailsModel> Details { get; set; }
    }
}
