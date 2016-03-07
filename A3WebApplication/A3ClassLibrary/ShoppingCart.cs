using DAL_Project;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace A3ClassLibrary
{
    // 15 MARKS TOTAL
    public class ShoppingCart
    {
        public List<CartItem> Cart { get; set; }
        

        // TODO 1 MARK: Initialize the Cart in a constructor
        public ShoppingCart()
        {
            Cart = new List<CartItem>();
        }

        /// <summary>
        /// Create a new CartItem based on parameters and adds it to the List<CartItem>.
        /// </summary>
        public void AddToCart(int productID, int quantity)
        {
            // TODO (1 MARK): Add the new item into the cart.
            // BONUS MARK: Check to see if the item already exists, if so, update it by the quantity value in the parameter.
            CartItem item = new CartItem(productID, quantity);
            if (Cart.Contains(item))
            {
                foreach (CartItem i in Cart)
                {
                    if (i.Equals(item))
                    {
                        i.Quantity = i.Quantity + quantity;
                        return;
                    }
                }
            }
            else
            {
                item.Quantity = quantity;
                Cart.Add(item);
            }     
        }

        /// <summary>
        /// If a CartItem exists in our current Cart based on the productID passed, it will be replaced with the new quantity value.
        /// </summary>
        public void UpdateCartItem(int productID, int quantity)
        {
            CartItem updateItem = new CartItem(productID, quantity);
            // TODO (3 MARKS)
            foreach (CartItem item in Cart)
            {
                if (item.Equals(updateItem))
                {
                    item.Quantity = quantity;
                    return;
                }
            }
        }

        /// <summary>
        /// Removes a product from the current Cart based on the productID passed.
        /// </summary>
        /// <param name="productID">Product to remove</param>
        public void RemoveCartItem(int productID)
        {
            // TODO (3 MARKS)
            // BONUS MARK: Provide feedback when the productID does not exist in the Cart (return a bool? throw an exception?)
            CartItem item = new CartItem(productID, -1);
            Cart.Remove(item);
        }

        /// <summary>
        /// returns a CartItem based on the productID if it exists in the cart
        /// </summary>
        /// <param name="productID">The product ID to search for</param>
        /// <returns>CartItem built from productID or null if none found matching</returns>
        /// 
        public CartItem GetCartItem(int? productID)
        {
            Cart.Find(CartItem => CartItem.ProductID == productID);
            return GetCartItem(productID);
        }
        /// <summary>
        /// Creates necessary inserts into the DB based on the cart items.
        /// </summary>
        /// <returns>OrderID based on database</returns>
        public int CheckOut(int CustomerID, DateTime date, string comments, object PricePaid)
        {
            DAL d = new DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            d.AddParam("CustomerID", CustomerID);
            d.AddParam("OrderDate", date);
            d.AddParam("PricePaid", this.CalculateTotal());
            DataSet ds = d.ExecuteProcedure("spInsertOrder");
            int orderId = int.Parse(ds.Tables[0].Rows[0]["NewOrderID"].ToString());

            foreach (CartItem item in Cart)
            {
                item.CheckOutItemDetail(orderId);
            }

            return orderId;
        }
        
        public double CalculateTotal()
        {
            double sum = 0;

            // TODO (2 marks): Finish this method, it should return a total of all the item costs multiplied by their quantity
            sum = Cart.Sum(CartItem => CartItem.SubTotal);

            return sum;
        }
        
        // TODO (2 MARKS): return a boolean expression which returns true when the Cart is empty
        public bool IsEmpty()
        {
            if (Cart.Count == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
