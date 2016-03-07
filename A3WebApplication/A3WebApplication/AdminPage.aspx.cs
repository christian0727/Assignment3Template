using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using A3ClassLibrary;
using DAL_Project;

namespace A3WebApplication
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!Security.IsCustomerAdmin())
                {
                    Response.Redirect("Index.aspx");
                }
                else
                {
                loadGridview();
                loadCatGridView();
                }
              
            }
        }

        private void loadCatGridView()
        {
            gvCategory.DataBind();
        }

        private void loadGridview()
        {
            var d = new DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            ViewState["gv"] = d.ExecuteProcedure("spGetProductByID").Tables[0];
            gvProducts.DataSource = (DataTable)ViewState["gv"];
            gvProducts.DataBind();
        }

        protected void gvProducts_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            loadGridview();
            gvProducts.PageIndex = e.NewPageIndex;
            gvProducts.DataBind();
        }

        protected void gvProducts_OnSorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dt = (DataTable)ViewState["gv"];

            if (dt != null)
            {
                dt.DefaultView.Sort = e.SortExpression + " " + SortDir(e.SortExpression);
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }
        private string SortDir(string sCurrent)
        {
            string sDir = "asc";
            string sLastColumn = (ViewState["Column"] != null ? ViewState["Column"].ToString() : "");
            if (sLastColumn == sCurrent)
            { 
                sDir = (ViewState["SortDirection"].ToString() == "asc" ? "desc" : "asc");
            }
            else
            {
                ViewState["Column"] = sCurrent;
            }
            ViewState["SortDirection"] = sDir;
            return sDir;
        }

        protected void gvProducts_OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            loadGridview();
        }

        protected void gvProducts_OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int ProductID = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Values[0]);
                Product p = new Product();
                p.DeleteProduct(ProductID);
            }
            catch (Exception)
            {
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('Cannot Delete! Product is in Use!')", true);
            }
        }

        protected void gvProducts_OnRowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            loadGridview();
        }

        protected void gvProducts_OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Product p = new Product();
            var Row = gvProducts.Rows[e.RowIndex];
            string ProductID = gvProducts.DataKeys[e.RowIndex].Values[0].ToString();
            TextBox Name = (TextBox)gvProducts.Rows[e.RowIndex].FindControl("tbName");
            TextBox Price = (TextBox)gvProducts.Rows[e.RowIndex].FindControl("tbPrice");
            var CategoryID = (Row.FindControl("ddlCategories") as DropDownList).SelectedValue;
            var ImageUpload = (FileUpload)Row.FindControl("uploadImage");

            if (ImageUpload.HasFile)
            {
                string ImageName = Path.GetFileName(ImageUpload.FileName);
                ImageUpload.SaveAs(Server.MapPath("/Images") + ImageName);
                p.UpdateProduct(Convert.ToInt32(CategoryID), Convert.ToInt32(ProductID),Name.Text,Convert.ToDouble(Price.Text), ImageName);
                gvProducts.EditIndex = -1;
                loadGridview();
            }

            else
            {
                p.UpdateProduct(Convert.ToInt32(CategoryID), Convert.ToInt32(ProductID), Name.Text, Convert.ToDouble(Price.Text), null);
                gvProducts.EditIndex = -1;
                loadGridview();
            }
        }

        protected void gvProducts_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add"))
            {
                Product p = new Product();
                string Name = ((TextBox)gvProducts.FooterRow.FindControl("tbInsertName")).Text;
                string Price = ((TextBox)gvProducts.FooterRow.FindControl("tbInsertPrice")).Text;
                var CategoryID = (gvProducts.FooterRow.FindControl("ddlInsertCategory") as DropDownList).SelectedValue;
                var ImageUpload = (FileUpload)gvProducts.FooterRow.FindControl("uploadNewImage");

                if (ImageUpload.HasFile)
                {
                    try
                    {
                        string ImageName = Path.GetFileName(ImageUpload.FileName);
                        ImageUpload.SaveAs(Server.MapPath("/Images") + ImageName);
                        p.InsertProduct(Convert.ToInt32(CategoryID), Name, Convert.ToDouble(Price), ImageName);
                        gvProducts.EditIndex = -1;
                        loadGridview();
                    }
                    catch
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('Invalid Input on Name or Price!')", true);
                    }
                }

                else
                {
                    try
                    {
                        string ImageName = "NoImage.jpg";
                        ImageUpload.SaveAs(Server.MapPath("/Images") + ImageName);
                        p.InsertProduct(Convert.ToInt32(CategoryID), Name, Convert.ToDouble(Price), ImageName);
                        gvProducts.EditIndex = -1;
                        loadGridview();
                    }
                    catch
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('Invalid Input on Name or Price!')", true);
                    }
                }
            }
        }

        protected void gvProducts_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            var d = new DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlCategory = (DropDownList)e.Row.FindControl("ddlCategories");
                    ddlCategory.DataSource = d.ExecuteProcedure("spGetCategoryByID");
                    ddlCategory.DataValueField = "CategoryID";
                    ddlCategory.DataTextField = "Name";
                    ddlCategory.DataBind();
                }
            }
        }

        protected void gvProducts_OnDataBound(object sender, EventArgs e)
        {
            var d = new DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            DropDownList ddlInsertCategory = (DropDownList)gvProducts.FooterRow.FindControl("ddlInsertCategory");
            ddlInsertCategory.DataSource = d.ExecuteProcedure("spGetCategoryByID");
            ddlInsertCategory.DataValueField = "CategoryID";
            ddlInsertCategory.DataTextField = "Name";
            ddlInsertCategory.DataBind();
        }

        protected void btnProduct_Click(object sender, EventArgs e)
        {
            pnlMain.Visible = false;
            loadGridview();
            pnlProduct.Visible = true;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlMain.Visible = true;
            pnlProduct.Visible = false;
            pnlCustomer.Visible = false;
            pnlCategory.Visible = false;
        }

        protected void btnCategories_Click(object sender, EventArgs e)
        {
            pnlMain.Visible = false;
            pnlCategory.Visible = true;
        }

        protected void btnCustomer_Click(object sender, EventArgs e)
        {
            pnlMain.Visible = false;
            pnlCustomer.Visible = true;
        }

        protected void lbAdd_Click(object sender, EventArgs e)
        {
            if (tbName.Text != "")
            {
                if (fuImagePath.HasFile)
                {
                    string ImageName = Path.GetFileName(fuImagePath.FileName);
                    fuImagePath.SaveAs(Server.MapPath("/Images") + ImageName);
                    Category c = new Category();
                    c.InsertCategory(tbName.Text, ImageName);
                    tbName.Text = "";
                }
                else
                {
                    Category c = new Category();
                    c.InsertCategory(tbName.Text, "NoImage.jpg");
                    tbName.Text = "";
                }
                loadCatGridView();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "ClientScript", "alert('Please Put Category Name')", true);
            }
        }

    }
}