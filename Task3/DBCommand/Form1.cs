using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace DBCommand
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();

            sqlCommand1.CommandType = CommandType.Text;

            sqlConnection1.Open();

            SqlDataReader reader = sqlCommand1.ExecuteReader();

            bool MoreResults = false;

            do
            {
                while (reader.Read())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        results.Append(reader[i].ToString() + "\t");
                    }
                    results.Append(Environment.NewLine);
                }
                MoreResults = reader.NextResult();
            }
            while (MoreResults);

            MoreResults = reader.NextResult();

            reader.Close();

            sqlCommand1.Connection.Close();

            textBox1.Text = results.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();

            //sqlCommand2.CommandType = CommandType.StoredProcedure;
            sqlCommand2.CommandText = "Ten Most Expensive Products";

            sqlCommand2.Connection.Open();

            SqlDataReader reader = sqlCommand2.ExecuteReader();

            while (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    results.Append(reader[i].ToString() + "\t");
                }
                results.Append(Environment.NewLine);
            }

            reader.Close();

            sqlCommand2.Connection.Close();

            textBox2.Text = results.ToString();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                sqlCommand3.CommandType = CommandType.Text;

                sqlCommand3.CommandText =
                    "CREATE TABLE SalesPersons (" +
                    "[SalesPersonID] [int] IDENTITY(1,1) NOT NULL, " +
                    "[FirstName] [nvarchar](50)  NULL, " +
                    "[LastName] [nvarchar](50)  NULL)";

                sqlCommand3.Connection.Open();

                sqlCommand3.ExecuteNonQuery();

                label1.Text = "Table [SalesPersons] created";
                MessageBox.Show("Table [SalesPersons] created");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                //throw;
            }
            finally
            {
                sqlCommand3.Connection.Close();
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();

            sqlCommand4.CommandType = CommandType.Text;

            sqlCommand4.Parameters["@City"].Value = textBox3.Text;

            sqlConnection1.Open();

            SqlDataReader reader = sqlCommand4.ExecuteReader();

            bool MoreResults = false;

            do
            {
                while (reader.Read())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        results.Append(reader[i].ToString() + "\t");
                    }
                    results.Append(Environment.NewLine);
                }
                MoreResults = reader.NextResult();
            }
            while (MoreResults);

            reader.Close();

            sqlCommand4.Connection.Close();

            textBox3.Text = results.ToString();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();

            sqlCommand5.Parameters["@CategoryName"].Value = textBox4.Text;
            sqlCommand5.Parameters["@OrdYear"].Value = textBox5.Text;

            sqlCommand5.Connection.Open();

            SqlDataReader reader = sqlCommand5.ExecuteReader();

            while (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    results.Append(reader[i].ToString() + "\t");
                }
                results.Append(Environment.NewLine);
            }

            reader.Close();

            sqlCommand5.Connection.Close();

            textBox6.Text = results.ToString();
        }
    }
}