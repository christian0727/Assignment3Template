using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A3ClassLibrary
{
    public class Category
    {
        public int CategoryID { get; set; }
        public string Name { get; set; }
        public string ImagePath { get; set; }

        // TODO (2 MARKS)
        // Create a method for creating a new Category based on a CategoryID passed
        // Example: CategoryID 3 is passed, 3 is used as an SQL Param to retrieve a matching row in the database with CategoryID 3
        // populate a new Category instance with the values returned from the database

        public Category() { }
        public Category(int CategoryID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            d.AddParam("CategoryID", CategoryID);
            DataSet ds = d.ExecuteProcedure("spGetCategoriesByID");

            this.CategoryID = CategoryID;
            Name = ds.Tables[0].Rows[0]["Name"].ToString();
            ImagePath = ds.Tables[0].Rows[0]["ImagePath"].ToString();
        }

        // BONUS 1 MARK: write method which impliments spInsertCategory
        public void InsertCategory()
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            d.AddParam("Name", Name);
            d.AddParam("ImagePath", ImagePath);
            DataSet ds = d.ExecuteProcedure("spInsertCategory");
            this.CategoryID = Convert.ToInt32(ds.Tables[0].Rows[0]["NewCategoryID"].ToString());
        }

        // BONUS 1 MARK: write method which impliments spDeleteCategory
        public void DeleteCategory()
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            d.AddParam("CategoryID", CategoryID);
            d.ExecuteProcedure("spDeleteCategory");
        }
        // BONUS 1 MARK: write method which impliments spUpdateCategory
        public void UpdateCategory()
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            d.AddParam("Name", Name);
            d.AddParam("ImagePath", ImagePath);
            d.AddParam("CategoryID", CategoryID);
            d.ExecuteProcedure("spUpdateCategory");
        }

        public static List<Category> GetAllCategories()
        {
            List<Category> resultList = new List<Category>();

            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            DataSet ds = d.ExecuteProcedure("spGetCategories");

            foreach (DataRow category in ds.Tables[0].Rows)
            {
                Category newCategory = new Category()
                {
                    CategoryID = int.Parse(category["CategoryID"].ToString()),
                    Name = category["Name"].ToString(),
                    ImagePath = category["ImagePath"].ToString()
                };

                resultList.Add(newCategory);
            }
            return resultList;
        }
    }
}
