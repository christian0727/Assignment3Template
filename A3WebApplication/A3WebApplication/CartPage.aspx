<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="CartPage.aspx.cs" Inherits="A3WebApplication.CartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="w3-padding-64">
    <asp:GridView ID="gvCart" runat="server" OnRowCommand="gvCart_RowCommand">
        <Columns>
            <asp:ImageField DataImageUrlField="PrimaryImagePath" ControlStyle-Width="100px"  ControlStyle-Height="100px" DataImageUrlFormatString="Images/{0}"></asp:ImageField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnRemove" runat="server" CommandName="Remove" CommandArgument='<%# Eval("ProductID") %>' Text="Remove" />
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Upd" CommandArgument='<%# Eval("ProductID") %>' Text="Update Quantity" />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
    <asp:TextBox ID="txtQuantity" TextMode="Number" Visible="false" runat="server" Width="39px"></asp:TextBox>
    <asp:Button ID="btnUpdateQuantity" runat="server" Visible="false" Text="Enter New Quantity" OnClick="btnUpdateQuantity_Click" />
    Total Amount: <asp:TextBox ID="txtTotal" ReadOnly="true" runat="server"></asp:TextBox>
    <asp:Button ID="btnRemoveAll" runat="server" Text="Remove All Item" OnClick="btnRemoveAll_Click" />
    <asp:Button ID="btnCheckOut" runat="server" Text="Checkout" OnClick="btnCheckOut_Click" />
    </div>
</asp:Content>

<%-- 17 MARKS TOTAL
    1 BONUS MARK TOTAL
    TODO:
    - 2 MARKS: Show a GridView of the ShoppingCart CartItems.
    - BONUS 1 MARK: Show images on each row
    - 5 MARKS: Add functionality to Update the quantity of an item or all items in cart
    - 5 MARKS: Add functionality to Remove an item from the cart
    - 3 MARKS: Add Functionality to remove ALL items from the cart at once
    - 2 MARKS: Add functionality to check out (no need for payment page, assume they already have put in proper payment, just save to database that the order is complete!)--%>