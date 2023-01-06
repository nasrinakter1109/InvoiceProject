using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceProject.Api.DbContext
{
    public class CustomValidation
    {
        public static List<T> IsExist<T>(string tableName, string columnName, string value)
        {
            using (var con = new SqlConnection(Connection.ConnectionString()))
            {
                string sql = $"SELECT * FROM {tableName} WHERE  {columnName} = '{value}'";
                var rows = con.Query<T>(sql).ToList();
                return rows;
            }

        }
    }
}
