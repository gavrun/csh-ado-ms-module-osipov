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
using System.Data.SqlClient;
using System.Configuration;


namespace DBConnection
{
    public partial class Form1 : Form
    {
        OleDbConnection connection = new OleDbConnection();

        // correct
        //string testConnect = @"Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=testDB;Data Source=msi";

        // failed
        //string testConnect = @"Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=wrongdbname;Data Source=msi";

        string testConnect = GetConnectionStringByName("DBConnect.testDB");

        public Form1()
        {
            InitializeComponent();

            this.connection.StateChange += new StateChangeEventHandler(this.connection_StateChange);
        }

        static string GetConnectionStringByName(string name)
        {
            string returnValue = null;
            ConnectionStringSettings settings = ConfigurationManager.ConnectionStrings[name];
            if (settings != null)
                returnValue = settings.ConnectionString;
            return returnValue;
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
            catch (OleDbException ex)
            {
                foreach (OleDbError se in ex.Errors)
                {
                    MessageBox.Show(se.Message, "SQL Error code " + se.NativeError, MessageBoxButtons.OK, MessageBoxIcon.Information);
                }

                //MessageBox.Show("Connection failed");
            }
            catch (Exception exp)
            {
                MessageBox.Show(exp.Message, "Unexpected Exception", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void connection_StateChange(object sender, StateChangeEventArgs e)
        {
            toolStripMenuItem5.Enabled = (e.CurrentState == ConnectionState.Closed);
            toolStripMenuItem7.Enabled = (e.CurrentState == ConnectionState.Open);

            //MessageBox.Show("Connection state changed event fired");
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

        private void toolStripMenuItem2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void toolStripMenuItem8_Click(object sender, EventArgs e)
        {
            ConnectionStringSettingsCollection settings = ConfigurationManager.ConnectionStrings;

            if (settings != null)
            {
                foreach (ConnectionStringSettings cs in settings)
                {
                    MessageBox.Show(cs.Name);
                    MessageBox.Show(cs.ProviderName);
                    MessageBox.Show(cs.ConnectionString);
                }
            }
        }
    }
}
