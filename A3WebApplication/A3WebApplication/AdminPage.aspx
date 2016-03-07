<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="A3WebApplication.AdminPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <asp:Panel ID="pnlMain" runat="server">
        <div class="w3-row-padding">
            <div class="w3-third">
                <img src="http://placehold.it/150x80?text=IMAGE" class="w3-image" style="width: 100%" alt="Image">
                <p>
                    <asp:Button ID="btnCategories" runat="server" Text="Categories" OnClick="btnCategories_Click" />
                </p>
            </div>
            <div class="w3-third">
                <img src="http://placehold.it/150x80?text=IMAGE" class="w3-image" style="width: 100%" alt="Image">
                <p>
                    <asp:Button ID="btnProduct" runat="server" Text="Products" OnClick="btnProduct_Click" />
                </p>
            </div>
            <div class="w3-third">
                <img src="http://placehold.it/150x80?text=IMAGE" class="w3-image" style="width: 100%" alt="Image">
                <p>
                    <asp:Button ID="btnCustomer" runat="server" Text="Customers" OnClick="btnCustomer_Click" />
                </p>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlProduct" Visible="false" runat="server">
        <asp:Button ID="btnBack" runat="server" Text="Main Menu" OnClick="btnBack_Click" />
        <asp:GridView ID="gvProducts" ShowFooter="true" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductID" AllowSorting="True" AllowPaging="True" PagerSettings-PageButtonCount="5" 
            PageSize="3" OnDataBound="gvProducts_OnDataBound" OnSorting="gvProducts_OnSorting" OnPageIndexChanging="gvProducts_OnPageIndexChanging" OnRowEditing="gvProducts_OnRowEditing"
            OnRowDeleting="gvProducts_OnRowDeleting" OnRowCancelingEdit="gvProducts_OnRowCancelingEdit" OnRowUpdating="gvProducts_OnRowUpdating" OnRowCommand="gvProducts_OnRowCommand"
            OnRowDataBound="gvProducts_OnRowDataBound">

            <Columns>

                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:LinkButton runat="server" ID="lbUpdate" CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp; 
                            <asp:LinkButton runat="server" ID="lbCancel" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="lbEdit" CommandName="Edit" Text="Edit"></asp:LinkButton>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:LinkButton runat="server" ID="lbAdd" CommandName="Add" Text="Add"></asp:LinkButton>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField >
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="lbDelete" CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="ProductID" HeaderText="Product ID" Visible="false" SortExpression="ProductID" ReadOnly="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />

                <asp:TemplateField HeaderText="Category" SortExpression="CategoryID" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                    FooterStyle-HorizontalAlign="Center">
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="ddlCategories" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:DropDownList runat="server" ID="ddlInsertCategory" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblCategory" Text='<%# Bind("CategoryID") %>'><></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Name" SortExpression="Name" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                    FooterStyle-HorizontalAlign="Center">
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="tbName" Text='<%# Bind("Name") %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox runat="server" ID="tbInsertName" placeholder="Enter Product Name"></asp:TextBox>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblName" Text='<%# Bind("Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Price" SortExpression="Price" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                    FooterStyle-HorizontalAlign="Center">
                    <EditItemTemplate>
                        <asp:TextBox runat="server" ID="tbPrice" Text='<%# Bind("Price") %>' />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox runat="server" ID="tbInsertPrice" placeholder="Product Price"></asp:TextBox>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label runat="server" ID="lblPrice" Text='<%# Bind("Price") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Image" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                    FooterStyle-HorizontalAlign="Center">
                    <EditItemTemplate>
                        <asp:FileUpload runat="server" ID="uploadImage" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:FileUpload runat="server" ID="uploadNewImage" />
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Image runat="server" ID="image" ImageUrl='<%# "/Images/" + Eval("PrimaryImagePath") %>' Height="100" Width="100" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

    </asp:Panel>
    
    <asp:Panel ID="pnlCategory" Visible="false" runat="server">
         <asp:Button ID="btnBack1" runat="server" Text="Main Menu" OnClick="btnBack_Click" />
        <asp:GridView ID="gvCategory" runat="server" PageSize="3" AutoGenerateColumns="False" DataKeyNames="CategoryID" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True">
            <Columns>
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                <asp:BoundField DataField="CategoryID" HeaderText="CategoryID" ReadOnly="True" InsertVisible="False" SortExpression="CategoryID"></asp:BoundField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:ImageField HeaderText="Image" DataImageUrlField="ImagePath" ControlStyle-Width="100px" ControlStyle-Height="100px" DataImageUrlFormatString="Images/{0}"></asp:ImageField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:dbA3ConnStr %>' SelectCommand="SELECT * FROM [tbCategory]" DeleteCommand="DELETE FROM [tbCategory] WHERE [CategoryID] = @CategoryID" InsertCommand="INSERT INTO [tbCategory] ([Name], [ImagePath]) VALUES (@Name, @ImagePath)" UpdateCommand="UPDATE [tbCategory] SET [Name] = @Name, [ImagePath] = @ImagePath WHERE [CategoryID] = @CategoryID">
            <DeleteParameters>
                <asp:Parameter Name="CategoryID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                <asp:Parameter Name="ImagePath" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String"></asp:Parameter>
                <asp:Parameter Name="ImagePath" Type="String"></asp:Parameter>
                <asp:Parameter Name="CategoryID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:LinkButton ID="lbAdd" runat="server" OnClick="lbAdd_Click">Add New Category</asp:LinkButton>
        <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
        <asp:FileUpload ID="fuImagePath" runat="server" />

    </asp:Panel>

    <asp:Panel ID="pnlCustomer" Visible="false" runat="server">
        <asp:Button ID="btnBack2" runat="server" Text="Main Menu" OnClick="btnBack_Click" />
        <asp:GridView ID="gvCustomer" runat="server" AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True">
            <Columns>
                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"></asp:CommandField>
                <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" ReadOnly="True" InsertVisible="False" SortExpression="CustomerID"></asp:BoundField>
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName"></asp:BoundField>
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName"></asp:BoundField>
                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"></asp:BoundField>
                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
                <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber"></asp:BoundField>
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName"></asp:BoundField>
                <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password"></asp:BoundField>
                <asp:CheckBoxField DataField="AccessLevel" HeaderText="AccessLevel" SortExpression="AccessLevel"></asp:CheckBoxField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:dbA3ConnStr %>' DeleteCommand="DELETE FROM [tbCustomer] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [tbCustomer] ([FirstName], [LastName], [Address], [City], [PhoneNumber], [UserName], [Password], [AccessLevel]) VALUES (@FirstName, @LastName, @Address, @City, @PhoneNumber, @UserName, @Password, @AccessLevel)" SelectCommand="SELECT * FROM [tbCustomer]" UpdateCommand="UPDATE [tbCustomer] SET [FirstName] = @FirstName, [LastName] = @LastName, [Address] = @Address, [City] = @City, [PhoneNumber] = @PhoneNumber, [UserName] = @UserName, [Password] = @Password, [AccessLevel] = @AccessLevel WHERE [CustomerID] = @CustomerID">
            <DeleteParameters>
                <asp:Parameter Name="CustomerID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
                <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Address" Type="String"></asp:Parameter>
                <asp:Parameter Name="City" Type="String"></asp:Parameter>
                <asp:Parameter Name="PhoneNumber" Type="String"></asp:Parameter>
                <asp:Parameter Name="UserName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Password" Type="String"></asp:Parameter>
                <asp:Parameter Name="AccessLevel" Type="Boolean"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="FirstName" Type="String"></asp:Parameter>
                <asp:Parameter Name="LastName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Address" Type="String"></asp:Parameter>
                <asp:Parameter Name="City" Type="String"></asp:Parameter>
                <asp:Parameter Name="PhoneNumber" Type="String"></asp:Parameter>
                <asp:Parameter Name="UserName" Type="String"></asp:Parameter>
                <asp:Parameter Name="Password" Type="String"></asp:Parameter>
                <asp:Parameter Name="AccessLevel" Type="Boolean"></asp:Parameter>
                <asp:Parameter Name="CustomerID" Type="Int32"></asp:Parameter>
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