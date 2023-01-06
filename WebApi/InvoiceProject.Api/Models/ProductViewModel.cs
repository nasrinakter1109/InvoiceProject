using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.Models
{
    public class ProductViewModel:ProductModel
    {
        public string WarehouseName { get; set; }
    }
}
