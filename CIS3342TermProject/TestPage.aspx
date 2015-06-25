<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPage.aspx.cs" Inherits="CIS3342TermProject.TestPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="btnTestGetCars" runat="server" Text="Test GetCars method" OnClick="btnTestGetCars_Click" />
        <asp:Button ID="btnTestGetRentalCarAgencies" runat="server" OnClick="btnTestGetRentalCarAgencies_Click" Text="Test GetRentalCarAgencies method" />
        <asp:Button ID="btnTestFindCars" runat="server" OnClick="btnTestFindCars_Click" Text="Test FindCars method" />
        <asp:GridView ID="gvDisplayResults" runat="server">
        </asp:GridView>
    
        <asp:Button ID="btnTestValidateLogin" runat="server" OnClick="btnTestValidateLogin_Click" Text="Test ValidateLogin method" />
        <asp:Button ID="btnTestCheckEmail" runat="server" OnClick="btnTestCheckEmail_Click" Text="Test CheckEmail method" />
        <asp:Button ID="btnTestAddUser" runat="server" OnClick="btnTestAddUser_Click" Text="Test AddUser method" />
    
        <asp:Button ID="btnTestReserve" runat="server" OnClick="btnTestReserve_Click" Text="Test Reserve method" />
        <asp:Label ID="lblReserveResult" runat="server"></asp:Label>
    
    </div>
    </form>
</body>
</html>
