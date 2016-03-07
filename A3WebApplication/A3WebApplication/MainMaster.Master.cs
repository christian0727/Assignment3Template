using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class MainMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // NOTE: You will need to use the Security Class to determine if logged in or not
            if (!IsPostBack)
            {
                if (Security.IsCustomerAdmin())
                {
                    hlLogin.Visible = false;
                    lbLogout.Visible = true;
                    hlAdmin.Visible = true;
                    lbMessage.Visible = true;
                    lbMessage.Text = "Welcome " + Security.CurrentCustomer.FirstName;
                    lbCount.Text = SessionCart.Instance.Cart.Count().ToString();
                }
                else if (Security.IsCustomerLoggedIn())
                {
                    hlLogin.Visible = false;
                    lbLogout.Visible = true;
                    lbMessage.Visible = true;
                    lbMessage.Text = "Welcome " + Security.CurrentCustomer.FirstName;
                    lbCount.Text = SessionCart.Instance.Cart.Count().ToString();
                }
                else
                {
                    hlLogin.Visible = true;
                    lbLogout.Visible = false;
                    hlAdmin.Visible = false;
                    lbMessage.Visible = false;
                    lbCount.Text = SessionCart.Instance.Cart.Count().ToString();
                }
            }

        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Security.LogOut();
            Response.Redirect("index.aspx");
        }
    }
}