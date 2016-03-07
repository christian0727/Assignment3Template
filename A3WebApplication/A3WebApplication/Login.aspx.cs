using A3ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO: must use the Security Class to login and to check for access level (admin or not)
            if (Security.IsCustomerAdmin())
            {
                Response.Redirect("AdminPage.aspx");
            }
            else if (Security.IsCustomerLoggedIn())
            {
                Response.Redirect("CategoriesPage.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            { 
            Security.Login(txtUserName.Text, txtPassword.Text);
            if (Security.IsCustomerAdmin())
                {
                    Response.Redirect("AdminPage.aspx");
                }
            else if (Security.IsCustomerLoggedIn())
                {
                    Response.Redirect("CategoriesPage.aspx");
                }
            }
            catch (Exception)
            {
                lbMessage.Visible = true;
            }
        }

        protected void lbRegister_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = false;
            pnlRegister.Visible = true;
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                Customer customer = new Customer();
                customer.InsertCustomer(txtFirstName.Text, txtLastName.Text, txtAddress.Text, txtCity.Text, txtPhoneNumber.Text, txtRegUserName.Text, txtRegPassword.Text, false);
                txtFirstName.Text = "";
                txtLastName.Text = "";
                txtAddress.Text = "";
                txtCity.Text = "";
                txtPhoneNumber.Text = "";
                txtRegPassword.Text = "";
                txtRegUserName.Text = "";
                pnlLogin.Visible = true;
                pnlRegister.Visible = false;
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('UserName is Already Taken')", true);
            }
        }
    }
}