using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.Helper
{
    public class CustomErrorException:Exception
    {
        public CustomErrorException() { }
        public CustomErrorException(string errMessage) : base("Execution error: "+errMessage) { }
    }
}
