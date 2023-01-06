using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.Models
{
    public class CustomerModel
    {
        public int Id { get; set; }
        public string CustomerName { get; set; }
        public string CustomerType { get; set; }
        public DateTime? EntyDate { get; set; }
        public string Address { get; set; }
        public string Mobile { get; set; }
        public string PhoneNo { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
    }
}
