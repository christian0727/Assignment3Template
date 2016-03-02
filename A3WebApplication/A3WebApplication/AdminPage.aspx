<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="A3WebApplication.AdminPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
<asp:Panel ID="pnlMain" runat="server">
     <div class="w3-row-padding">
    <div class="w3-third">
      <img src="http://placehold.it/150x80?text=IMAGE" class="w3-image" style="width:100%" alt="Image">
      <p><asp:Button ID="btnCategories" runat="server" Text="Categories" /> </p>
    </div>
    <div class="w3-third">
      <img src="http://placehold.it/150x80?text=IMAGE" class="w3-image" style="width:100%" alt="Image">
      <p><asp:Button ID="btnProduct" runat="server" Text="Products" OnClick="btnProduct_Click" /></p>
    </div>
     <div class="w3-third">
      <img src="http://placehold.it/150x80?text=IMAGE" class="w3-image" style="width:100%" alt="Image">
      <p><asp:Button ID="btnCustomer" runat="server" Text="Customers" /></p>
    </div>
    </div>
</asp:Panel>

<asp:Panel ID="pnlProduct" Visible="false" runat="server">
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True"></asp:CommandField>
            <asp:BoundField DataField="ProductID" HeaderText="ProductID" ReadOnly="True" InsertVisible="False" SortExpression="ProductID"></asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
            <asp:BoundField DataField="Prize" HeaderText="Prize" SortExpression="Prize"></asp:BoundField>
            <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" SortExpression="CategoryID"></asp:BoundField>
            <asp:BoundField DataField="PrimaryImagePath" HeaderText="PrimaryImagePath" SortExpression="PrimaryImagePath"></asp:BoundField>
            <asp:ImageField DataImageUrlField="PrimaryImagePath" ControlStyle-Width="100px" ControlStyle-Height="100px" DataImageUrlFormatString="Images/{0}"></asp:ImageField>

        </Columns>

    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:dbA3ConnStr %>' SelectCommand="SELECT * FROM [tbProduct]" DeleteCommand="DELETE FROM [tbProduct] WHERE [ProductID] = @ProductID" InsertCommand="INSERT INTO [tbProduct] ([Name], [Prize], [PrimaryImagePath], [CategoryID]) VALUES (@Name, @Prize, @PrimaryImagePath, @CategoryID)" UpdateCommand="UPDATE [tbProduct] SET [Name] = @Name, [Prize] = @Prize, [PrimaryImagePath] = @PrimaryImagePath, [CategoryID] = @CategoryID WHERE [ProductID] = @ProductID">
         <DeleteParameters>
            <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="Prize" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PrimaryImagePath" Type="String"></asp:Parameter>
            <asp:Parameter Name="CategoryID" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String"></asp:Parameter>
            <asp:Parameter Name="Prize" Type="Decimal"></asp:Parameter>
            <asp:Parameter Name="PrimaryImagePath" Type="String"></asp:Parameter>
            <asp:Parameter Name="CategoryID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="ProductID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Panel>


</asp:Content>

<%--   17 MARKS TOTAL
    1 BONUS MARK TOTAL
    TODO:  Impliment CRUD operations for Product as an admin.
    - 2 MARKS: Display all products with all column information
    - 1 MARK: Hide the ProductID column
    - 2 MARKS: Allow edit
    - 2 MARKS: Allow delete (BONUS 1 MARK: provided error message for FOREGIN KEY CONSTRAINT ISSUES)
    - 2 MARKS: Allow insert
    - 2 MARKS: Provide Validation for input when inserting
    - 1 MARK: Ensure Image Upload works for insert
    - 1 MARK: Ensure Image Upload works for update (default to old image value if no new image is provided)
    - 2 MARKS: Manual Sorting by one or more columns (you do not need to do all columns)
    - 2 MARKS: Manual Paging--%>