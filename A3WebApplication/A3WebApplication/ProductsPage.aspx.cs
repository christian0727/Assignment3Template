using A3ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class ProductsPage : System.Web.UI.Page
    {
        // 5 MARKS TOTAL
        // 1 BONUS MARK TOTAL
        protected void Page_Load(object sender, EventArgs e)
        {
            /* TODO:
                - 3 MARKS: grab CategoryID from QueryString and Populate the products based on the CategoryID
            */
            if (!IsPostBack)
            {
                string Qs = Request.QueryString["CategoryID"];
                if (Qs != null)
                {
                    loadProducts(Convert.ToInt32(Qs));
                }
                else
                {
                    loadProducts(null);
                }
                
            }
        }
        private void loadProducts(int? ID)
        {
            dlProducts.DataSource = Product.GetProductsByCategoryID(ID);
            dlProducts.DataBind();
        }
        protected void dlProducts_ItemCommand(object source, DataListCommandEventArgs e)
        {
            /* TODO: 
                - 1 MARK:  get the right ProductID based on which product was clicked
                - BONUS 1 MARK:  get the quantity from the drop down if you made one
                - 1 MARK: Use the SessionCart's Instance to add a new Cart Item to the ShoppingCart and redirect to the CartPage
            */
            int ProductID = Convert.ToInt32(e.CommandArgument.ToString());
            switch(e.CommandName)
            {
                case "Add":
                    DropDownList ddlQuantity = e.Item.FindControl("ddlQuantity") as DropDownList;
                    int Quantity = Convert.ToInt32(ddlQuantity.SelectedValue);
                    SessionCart.Instance.AddToCart(ProductID, Quantity);
                    Response.Redirect("CartPage.aspx");                  
                    break;
                default:
                    break;
            }

        }
    }
}