using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

namespace InvoiceProject.Api.DbContext
{
    public class TestGetway
    {
       public static bool IsDbConnected()
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))

                try
                {
                    con.Open();
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }
}
