using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.Models
{
    public class InvoiceDetailsModel
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int InvoiceNo { get; set; }
        public decimal Quantity { get; set; }
        public int UnitId { get; set; }
        public decimal Price { get; set; }
        public decimal Amount { get; set; }
        public decimal DiscountRate { get; set; }
        public decimal DiscountAmount { get; set; }
        public decimal Vat { get; set; }
        public decimal VatAmount { get; set; }
        public decimal SubTotal { get; set; }
    }
}
