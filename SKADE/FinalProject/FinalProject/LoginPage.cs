using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DataLibrary.AuthDSTableAdapters;
using DataLibrary;
using ClassLibrary;

namespace FinalProject
{
    public partial class LoginPage : Form
    {
               
        public LoginPage()
        {
            InitializeComponent();
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            Logins login = new Logins();
            AuthenticateTableAdapter taAuth = new AuthenticateTableAdapter();
            login.userName = textBox1.Text;
            login.passWord = textBox2.Text;
            try
            {
                DataTable dt = new DataTable();
                taAuth.Fill(authDS.Authenticate, login.userName, login.passWord);
                if (authDS.Tables[0].Rows.Count == 1)
                {
                    label3.Text = "Success!";
                    
                   // Application.Run(new Main());
                }
                else { label3.Text = "Failure!"; }
            }
            catch (Exception ex)
            {
                label3.Text = ex.Message;
            }

        }

        private void LoginPage_Load(object sender, EventArgs e)
        {
            



        }

        private void button1_Click_1(object sender, EventArgs e)
        {


        }
    }
}
