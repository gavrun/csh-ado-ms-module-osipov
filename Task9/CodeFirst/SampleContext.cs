using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirst
{
    public class SampleContext : DbContext
    {
        // EF uses this constructor to create a connection to the database
        public SampleContext() : base("name=SampleContext") // Connection string name
        {
        }

        // OLE DB initstring does not apply to EF
        //Provider=SQLOLEDB.1;Integrated Security = SSPI; Persist Security Info=False;Initial Catalog = Northwind; Data Source = MSI

        // .NET Framework Data Provider for SQL Server
        // Data Source=MSI;Initial Catalog=Northwind;Integrated Security=True;Encrypt=False
        // System.Data.SqlClient

        // DbSet represents a table in the database
        public DbSet<Customer> Customers { get; set; } // not lazy loading by default
        public DbSet<Order> Orders { get; set; }
    }
}
