using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.Models
{
    public class ProductModel
    {
        public int Id { get; set; }
        public int? WarehouseId { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public string ProductName { get; set; }
    }
}
