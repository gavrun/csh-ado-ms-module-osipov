using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DBConnection
{
    public partial class Form1 : Form
    {
        OleDbConnection connection = new OleDbConnection();

        //string testConnect = @"Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=testDB;Data Source=msi";
        string testConnect = @"Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=testDB;Data Source=msi";


        public Form1()
        {
            InitializeComponent();
        }

        private void toolStripMenuItem5_Click(object sender, EventArgs e)
        {
            try
            {
                if (connection.State != ConnectionState.Open)
                {
                    connection.ConnectionString = testConnect;

                    connection.Open();
                    MessageBox.Show("Connection successful");
                }
                else
                {
                    MessageBox.Show("Connection already established");
                }
            }
            catch
            {
                MessageBox.Show("Connection failed");
            }
        }

        private void toolStripMenuItem7_Click(object sender, EventArgs e)
        {
            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
                MessageBox.Show("Disconnected");
            }
            else
            {
                MessageBox.Show("No connection");
            }
        }
    }
}
