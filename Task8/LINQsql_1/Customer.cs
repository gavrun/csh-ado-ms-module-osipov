using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LINQsql_1
{
    [Table(Name = "Customers")]
    internal class Customer
    {
        private string _CustomerID;

        [Column(IsPrimaryKey = true, Storage = "_CustomerID")]
        public string CustomerID
        {
            get
            {
                return this._CustomerID;
            }
            set
            {
                this._CustomerID = value;
            }
        }

        private string _City;

        [Column(Storage = "_City")]
        public string City
        {
            get
            {
                return this._City;
            }
            set
            {
                this._City = value;
            }
        }

        public override string ToString()
        {
            return CustomerID + "\t" + City;
        }
    }
}
