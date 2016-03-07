using DAL_Project;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A3ClassLibrary
{
    public class CartItem : Product, IEquatable<CartItem>, IComparable<CartItem>
    {
        public int Quantity { get; set; }
        public double SubTotal { get { return Price * Quantity; } }

        public CartItem(int productID, int quantity)
        {
            Product myProduct = Product.GetProductByID(productID);
            this.Name = myProduct.Name;
            this.Price = myProduct.Price;
            this.PrimaryImagePath = myProduct.PrimaryImagePath;
            this.CategoryID = myProduct.CategoryID;
            this.ProductID = myProduct.ProductID;
            this.Quantity = quantity;
        }

        /// <summary>
        /// BONUS 2 MARKS. Make your Cart Items comparable by ProductID.
        /// Example: ProductID of 10 is greater than productID 3
        /// </summary>
        
        public void CheckOutItemDetail(int orderID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL d = new DAL(connStr);
            d.AddParam("OrderID", orderID);
            d.AddParam("ProductID", this.ProductID);
            d.AddParam("Quantity", this.Quantity);
            d.AddParam("SubTotal", this.SubTotal);

            d.ExecuteProcedure("spInsertOrderDetail");
        }

       public bool Equals(CartItem other)
        {
            if (other == null)
            {
                return false;
            }
            return this.ProductID == other.ProductID;
        }
 
        public int CompareTo(CartItem other)
        {
            return Quantity.CompareTo(other.Quantity);
        }
    }
}
