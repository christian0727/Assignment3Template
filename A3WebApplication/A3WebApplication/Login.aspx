<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="A3WebApplication.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <h3>LOGIN your ACCOUNT</h3><br>
    <div class="w3-row-padding">
    <div class="w3-third">
      <img src="/Images/Beers.jpg" class="w3-image" style="width:100%" alt="Image">
      <p></p>
    </div>
    <div class="w3-third">
      <div class="w3-card-2 w3-padding">
        <p>User Name:</p>
          <asp:TextBox ID="txtUserName" Required runat="server"></asp:TextBox>
      </div><br>
      <div class="w3-card-2 w3-padding">
         <p>Password:</p>
          <asp:TextBox ID="txtPassword" Required TextMode="Password" runat="server"></asp:TextBox>
      </div><br />
    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    <asp:LinkButton ID="lbRegister" runat="server">Sign Up</asp:LinkButton>
    <br />
    <asp:Label ID="lbMessage" runat="server" Visible="false" Text="Invalid User Login!"></asp:Label>
    </div>
        
    <div class="w3-third">
      <img src="/Images/Beers.jpg" class="w3-image" style="width:100%" alt="Image">
      <p></p>
    </div>
  </div>

</asp:Content>
<%--7 MARKS TOTAL
    TODO: 
    - Create a login page with username/password (2 MARKS)
    - redirect to an Admin page if they're an Admin (1 MARK)
    - redirect to CategoriesPage if successful login and not Admin (1 MARK)
    - Provide an error message if incorrect (1 MARK)
    - Ensure proper validation is on the screen (no blank username/password) (2 MARKS)--%>
