using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CodeFirst
{
    public class Model
    {

    }

    public class Customer
    {
        // Properties
        public int CustomerId { get; set; } // Primary key

        [Required]
        [MaxLength(30)]
        public string Name { get; set; }

        [MaxLength(100)]
        public string Email { get; set; }

        [Range(8, 100)]
        public int Age { get; set; }

        [Column(TypeName = "image")]
        public byte[] Photo { get; set; }

        // Link to the list of orders
        public virtual List<Order> Orders { get; set; } // Navigation property and foreign key, one-to-many relationship

        // Constructor
        public Customer()
        {
            Orders = new List<Order>(); // avoid null reference exception
        }

        // return a string representation of the object to pass to controls
        public override string ToString()
        {
            string s = Name + ", email address: " + Email;
            return s;
        }
    }

    public class Order
    {
        public int OrderId { get; set; } // Primary key
        public string ProductName { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public DateTime PurchaseDate { get; set; }

        // Link to the customer
        public Customer Customer { get; set; } // many-to-one relationship

        public override string ToString()
        {
            string s = ProductName + " " + Quantity + "pcs., date: " + PurchaseDate;
            return s;
        }
    }
}
