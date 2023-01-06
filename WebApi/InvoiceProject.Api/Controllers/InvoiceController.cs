using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using InvoiceProject.Api.DbContext;
using InvoiceProject.Api.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceProject.Api.Controllers
{
    [ApiVersion("1")]
    [Route("api/[controller]/[action]")]
    public class InvoiceController : ControllerBase
    {
        private readonly InvoiceDb _invoiceDb;
        public InvoiceController()
        {
            _invoiceDb = new InvoiceDb();
        }

        ///Customer Enty
        [HttpPost]
        public IActionResult SaveCustomer([FromBody]CustomerModel customer)
        {
            try
            {
                (bool isSuccess, List<CustomerModel> customers) dbResponse;
                dbResponse = _invoiceDb.SaveCustomer(customer);
                if (dbResponse.isSuccess)
                {
                    return Ok(new { Status = true, Result = "Saved Successfully" ,CustomerList= dbResponse.customers });
                }
                else
                {
                    return Ok(new { Status = false, Result = "Failed to save" , CustomerList = dbResponse.customers });
                }
            }catch(Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpGet]
        public IActionResult GetCustomers()
        {
            try
            {
                
                List<CustomerModel> customers = _invoiceDb.GetCustomers();
                if (customers.Count>0)
                {
                    return Ok(new { Status = true, Result =customers });
                }
                else
                {
                    return Ok(new { Status = false, Result = "Data not Found" });
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        ///Product Enty 
        [HttpGet]
        public IActionResult GetWarehouses()
        {
            try
            {

                List<WarehouseModel> warehouses = _invoiceDb.GetWarehouses();
                if (warehouses.Count > 0)
                {
                    return Ok(new { Status = true, Result = warehouses });
                }
                else
                {
                    return Ok(new { Status = false, Result = "Data not Found" });
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpPost]
        public IActionResult SaveProduct([FromBody]ProductModel product)
        {
            try
            {
                bool isSuccess = _invoiceDb.SaveProduct(product);
                if (isSuccess)
                {
                    return Ok(new { Status = true, Result = "Saved Successfully" });
                }
                else
                {
                    return Ok(new { Status = false, Result = "Failed to save" });
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [Route("{id?}")]
        [HttpGet]
        public IActionResult GetProducts(int? id)
        {
            try
            {

                List<ProductViewModel> products = _invoiceDb.GetProducts(id);
                if (products.Count > 0)
                {
                    return Ok(new { Status = true, Result = products });
                }
                else
                {
                    return Ok(new { Status = false, Result = "Data not Found" });
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        //Invoice Enty
        [HttpGet]
        public IActionResult GetUnits()
        {
            try
            {

                List<UnitModel> units = _invoiceDb.GetUnits();
                if (units.Count > 0)
                {
                    return Ok(new { Status = true, Result = units });
                }
                else
                {
                    return Ok(new { Status = false, Result = "Data not Found" });
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpPost]
        public IActionResult SaveInvoice([FromBody]InvoiceModel invoice)
        {
            try
            {
                var IsSaved = _invoiceDb.SaveInvoice(invoice);
                if (IsSaved)
                {
                    return Ok(new { Status = true,  Result = "Invoice Saved Successfully." });
                }
                else
                {
                    return Ok(new { Status = false, result = "Failed to save Invoice." });
                }
            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
            }
        }
    }
}