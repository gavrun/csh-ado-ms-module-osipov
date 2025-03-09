using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DataGridViewExample
{
    public partial class Form1: Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void customersBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.customersBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.northwindDataSet);

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'northwindDataSet.Customers' table. You can move, or remove it, as needed.
            this.customersTableAdapter.Fill(this.northwindDataSet.Customers);

            DataColumn Location = new DataColumn("Location");

            Location.Expression = "City + ',' + Country";

            northwindDataSet.Customers.Columns.Add(Location);
        }

        private void AddColumnButton_Click(object sender, EventArgs e)
        {
            DataGridViewTextBoxColumn LocationColumn = new DataGridViewTextBoxColumn();

            LocationColumn.Name = "LocationColumn";
            LocationColumn.HeaderText = "Location";
            LocationColumn.DataPropertyName = "Location";

            customersDataGridView.Columns.Add(LocationColumn);
        }

        private void DeleteColumnButton_Click(object sender, EventArgs e)
        {
            try
            {
                customersDataGridView.Columns.Remove("LocationColumn");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                //throw;
            }
        }

        private void GetClickedCellButton_Click(object sender, EventArgs e)
        {
            string CurrentCellInfo;

            CurrentCellInfo = customersDataGridView.CurrentCell.Value.ToString() + Environment.NewLine;

            CurrentCellInfo += "Column: " + customersDataGridView.CurrentCell.OwningColumn.DataPropertyName + Environment.NewLine;
            CurrentCellInfo += "Column Index: " + customersDataGridView.CurrentCell.ColumnIndex.ToString() + Environment.NewLine;
            CurrentCellInfo += "Row Index: " + customersDataGridView.CurrentCell.RowIndex.ToString() + Environment.NewLine;

            label1.Text = CurrentCellInfo;
        }

        private void customersDataGridView_CellValidating(object sender, DataGridViewCellValidatingEventArgs e)
        {
            if (customersDataGridView.Columns[e.ColumnIndex].DataPropertyName == "ContactName")
            {
                if (e.FormattedValue.ToString() == "")
                {
                    customersDataGridView.Rows[e.RowIndex].ErrorText = "ContactName is a required field";
                    e.Cancel = true;
                }
                else
                {
                    customersDataGridView.Rows[e.RowIndex].ErrorText = "";
                }
            }
        }

        private void ApplyStyleButton_Click(object sender, EventArgs e)
        {
            customersDataGridView.AlternatingRowsDefaultCellStyle.BackColor = Color.LightGray;
        }
    }
}
