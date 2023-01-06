using Dapper;
using InvoiceProject.Api.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.DbContext
{
    public class InvoiceDb
    {

        /// Customer Entry
        public (bool IsSaved, List<CustomerModel> customers) SaveCustomer(CustomerModel customer)
        {
            using (var con=new SqlConnection(Connection.ConnectionString()))
            {
                var existCustomers = CustomValidation.IsExist<CustomerModel>("Customer", "CustomerName", customer.CustomerName);
                if (existCustomers.Count > 0 && existCustomers.Any(c => c.Id != customer.Id))
                {
                  throw new Exception($"{customer.CustomerName} already exist");                 
                 
                }
                con.Open();
                using (var tran = con.BeginTransaction())
                {
                    try
                    {
                        var param = new
                        {
                            customer.Id,
                            customer.CustomerName,
                            customer.CustomerType,
                            customer.EntyDate,
                            customer.Address,
                            customer.Mobile,
                            customer.PhoneNo,
                            customer.Fax,
                            customer.Email
                        };
                        int rowEffect = con.Execute("SP_CustomerSave", param: param, transaction: tran, commandType: CommandType.StoredProcedure);
                        bool isSuccess = false;
                        isSuccess=rowEffect > 0;
                        List<CustomerModel> customerList = con.Query<CustomerModel>($"SELECT * FROM Customer", transaction: tran,commandType:CommandType.Text).ToList();
                        if (isSuccess)
                        {
                            tran.Commit();
                        }
                        else { tran.Rollback(); }
                        return (isSuccess, customerList);
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        throw new Exception(ex.Message);
                    }

                }
               
            }
        }
        public List<CustomerModel> GetCustomers()
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {               
                List<CustomerModel> result  = con.Query<CustomerModel>($"SELECT * FROM Customer").ToList();
                return result;
            }
        }
        public List<WarehouseModel> GetWarehouses()
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {
                List<WarehouseModel> result = con.Query<WarehouseModel>($"SELECT * FROM Warehouse").ToList();
                return result;
            }
        }

        ///Product Enty
        public bool  SaveProduct(ProductModel product)
        {
            var existCustomers = CustomValidation.IsExist<CustomerModel>("Product", "ProductName", product.ProductName);
            if (existCustomers.Count > 0 && existCustomers.Any(c => c.Id != product.Id))
            {
                throw new Exception($"{product.ProductName} already exist");

            }
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {
                var param = new
                {
                    product.Id,
                    product.ProductName,
                    product.Description,
                    product.WarehouseId,
                    product.Quantity
                };
                int rowEffect = con.Execute("SP_ProductSave", param: param,commandType: CommandType.StoredProcedure);
                return rowEffect > 0;
            }
        }
        public List<ProductViewModel> GetProducts(int? id)
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {
                string sql = (id != null && id > 0) ? $"SELECT  dbo.Product.*, dbo.Warehouse.WarehouseName FROM  dbo.Product INNER JOIN dbo.Warehouse ON dbo.Product.WarehouseId = dbo.Warehouse.Id WHERE dbo.Product.Id={id}" : $"SELECT  dbo.Product.*, dbo.Warehouse.WarehouseName FROM dbo.Product INNER JOIN dbo.Warehouse ON dbo.Product.WarehouseId = dbo.Warehouse.Id";
                List<ProductViewModel> result = con.Query<ProductViewModel>(sql).ToList();
                return result;
            }
        }
        //Invoice Enty
        public List<UnitModel> GetUnits()
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {
                string sql =$"SELECT  * FROM Unit";
                List<UnitModel> result = con.Query<UnitModel>(sql).ToList();
                return result;
            }
        }
        public bool  SaveInvoice(InvoiceModel invoice)
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {
                con.Open();
                using (var tran = con.BeginTransaction())
                {
                    try
                    {
                        bool isSuccess = false;
                        var param = new
                        {
                            invoice.Id,
                            invoice.CustomerId,
                            invoice.InvoiceDate,
                            invoice.InvoiceNo,
                            invoice.OutletId,
                            invoice.SalesTypeId,
                            invoice.PaymentTypeId,
                            invoice.InvoiceTypeId,
                            invoice.RefNo,
                            invoice.InvoiceAmount,
                            invoice.ShippingAmount,
                            invoice.DiscountRate,
                            invoice.DiscountAmt,
                            invoice.TotalVat,
                            invoice.LessAmt,
                            invoice.CashAmt,
                            invoice.AdvAmt,
                            invoice.ChgeAmt,
                            invoice.Total
                        };
                        int rowEffect = con.ExecuteScalar<int>("usp_Invoice_Save", param: param, transaction: tran, commandType: CommandType.StoredProcedure);
                        isSuccess = rowEffect > 0;
                        foreach (var detail in invoice.Details)
                        {

                            var detailsParam = new
                            {
                                detail.Id,
                                detail.ProductId,
                                detail.InvoiceNo,
                                detail.Quantity,
                                detail.UnitId,
                                detail.Price,
                                detail.Amount,
                                detail.DiscountRate,
                                detail.DiscountAmount,
                                detail.Vat,
                                detail.VatAmount,
                                detail.SubTotal
                            };

                            isSuccess = con.Execute("usp_Invoice_Detail_Save", param: detailsParam, transaction: tran, commandType: CommandType.StoredProcedure) > 0;
                        }
                        if (isSuccess)
                        {
                            tran.Commit();
                        }
                        else { tran.Rollback(); }
                        return isSuccess;
                    }
                    catch (Exception err)
                    {
                        tran.Rollback();
                        throw new Exception(err.Message);
                    }
                }

            }
        }
    }
}
