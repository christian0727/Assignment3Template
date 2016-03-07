using A3ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class CartPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadgvCart();
                CalcTotal();
            }

        }
        public void CalcTotal()
        {
            txtTotal.Text = SessionCart.Instance.CalculateTotal().ToString();
        }
        public void loadgvCart()
        {
            gvCart.DataSource = SessionCart.Instance.Cart;
            gvCart.DataBind();
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int ID = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "Remove":
                    SessionCart.Instance.RemoveCartItem(ID);
                    loadgvCart();
                    CalcTotal();
                    txtQuantity.Text = "";
                    txtQuantity.Visible = false;
                    btnUpdateQuantity.Visible = false;
                    Response.Redirect(Request.RawUrl);
                    break;
                case "Upd":
                    Session["ID"] = e.CommandArgument;
                    txtQuantity.Visible = true;
                    btnUpdateQuantity.Visible = true;
                    break;
                default:
                    break;
            }

        }

        protected void btnRemoveAll_Click(object sender, EventArgs e)
        {
            SessionCart.AbandonCart();
            loadgvCart();
            CalcTotal();
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            if (txtTotal.Text == "0" || txtTotal.Text == "")
            {
                return;
            }
            else
            {
                if (!Security.IsCustomerLoggedIn())
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    int CustomerID = Security.CurrentCustomer.CustomerID;
                    SessionCart.Instance.CheckOut(CustomerID, DateTime.Now, "", SessionCart.Instance.CalculateTotal());
                    SessionCart.AbandonCart();
                    loadgvCart();
                    CalcTotal();
                }
            }
        }

        protected void btnUpdateQuantity_Click(object sender, EventArgs e)
        {
            try
            {
                SessionCart.Instance.UpdateCartItem(Convert.ToInt32(Session["ID"]), Convert.ToInt32(txtQuantity.Text));
                loadgvCart();
                CalcTotal();
                txtQuantity.Text = "";
                txtQuantity.Visible = false;
                btnUpdateQuantity.Visible = false;
            }
            catch
            {
                txtQuantity.Text = "";
                txtQuantity.Visible = false;
                btnUpdateQuantity.Visible = false;
            }
        }
    }
}