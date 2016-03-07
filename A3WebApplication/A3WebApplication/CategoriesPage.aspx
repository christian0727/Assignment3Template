<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="CategoriesPage.aspx.cs" Inherits="A3WebApplication.CategoriesPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <hh3>Category</hh3>
    <asp:DataList ID="dlCategory" runat="server" OnItemCommand="dlCategory_ItemCommand" RepeatColumns="4" DataKeyField="CategoryID" DataSourceID="SqlDataSource1" RepeatDirection="Vertical" RepeatLayout="Table">

        <ItemTemplate>
            CategoryID:
            <asp:Label Text='<%# Eval("CategoryID") %>' runat="server" ID="CategoryIDLabel" /><br />
            <asp:LinkButton ID="LinkButtonName" Text='<%# Eval("Name") %>' CommandArgument='<%# Eval("CategoryID") %>' runat="server"></asp:LinkButton><br />   
            <asp:ImageButton ID="ImageID" ImageUrl='<%# Eval("ImagePath", "~/Images/{0}") %>' CommandArgument='<%# Eval("CategoryID") %>' Width="100px" Height="100px" runat="server" /><br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:dbA3ConnStr %>' SelectCommand="SELECT * FROM [tbCategory]"></asp:SqlDataSource>
</asp:Content>
<%--    TODO: 
    - Show the categories in a DataList (2 MARKS)
    - Make each category a clickable link (2 MARKS) 
        (should redirect to the ProductsPage with a query string of the CategoryID clicked on.
        Example: If you click on Category 2, redirect to ProductsPage.aspx?CategoryID=2)
    - Show each category as an image (1 MARK)--%>