using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CustomerManager
{
    internal class SampleContext : DbContext
    {
        public SampleContext() : base("name=SampleContext") 
        {
        }

        public DbSet<Customer> Customers { get; set; } 
        public DbSet<Order> Orders { get; set; }

        public DbSet<VipOrder> VipOrders { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Customer>()
                .Property(c => c.LastName)
                .IsRequired()
                .HasMaxLength(30);
        }
    }
}
