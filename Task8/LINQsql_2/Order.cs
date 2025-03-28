﻿using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LINQsql_1
{
    [Table(Name = "Orders")]
    internal class Order
    {
        private int _OrderID = 0;

        private string _CustomerID;

        private EntityRef<Customer> _Customer;

        public Order() 
        {
            this._Customer = new EntityRef<Customer>();
        }


        [Column(Storage = "_OrderID", DbType = "Int NOT NULL IDENTITY", IsPrimaryKey = true, IsDbGenerated = true)]
        public int OrderID
        {
            get { return this._OrderID; }
            // No need to specify a setter because IsDBGenerated is true.
        }

        [Column(Storage = "_CustomerID", DbType = "NChar(5)")]
        public string CustomerID
        {
            get { return this._CustomerID; }
            set { this._CustomerID = value; }
        }

        [Association(Storage = "_Customer", ThisKey = "CustomerID")]
        public Customer Customer
        {
            get { return this._Customer.Entity; }
            set { this._Customer.Entity = value; }
        }
    }
}
