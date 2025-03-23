using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LINQsqlSproc
{
    public partial class Form1 : Form
    {
        //does not apply here
        //Northwind db = new Northwind(@"c:\SQL Server 2000 Sample Databases\northwnd.mdf");

        // oledb connection
        // Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Northwind;Data Source=MSI

        Northwind db = new Northwind(@"Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Northwind;Data Source=MSI");

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // [Northwind.CustOrdersDetailResult]
            // SELECT ProductName,
            // UnitPrice = ROUND(Od.UnitPrice, 2),
            // Quantity,
            // Discount = CONVERT(int, Discount * 100),
            // ExtendedPrice = ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
            // FROM Products P, [Order Details] Od
            // WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID

            string param = textBox1.Text;

            var custquery = db.CustOrdersDetail(Convert.ToInt32(param));

            string msg = "";
            foreach (CustOrdersDetailResult custOrdersDetail in custquery)
            {
                msg += custOrdersDetail.ProductName + "\n";
            }

            if (msg == "")
                msg = "No results";

            MessageBox.Show(msg);

            param = "";
            textBox1.Text = "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            // [Northwind.CustOrderHistResult]
            // SELECT ProductName, Total = SUM(Quantity)
            // FROM Products P, [Order Details] OD, Orders O, Customers C
            // WHERE C.CustomerID = @CustomerID
            // AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
            // GROUP BY ProductName

            string param = textBox2.Text;

            var custquery = db.CustOrderHist(param);

            string msg = "";
            foreach (CustOrderHistResult custOrdHist in custquery)
            {
                msg += custOrdHist.ProductName + "\n";
            }

            if (msg == "")
                msg = "No results";

            MessageBox.Show(msg);

            param = "";
            textBox2.Text = "";
        }
    }
}
