﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnProduct_Click(object sender, EventArgs e)
        {
            pnlMain.Visible = false;
            pnlProduct.Visible = true;
        }
    }
}