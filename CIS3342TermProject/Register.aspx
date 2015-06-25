<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CIS3342TermProject.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <!-- Essential meta tags -->
    <meta charset="UTF-8" />
    <meta name="author" content="Viraj Chitnis" />
    <meta name="description" content="VacationOCity registration page" />
    <meta name="copyright" content="Copyright &copy; 2014 Viraj Chitnis. All Rights Reserved." />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />

    <!-- 'Ubuntu' from Google fonts -->
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:300' rel='stylesheet' type='text/css' />

    <!-- Stylesheet -->
    <link rel="stylesheet" href="css/stylesheet.css" />

    <title>Register - VacationOCity</title>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1>VacationOCity <small>Viraj Chitnis & Brent Baskin</small></h1>
        </div>
        <div id="jsAlert" class="alert alert-danger" role="alert">Oh snap! JavaScript needs to be enabled for this page to work as expected.</div>
        <h3>Register for an account</h3>
        <form id="form1" runat="server" role="form">
            <div class="row">
                <div class="col-md-6">
                    <div id="firstNameGroup" class="form-group has-error has-feedback">
                        <label for="txtFirstName">First name *</label>
                        <asp:TextBox ID="txtFirstName" runat="server" type="text" CssClass="form-control" placeholder="Enter first name"></asp:TextBox>
                        <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    </div>
                </div>
                <div class="col-md-6">
                    <div id="lastNameGroup" class="form-group has-error has-feedback">
                        <label for="txtLastName">Last name *</label>
                        <asp:TextBox ID="txtLastName" runat="server" type="text" CssClass="form-control" placeholder="Enter last name"></asp:TextBox>
                        <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    </div>
                </div>
            </div>
            <div id="emailGroup" class="form-group has-error has-feedback">
                <label for="txtEmail">Email *</label>
                <asp:TextBox ID="txtEmail" runat="server" type="text" CssClass="form-control" placeholder="Enter email"></asp:TextBox>
                <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <label>The password must be at least 6 characters long, must have at least one number, one upper case letter and one lower case letter</label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div id="passwordGroup1" class="form-group has-error has-feedback">
                        <label for="txtPassword1">Password *</label>
                        <asp:TextBox ID="txtPassword1" runat="server" type="password" CssClass="form-control" placeholder="Enter password"></asp:TextBox>
                        <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    </div>
                </div>
                <div class="col-md-6">
                    <div id="passwordGroup2" class="form-group has-error has-feedback">
                        <label for="txtPassword2">Repeat password *</label>
                        <asp:TextBox ID="txtPassword2" runat="server" type="password" CssClass="form-control" placeholder="Enter password again"></asp:TextBox>
                        <span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>
                    </div>
                </div>
            </div>
            <div id="emailAlert" class="alert alert-danger" role="alert"></div>
            <div style="float: right;">
                <a href="Login.aspx">Return to login page</a>
                <span>&nbsp;&nbsp;&nbsp;</span>
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary disabled" OnClick="btnRegister_Click" />
            </div>
        </form>
    </div>

    <!-- jQuery -->
    <script src="js/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Logic -->
    <script src="js/register.js"></script>
</body>
</html>
