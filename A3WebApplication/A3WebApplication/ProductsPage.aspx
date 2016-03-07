<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="ProductsPage.aspx.cs" Inherits="A3WebApplication.ProductsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server"> 
    <asp:DataList ID="dlProducts" runat="server"  OnItemCommand="dlProducts_ItemCommand" DataKeyField="ProductID" RepeatColumns="4"  RepeatLayout="Table" RepeatDirection="Horizontal" >
        <ItemTemplate>
            ProductID:
            <asp:Label Text='<%# Eval("ProductID") %>' runat="server" ID="ProductIDLabel" />&nbsp&nbsp
            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /><br />
            Image:
            <asp:Image ID="ImageProduct" ImageUrl='<%# Eval("PrimaryImagePath", "~/Images/{0}") %>' Width="100px" Height="100px" runat="server" /><br />
            <br />
            Price:
            <asp:Label Text='<%# Eval("Price") %>' runat="server" ID="PriceLabel" />&nbsp&nbsp 
            Quantity: 
            <asp:DropDownList ID="ddlQuantity" i runat="server">
                <asp:ListItem>1</asp:ListItem>
                <asp:ListItem>2</asp:ListItem>
                <asp:ListItem>3</asp:ListItem>
                <asp:ListItem>4</asp:ListItem>
                <asp:ListItem>5</asp:ListItem>
                <asp:ListItem>6</asp:ListItem>
                <asp:ListItem>7</asp:ListItem>
                <asp:ListItem>8</asp:ListItem>
                <asp:ListItem>9</asp:ListItem>
                <asp:ListItem>10</asp:ListItem>    
            </asp:DropDownList><br />
             <asp:Button ID="btnAdd" runat="server" Text="Add to Cart" CommandName="Add" CommandArgument='<%# Eval("ProductID") %>' />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:dbA3ConnStr %>' SelectCommand="SELECT * FROM [tbProduct]"></asp:SqlDataSource>
</asp:Content>
<%--            4 MARKS TOTAL
            1 BONUS MARK TOTAL
            TODO:
            - 2 MARKS: Display a DataList of Products with basic information provided (Name/Price)
            - 1 MARK: Also display the product Image
            - 1 MARK: Make a button to "Add to Cart", this will fire the dlProducts_ItemCommand event (see code behind)
            - BONUS 1 MARK: Make a drop down for quantity (used in code behind).--%>