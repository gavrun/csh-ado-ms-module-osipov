using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Linq;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace LINQsql_1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // oledb connection
            // Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Northwind;Data Source=MSI

            // data context
            DataContext db = new DataContext(@"Data Source=(local);Initial Catalog=Northwind;Integrated Security=True");

            // query 
            var results = from c in db.GetTable<Customer>()
                          where c.City == "London"
                          select c;

            // results
            listBox1.Items.Clear();

            foreach (var c in results)
            {
                listBox1.Items.Add(c.ToString()); // Add(c) already means ToString() is called
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            DataContext db = new DataContext(@"Data Source=(local);Initial Catalog=Northwind;Integrated Security=True");

            var custQuery =
                from cust in db.GetTable<Customer>()
                where cust.Orders.Any()
                select cust;

            foreach (var custObj in custQuery)
            {
                ListViewItem item = listView1.Items.Add(custObj.CustomerID.ToString());

                item.SubItems.Add(custObj.City.ToString());
                item.SubItems.Add(custObj.Orders.Count.ToString());
            }
        }
    }
}
