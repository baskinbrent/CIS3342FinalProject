<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CIS3342TermProject.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Essential meta tags -->
    <meta charset="UTF-8" />
    <meta name="author" content="Viraj Chitnis" />
    <meta name="description" content="VacationOCity login page" />
    <meta name="copyright" content="Copyright &copy; 2014 Viraj Chitnis. All Rights Reserved." />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />

    <!-- 'Ubuntu' from Google fonts -->
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:300' rel='stylesheet' type='text/css' />

    <!-- Stylesheet -->
    <link rel="stylesheet" href="css/stylesheet.css" />

    <title>Login - VacationOCity</title>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <h1>VacationOCity <small>Viraj Chitnis & Brent Baskin</small></h1>
        </div>
        <div id="jsAlert" class="alert alert-danger" role="alert">Oh snap! JavaScript needs to be enabled for this page to work as expected.</div>
        <div id="loginAlert" class="alert alert-danger" role="alert" runat="server"></div>
        <div class="row">
            <div class="col-md-8">
                <h3>Welcome to VacationOCity</h3>
                <p>If you are a new customer, please register, if you are a returning customer, please login.</p>
                <a href="Register.aspx" class="btn btn-default">Register</a>
            </div>
            <div class="col-md-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Login</h3>
                    </div>
                    <div class="panel-body">
                        <form id="form1" runat="server" role="form">
                            <div class="form-group">
                                <label for="txtUserName">Email</label>
                                <asp:TextBox ID="txtUserName" runat="server" type="email" CssClass="form-control" placeholder="Enter email"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtPassword">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" type="password" CssClass="form-control" placeholder="Password"></asp:TextBox>
                            </div>
                            <div style="text-align: center">
                                <div class="checkbox">
                                    <label>
                                        <asp:CheckBox ID="chkRememberMe" runat="server" />
                                        Remember me
                                    </label>
                                </div>
                            </div>
                            <div style="float: right;">
                                <a href="#" target="_blank">Forgot password</a>
                                <span>&nbsp;&nbsp;&nbsp;</span>
                                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary disabled" OnClick="btnLogin_Click" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="js/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Logic -->
    <script src="js/login.js"></script>
</body>
</html>
