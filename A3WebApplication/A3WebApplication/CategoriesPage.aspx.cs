using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class CategoriesPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dlCategory_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Response.Redirect("ProductsPage.aspx?CategoryID=" + e.CommandArgument.ToString());
        }
    }
}