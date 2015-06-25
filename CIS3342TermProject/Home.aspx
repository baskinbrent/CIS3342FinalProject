<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CIS3342TermProject.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <!-- Essential meta tags -->
    <meta charset="UTF-8" />
    <meta name="author" content="Viraj Chitnis" />
    <meta name="description" content="VacationOCity home page" />
    <meta name="copyright" content="Copyright &copy; 2014 Viraj Chitnis. All Rights Reserved." />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/bootstrap-theme.min.css" />

    <!-- 'Ubuntu' from Google fonts -->
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:300' rel='stylesheet' type='text/css' />

    <!-- Stylesheet -->
    <link rel="stylesheet" href="css/stylesheet.css" />

    <title>Home - VacationOCity</title>
</head>
<body>
    <form id="form1" runat="server" role="form">
        <div id="divTechSupportChat" class="panel panel-default" style="position: fixed; bottom: 0px; right: 20px; width: 400px; z-index: 15; display: none;">
            <div class="panel-heading">
                <button id="btnCloseSupportChat" type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h3 class="panel-title">Tech support chat</h3>
            </div>
            <div class="panel-body">
                <div id="chatBody" class="well" style="max-height: 300px; overflow: auto;">Type below and press the 'Go' button</div>
                <asp:HiddenField ID="chatUserName" runat="server" />
                <p><small>There could be a delay of up to 5 seconds before messages are displayed in the chat window</small></p>
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" class="form-control" id="chatInput" placeholder="Chat" onkeydown="if (window.event.keyCode == 13) { event.returnValue=false; event.cancel = true; searchLocations(); }" />
                        <div id="chatEnterButton" class="input-group-addon">Go</div>
                    </div>
                </div>
            </div>
        </div>
        <button id="chatButton" type="button" class="btn btn-default" style="position: fixed; bottom: 20px; right: 20px; z-index: 15;"><span class="glyphicon glyphicon-comment" aria-hidden="true"></span>&nbsp;Chat</button>
        <div class="container">
            <br />
            <nav class="navbar navbar-default" role="navigation">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">VacationOCity</a>
                    </div>

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                            <li>
                                <asp:LinkButton ID="btnHome" runat="server" OnClick="btnHome_Click"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>&nbsp;Home&nbsp;</asp:LinkButton>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li>
                                <asp:LinkButton ID="btnCart" runat="server" OnClick="btnCart_Click"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>&nbsp;Cart&nbsp;<span id="cartCountDisplay" class="badge" runat="server">0</span></asp:LinkButton></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>&nbsp;<span id="lblUserName" runat="server"></span>&nbsp;<span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click"><span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>&nbsp;Logout</asp:LinkButton>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div id="divCartBody" runat="server" style="text-align: center">
                
                <div id="divCart" runat="server"></div>
                <asp:LinkButton ID="btnCheckout" CssClass="btn btn-default" runat="server" OnClick="btnCheckout_Click"><span class="glyphicon glyphicon-ok" aria-hidden="true"></span>&nbsp;Checkout</asp:LinkButton>
                <asp:LinkButton ID="btnClearCart" CssClass="btn btn-default" runat="server" OnClick="btnClearCart_Click"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;Clear cart</asp:LinkButton>
                <asp:LinkButton ID="btnUpdateCart" CssClass="btn btn-default" runat="server" OnClick="btnUpdateCart_Click"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp;Update cart</asp:LinkButton>
                <br />
                <asp:Label ID="lblTotalPrice" runat="server" text="Total Price: $"/>
                <br />
                <br />
            </div>
            <div id="divReservationsBody" runat="server">
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Rent a car</h3>
                            </div>
                            <div class="panel-body">
                                <div id="divCarForm" runat="server">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="txtCarCity">City</label>
                                                <asp:TextBox ID="txtCarCity" runat="server" class="form-control" placeholder="Enter city"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="ddlCarState">State</label>
                                                <asp:DropDownList ID="ddlCarState" CssClass="form-control" runat="server">
                                                    <asp:ListItem>Select state</asp:ListItem>
                                                    <asp:ListItem>AL</asp:ListItem>
                                                    <asp:ListItem>AK</asp:ListItem>
                                                    <asp:ListItem>AZ</asp:ListItem>
                                                    <asp:ListItem>AR</asp:ListItem>
                                                    <asp:ListItem>CA</asp:ListItem>
                                                    <asp:ListItem>CO</asp:ListItem>
                                                    <asp:ListItem>CT</asp:ListItem>
                                                    <asp:ListItem>DE</asp:ListItem>
                                                    <asp:ListItem>FL</asp:ListItem>
                                                    <asp:ListItem>GA</asp:ListItem>
                                                    <asp:ListItem>HI</asp:ListItem>
                                                    <asp:ListItem>ID</asp:ListItem>
                                                    <asp:ListItem>IL</asp:ListItem>
                                                    <asp:ListItem>IN</asp:ListItem>
                                                    <asp:ListItem>IA</asp:ListItem>
                                                    <asp:ListItem>KS</asp:ListItem>
                                                    <asp:ListItem>KY</asp:ListItem>
                                                    <asp:ListItem>LA</asp:ListItem>
                                                    <asp:ListItem>ME</asp:ListItem>
                                                    <asp:ListItem>MD</asp:ListItem>
                                                    <asp:ListItem>MA</asp:ListItem>
                                                    <asp:ListItem>MI</asp:ListItem>
                                                    <asp:ListItem>MN</asp:ListItem>
                                                    <asp:ListItem>MS</asp:ListItem>
                                                    <asp:ListItem>MO</asp:ListItem>
                                                    <asp:ListItem>MT</asp:ListItem>
                                                    <asp:ListItem>NE</asp:ListItem>
                                                    <asp:ListItem>NV</asp:ListItem>
                                                    <asp:ListItem>NH</asp:ListItem>
                                                    <asp:ListItem>NJ</asp:ListItem>
                                                    <asp:ListItem>NM</asp:ListItem>
                                                    <asp:ListItem>NY</asp:ListItem>
                                                    <asp:ListItem>NC</asp:ListItem>
                                                    <asp:ListItem>ND</asp:ListItem>
                                                    <asp:ListItem>OH</asp:ListItem>
                                                    <asp:ListItem>OK</asp:ListItem>
                                                    <asp:ListItem>OR</asp:ListItem>
                                                    <asp:ListItem>PA</asp:ListItem>
                                                    <asp:ListItem>RI</asp:ListItem>
                                                    <asp:ListItem>SC</asp:ListItem>
                                                    <asp:ListItem>SD</asp:ListItem>
                                                    <asp:ListItem>TN</asp:ListItem>
                                                    <asp:ListItem>TX</asp:ListItem>
                                                    <asp:ListItem>UT</asp:ListItem>
                                                    <asp:ListItem>VT</asp:ListItem>
                                                    <asp:ListItem>VA</asp:ListItem>
                                                    <asp:ListItem>WA</asp:ListItem>
                                                    <asp:ListItem>WV</asp:ListItem>
                                                    <asp:ListItem>WI</asp:ListItem>
                                                    <asp:ListItem>WY</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="btn">
                                            <label>
                                                <asp:Button ID="btnCarSelectCity" CssClass="btn btn-default" runat="server" Text="Next" OnClick="btnCarSelectCity_Click" />
                                            </label>
                                        </div>
                                    </div>
                                    <div id="divCarDetails" runat="server">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4>Search by agencies</h4>
                                                <div class="form-group">
                                                    <label for="ddlAgencies">Agencies</label>
                                                    <asp:DropDownList ID="ddlAgencies" CssClass="form-control" runat="server">
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnSearchCarAgencies" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnSearchCarAgencies_Click" />
                                            </div>
                                            <div class="col-md-6">
                                                <h4>Search by requirements</h4>
                                                <div class="form-group">
                                                    <label for="ddlCarType">Car type</label>
                                                    <asp:DropDownList ID="ddlCarType" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="">Select car type</asp:ListItem>
                                                        <asp:ListItem>Minivan</asp:ListItem>
                                                        <asp:ListItem>Super sports</asp:ListItem>
                                                        <asp:ListItem>Sports</asp:ListItem>
                                                        <asp:ListItem>Sedan</asp:ListItem>
                                                        <asp:ListItem>SUV</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlCarClass">Car class</label>
                                                    <asp:DropDownList ID="ddlCarClass" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="">Select car class</asp:ListItem>
                                                        <asp:ListItem>Sports</asp:ListItem>
                                                        <asp:ListItem>Standard</asp:ListItem>
                                                        <asp:ListItem>Minivan</asp:ListItem>
                                                        <asp:ListItem>Sport luxury</asp:ListItem>
                                                        <asp:ListItem>Sport</asp:ListItem>
                                                        <asp:ListItem>Standard</asp:ListItem>
                                                        <asp:ListItem>Luxury SUV</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlDoors">Doors</label>
                                                    <asp:DropDownList ID="ddlDoors" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="0">Select doors</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlPassengers">Passengers</label>
                                                    <asp:DropDownList ID="ddlPassengers" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="0">Select passengers</asp:ListItem>
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlLuggage">Luggage</label>
                                                    <asp:DropDownList ID="ddlLuggage" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="0">Select luggage</asp:ListItem>
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txtMaxCarPrice">Budget</label>
                                                    <asp:TextBox ID="txtMaxCarPrice" runat="server" class="form-control" placeholder="Enter your budget" TextMode="Number"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txtMaxCarMileage">Mileage</label>
                                                    <asp:TextBox ID="txtMaxCarMileage" runat="server" class="form-control" placeholder="Enter your max mileage" TextMode="Number"></asp:TextBox>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlCarGps">GPS</label>
                                                    <asp:DropDownList ID="ddlCarGps" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="">Select gps</asp:ListItem>
                                                        <asp:ListItem Value="yes">Yes</asp:ListItem>
                                                        <asp:ListItem Value="no">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlCarElectric">Electric</label>
                                                    <asp:DropDownList ID="ddlCarElectric" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="">Select electric</asp:ListItem>
                                                        <asp:ListItem Value="yes">Yes</asp:ListItem>
                                                        <asp:ListItem Value="no">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnSearchCarReqs" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnSearchCarReqs_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divCarResults" runat="server" style="text-align: center;">
                                    <div class="page-header">
                                        <h3>Cars available</h3>
                                    </div>
                                    <div style="width: 100%; text-align: center;">
                                        <div class="row">
                                            <asp:Repeater ID="rptCars" runat="server" OnItemCommand="rptCars_ItemCommand">
                                                <ItemTemplate>
                                                    <div class="col-md-3">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <h4>
                                                                    <asp:Label ID="lblCarYear" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "year") %>'></asp:Label>
                                                                    <asp:Label ID="lblCarMake" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "make") %>'></asp:Label>
                                                                    <asp:Label ID="lblCarModel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "model") %>'></asp:Label><br />
                                                                    <small>
                                                                        <asp:Label ID="lblCarCity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "city") %>'></asp:Label>,
                                                                    <asp:Label ID="lblCarState" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "state") %>'></asp:Label></small></h4>
                                                                <p>
                                                                    Seats:
                                                                <asp:Label ID="lblCarPassengers" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "passengers") %>'></asp:Label><br />
                                                                    GPS available:
                                                                <asp:Label ID="lblCarGps" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "gps") %>'></asp:Label><br />
                                                                    Bags:
                                                                <asp:Label ID="lblCarLuggage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "luggage") %>'></asp:Label><br />
                                                                    Price: $ 
                                                                <asp:Label ID="lblCarPrice" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "price") %>'></asp:Label><br />
                                                                    Mileage:
                                                                <asp:Label ID="lblCarMileage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "mileage") %>'></asp:Label>
                                                                </p>
                                                                <asp:LinkButton ID="btnCarAddToCart" CssClass="btn btn-default" runat="server" Text="<span class='glyphicon glyphicon-shopping-cart'></span> Add to cart"></asp:LinkButton>
                                                                <asp:Label ID="lblCarHdnID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "carID") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblCarHdnType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "type") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblCarHdnClass" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "class") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblCarHdnElectric" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "electric") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblCarHdnDoors" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "doors") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblCarHdnAgency" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "agencyID") %>' Visible="false"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                    <asp:Button ID="btnClearCarSearch" CssClass="btn btn-default" runat="server" Text="Back" OnClick="btnClearCarSearch_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Events</h3>
                            </div>
                            <div class="panel-body">
                                <div id="divEventForm" runat="server">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="txtEventCity">City</label>
                                                <asp:TextBox ID="txtEventCity" runat="server" class="form-control" placeholder="Enter city"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <label for="ddlEventState">State</label>
                                                <asp:DropDownList ID="ddlEventState" CssClass="form-control" runat="server">
                                                    <asp:ListItem>Select state</asp:ListItem>
                                                    <asp:ListItem>AL</asp:ListItem>
                                                    <asp:ListItem>AK</asp:ListItem>
                                                    <asp:ListItem>AZ</asp:ListItem>
                                                    <asp:ListItem>AR</asp:ListItem>
                                                    <asp:ListItem>CA</asp:ListItem>
                                                    <asp:ListItem>CO</asp:ListItem>
                                                    <asp:ListItem>CT</asp:ListItem>
                                                    <asp:ListItem>DE</asp:ListItem>
                                                    <asp:ListItem>FL</asp:ListItem>
                                                    <asp:ListItem>GA</asp:ListItem>
                                                    <asp:ListItem>HI</asp:ListItem>
                                                    <asp:ListItem>ID</asp:ListItem>
                                                    <asp:ListItem>IL</asp:ListItem>
                                                    <asp:ListItem>IN</asp:ListItem>
                                                    <asp:ListItem>IA</asp:ListItem>
                                                    <asp:ListItem>KS</asp:ListItem>
                                                    <asp:ListItem>KY</asp:ListItem>
                                                    <asp:ListItem>LA</asp:ListItem>
                                                    <asp:ListItem>ME</asp:ListItem>
                                                    <asp:ListItem>MD</asp:ListItem>
                                                    <asp:ListItem>MA</asp:ListItem>
                                                    <asp:ListItem>MI</asp:ListItem>
                                                    <asp:ListItem>MN</asp:ListItem>
                                                    <asp:ListItem>MS</asp:ListItem>
                                                    <asp:ListItem>MO</asp:ListItem>
                                                    <asp:ListItem>MT</asp:ListItem>
                                                    <asp:ListItem>NE</asp:ListItem>
                                                    <asp:ListItem>NV</asp:ListItem>
                                                    <asp:ListItem>NH</asp:ListItem>
                                                    <asp:ListItem>NJ</asp:ListItem>
                                                    <asp:ListItem>NM</asp:ListItem>
                                                    <asp:ListItem>NY</asp:ListItem>
                                                    <asp:ListItem>NC</asp:ListItem>
                                                    <asp:ListItem>ND</asp:ListItem>
                                                    <asp:ListItem>OH</asp:ListItem>
                                                    <asp:ListItem>OK</asp:ListItem>
                                                    <asp:ListItem>OR</asp:ListItem>
                                                    <asp:ListItem>PA</asp:ListItem>
                                                    <asp:ListItem>RI</asp:ListItem>
                                                    <asp:ListItem>SC</asp:ListItem>
                                                    <asp:ListItem>SD</asp:ListItem>
                                                    <asp:ListItem>TN</asp:ListItem>
                                                    <asp:ListItem>TX</asp:ListItem>
                                                    <asp:ListItem>UT</asp:ListItem>
                                                    <asp:ListItem>VT</asp:ListItem>
                                                    <asp:ListItem>VA</asp:ListItem>
                                                    <asp:ListItem>WA</asp:ListItem>
                                                    <asp:ListItem>WV</asp:ListItem>
                                                    <asp:ListItem>WI</asp:ListItem>
                                                    <asp:ListItem>WY</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="btn">
                                            <label>
                                                <asp:Button ID="btnEventSelectCity" CssClass="btn btn-default" runat="server" Text="Next" OnClick="btnEventSelectCity_Click" />
                                            </label>
                                        </div>
                                    </div>
                                    <div id="divEventDetails" runat="server">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4>Search by agencies</h4>
                                                <div class="form-group">
                                                    <label for="ddlEventAgencies">Agencies</label>
                                                    <asp:DropDownList ID="ddlEventAgencies" CssClass="form-control" runat="server">
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnEventSearchByAgency" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnEventSearchByAgency_Click" />
                                            </div>
                                            <div class="col-md-6">
                                                <h4>Search by activities</h4>
                                                <div class="form-group">
                                                    <label for="ddlEventTime">Event type</label>
                                                    <asp:DropDownList ID="ddlEventTime" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="1">Select Time</asp:ListItem>
                                                        <asp:ListItem>12:00 pm</asp:ListItem>
                                                        <asp:ListItem>1:00 pm</asp:ListItem>
                                                        <asp:ListItem>2:00 pm</asp:ListItem>
                                                        <asp:ListItem>3:00 pm</asp:ListItem>
                                                        <asp:ListItem>4:00 pm</asp:ListItem>
                                                        <asp:ListItem>5:00 pm</asp:ListItem>
                                                        <asp:ListItem>6:00 pm</asp:ListItem>
                                                        <asp:ListItem>7:00 pm</asp:ListItem>
                                                        <asp:ListItem>8:00 pm</asp:ListItem>
                                                        <asp:ListItem>9:00 pm</asp:ListItem>
                                                        <asp:ListItem>10:00 pm</asp:ListItem>
                                                        <asp:ListItem>11:00 pm</asp:ListItem>
                                                        <asp:ListItem>12:00 am</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlEventDay">Event type</label>
                                                    <asp:DropDownList ID="ddlEventDay" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="1">Select Day Of Week</asp:ListItem>
                                                        <asp:ListItem>Sunday</asp:ListItem>
                                                        <asp:ListItem>Monday</asp:ListItem>
                                                        <asp:ListItem>Tuesday</asp:ListItem>
                                                        <asp:ListItem>Wednesday</asp:ListItem>
                                                        <asp:ListItem>Thursday</asp:ListItem>
                                                        <asp:ListItem>Friday</asp:ListItem>
                                                        <asp:ListItem>Saturday</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlEventType">Event type</label>
                                                    <asp:DropDownList ID="ddlEventType" CssClass="form-control" runat="server">
                                                        <asp:ListItem Value="1">Select Type of Event</asp:ListItem>
                                                        <asp:ListItem>Party</asp:ListItem>
                                                        <asp:ListItem>Show</asp:ListItem>
                                                        <asp:ListItem>Tour</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnEventSearchByActivity" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnEventSearchByActivity_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divEventResults" runat="server" style="text-align: center;">
                                    <div class="page-header">
                                        <h3>Events available</h3>
                                    </div>
                                    <div style="width: 100%; text-align: center;">
                                        <div class="row">
                                            <asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand">
                                                <ItemTemplate>
                                                    <div class="col-md-3">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <h4>
                                                                    <asp:Label ID="lblEventName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventName") %>'></asp:Label>
                                                                    <small>
                                                                        <asp:Label ID="lblEventCity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventCity") %>'></asp:Label>,
                                                                    <asp:Label ID="lblEventState" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventState") %>'></asp:Label>
                                                                    </small></h4>
                                                                <p>
                                                                    <asp:Label ID="lblEventTime" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventTime") %>'></asp:Label>,
                                                                    <asp:Label ID="lblEventDay" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventDay") %>'></asp:Label><br />
                                                                    Type: 
                                                                <asp:Label ID="lblEventType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventType") %>'></asp:Label><br />
                                                                    Price: $ 
                                                                <asp:Label ID="lblEventPrice" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventPrice") %>'></asp:Label>
                                                                </p>
                                                                <asp:LinkButton ID="btnCarAddToCart" CssClass="btn btn-default" runat="server" Text="<span class='glyphicon glyphicon-shopping-cart'></span> Add to cart"></asp:LinkButton>
                                                                <asp:Label ID="lblEventHdnID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "eventID") %>' Visible="false"></asp:Label>
                                                                <asp:Label ID="lblEventHdnAgency" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "agencyID") %>' Visible="false"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                    <asp:Button ID="btnEventsClear" CssClass="btn btn-default" runat="server" Text="Back" OnClick="btnEventsClear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Reserve a Flight</h3>
                            </div>
                            <div id="divFlightView" runat="server" class="panel-body">
                                <div class="form-group">
                                    <label for="txtFlightDepCity">Departure City</label>
                                    <asp:TextBox ID="txtFlightDepCity" runat="server" class="form-control" placeholder="Enter city"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="ddlFlightDepState">Departure State</label>
                                    <asp:DropDownList ID="ddlFlightDepState" CssClass="form-control" runat="server">
                                        <asp:ListItem>Select departure state</asp:ListItem>
                                        <asp:ListItem>AL</asp:ListItem>
                                        <asp:ListItem>AK</asp:ListItem>
                                        <asp:ListItem>AZ</asp:ListItem>
                                        <asp:ListItem>AR</asp:ListItem>
                                        <asp:ListItem>CA</asp:ListItem>
                                        <asp:ListItem>CO</asp:ListItem>
                                        <asp:ListItem>CT</asp:ListItem>
                                        <asp:ListItem>DE</asp:ListItem>
                                        <asp:ListItem>FL</asp:ListItem>
                                        <asp:ListItem>GA</asp:ListItem>
                                        <asp:ListItem>HI</asp:ListItem>
                                        <asp:ListItem>ID</asp:ListItem>
                                        <asp:ListItem>IL</asp:ListItem>
                                        <asp:ListItem>IN</asp:ListItem>
                                        <asp:ListItem>IA</asp:ListItem>
                                        <asp:ListItem>KS</asp:ListItem>
                                        <asp:ListItem>KY</asp:ListItem>
                                        <asp:ListItem>LA</asp:ListItem>
                                        <asp:ListItem>ME</asp:ListItem>
                                        <asp:ListItem>MD</asp:ListItem>
                                        <asp:ListItem>MA</asp:ListItem>
                                        <asp:ListItem>MI</asp:ListItem>
                                        <asp:ListItem>MN</asp:ListItem>
                                        <asp:ListItem>MS</asp:ListItem>
                                        <asp:ListItem>MO</asp:ListItem>
                                        <asp:ListItem>MT</asp:ListItem>
                                        <asp:ListItem>NE</asp:ListItem>
                                        <asp:ListItem>NV</asp:ListItem>
                                        <asp:ListItem>NH</asp:ListItem>
                                        <asp:ListItem>NJ</asp:ListItem>
                                        <asp:ListItem>NM</asp:ListItem>
                                        <asp:ListItem>NY</asp:ListItem>
                                        <asp:ListItem>NC</asp:ListItem>
                                        <asp:ListItem>ND</asp:ListItem>
                                        <asp:ListItem>OH</asp:ListItem>
                                        <asp:ListItem>OK</asp:ListItem>
                                        <asp:ListItem>OR</asp:ListItem>
                                        <asp:ListItem>PA</asp:ListItem>
                                        <asp:ListItem>RI</asp:ListItem>
                                        <asp:ListItem>SC</asp:ListItem>
                                        <asp:ListItem>SD</asp:ListItem>
                                        <asp:ListItem>TN</asp:ListItem>
                                        <asp:ListItem>TX</asp:ListItem>
                                        <asp:ListItem>UT</asp:ListItem>
                                        <asp:ListItem>VT</asp:ListItem>
                                        <asp:ListItem>VA</asp:ListItem>
                                        <asp:ListItem>WA</asp:ListItem>
                                        <asp:ListItem>WV</asp:ListItem>
                                        <asp:ListItem>WI</asp:ListItem>
                                        <asp:ListItem>WY</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group">
                                    <label for="txtFlightDestCity">Destination City</label>
                                    <asp:TextBox ID="txtFlightDestCity" runat="server" class="form-control" placeholder="Enter city"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="ddlFlightDestState">Destination State</label>
                                    <asp:DropDownList ID="ddlFlightDestState" CssClass="form-control" runat="server">
                                        <asp:ListItem>Select departure state</asp:ListItem>
                                        <asp:ListItem>AL</asp:ListItem>
                                        <asp:ListItem>AK</asp:ListItem>
                                        <asp:ListItem>AZ</asp:ListItem>
                                        <asp:ListItem>AR</asp:ListItem>
                                        <asp:ListItem>CA</asp:ListItem>
                                        <asp:ListItem>CO</asp:ListItem>
                                        <asp:ListItem>CT</asp:ListItem>
                                        <asp:ListItem>DE</asp:ListItem>
                                        <asp:ListItem>FL</asp:ListItem>
                                        <asp:ListItem>GA</asp:ListItem>
                                        <asp:ListItem>HI</asp:ListItem>
                                        <asp:ListItem>ID</asp:ListItem>
                                        <asp:ListItem>IL</asp:ListItem>
                                        <asp:ListItem>IN</asp:ListItem>
                                        <asp:ListItem>IA</asp:ListItem>
                                        <asp:ListItem>KS</asp:ListItem>
                                        <asp:ListItem>KY</asp:ListItem>
                                        <asp:ListItem>LA</asp:ListItem>
                                        <asp:ListItem>ME</asp:ListItem>
                                        <asp:ListItem>MD</asp:ListItem>
                                        <asp:ListItem>MA</asp:ListItem>
                                        <asp:ListItem>MI</asp:ListItem>
                                        <asp:ListItem>MN</asp:ListItem>
                                        <asp:ListItem>MS</asp:ListItem>
                                        <asp:ListItem>MO</asp:ListItem>
                                        <asp:ListItem>MT</asp:ListItem>
                                        <asp:ListItem>NE</asp:ListItem>
                                        <asp:ListItem>NV</asp:ListItem>
                                        <asp:ListItem>NH</asp:ListItem>
                                        <asp:ListItem>NJ</asp:ListItem>
                                        <asp:ListItem>NM</asp:ListItem>
                                        <asp:ListItem>NY</asp:ListItem>
                                        <asp:ListItem>NC</asp:ListItem>
                                        <asp:ListItem>ND</asp:ListItem>
                                        <asp:ListItem>OH</asp:ListItem>
                                        <asp:ListItem>OK</asp:ListItem>
                                        <asp:ListItem>OR</asp:ListItem>
                                        <asp:ListItem>PA</asp:ListItem>
                                        <asp:ListItem>RI</asp:ListItem>
                                        <asp:ListItem>SC</asp:ListItem>
                                        <asp:ListItem>SD</asp:ListItem>
                                        <asp:ListItem>TN</asp:ListItem>
                                        <asp:ListItem>TX</asp:ListItem>
                                        <asp:ListItem>UT</asp:ListItem>
                                        <asp:ListItem>VT</asp:ListItem>
                                        <asp:ListItem>VA</asp:ListItem>
                                        <asp:ListItem>WA</asp:ListItem>
                                        <asp:ListItem>WV</asp:ListItem>
                                        <asp:ListItem>WI</asp:ListItem>
                                        <asp:ListItem>WY</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:Button ID="btnFlightSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnFlightCityStateSearch_Click" />
                                <div class="form-group">
                                    <div id="divFlightDetails" runat="server">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4>Search by carrier name</h4>
                                                <div class="form-group">
                                                    <label for="ddlCarrierNames">Carriers</label>
                                                    <asp:DropDownList ID="ddlFlightCarriers" CssClass="form-control" runat="server">
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnCarrierSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnCarrierNameSearch_Click" />
                                            </div>
                                            <div class="col-md-6">
                                                <h4>Search by Type</h4>
                                                <div class="form-group">
                                                    <label for="ddlFlightType">Type of flight</label>
                                                    <asp:DropDownList ID="ddlFlightType" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="First Class">First Class</asp:ListItem>
                                                        <asp:ListItem Value="Economy">Economy</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnFlightTypeSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnFlightTypeSearch_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divFlightResults" runat="server" style="text-align: center" visible="false">
                                    <div class="page-header">
                                        <h3>Flights available</h3>
                                    </div>
                                    <div style="width: 100%; text-align: center;">
                                        <div class="row">
                                            <asp:Repeater ID="rptFlights" runat="server" OnItemCommand="rptFlights_ItemCommand">
                                                <ItemTemplate>
                                                    <div class="col-md-3">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <h4>
                                                                    <asp:Label ID="lblCarrierName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "carrierName") %>'></asp:Label><br />
                                                                    
                                                                    From:
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OriginCity") %>'></asp:Label><br />
                                                                     To:
                                                                    <asp:Label ID="lblDestinationCity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DestinationCity") %>'></asp:Label>
                                                                </h4>
                                                               <p>
                                                                    Price: $ 
                                                                <asp:Label ID="lblFlightPrice" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, ddlFlightType.SelectedItem.Text.Replace(" ", "") + "Price") %>'></asp:Label>
                                                                </p>
                                                                <asp:LinkButton ID="btnFlightAddToCart" CssClass="btn btn-default" runat="server" Text="<span class='glyphicon glyphicon-shopping-cart'></span> Add to cart"></asp:LinkButton>
                                                                <asp:Label ID="lblFlightID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "flightID") %>' Visible="false"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                    <asp:Button ID="btnFlightsClear" CssClass="btn btn-default" runat="server" Text="Back" OnClick="btnFlightsClear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">Reserve a hotel</h3>
                            </div>
                            <div id="divHotelView" runat="server" class="panel-body">
                                <div class="form-group">
                                    <label for="txtHotelCity">City</label>
                                    <asp:TextBox ID="txtHotelCity" runat="server" class="form-control" placeholder="Enter city"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="ddlHotelState">State</label>
                                    <asp:DropDownList ID="ddlHotelState" CssClass="form-control" runat="server">
                                        <asp:ListItem>Select destination state</asp:ListItem>
                                        <asp:ListItem>AL</asp:ListItem>
                                        <asp:ListItem>AK</asp:ListItem>
                                        <asp:ListItem>AZ</asp:ListItem>
                                        <asp:ListItem>AR</asp:ListItem>
                                        <asp:ListItem>CA</asp:ListItem>
                                        <asp:ListItem>CO</asp:ListItem>
                                        <asp:ListItem>CT</asp:ListItem>
                                        <asp:ListItem>DE</asp:ListItem>
                                        <asp:ListItem>FL</asp:ListItem>
                                        <asp:ListItem>GA</asp:ListItem>
                                        <asp:ListItem>HI</asp:ListItem>
                                        <asp:ListItem>ID</asp:ListItem>
                                        <asp:ListItem>IL</asp:ListItem>
                                        <asp:ListItem>IN</asp:ListItem>
                                        <asp:ListItem>IA</asp:ListItem>
                                        <asp:ListItem>KS</asp:ListItem>
                                        <asp:ListItem>KY</asp:ListItem>
                                        <asp:ListItem>LA</asp:ListItem>
                                        <asp:ListItem>ME</asp:ListItem>
                                        <asp:ListItem>MD</asp:ListItem>
                                        <asp:ListItem>MA</asp:ListItem>
                                        <asp:ListItem>MI</asp:ListItem>
                                        <asp:ListItem>MN</asp:ListItem>
                                        <asp:ListItem>MS</asp:ListItem>
                                        <asp:ListItem>MO</asp:ListItem>
                                        <asp:ListItem>MT</asp:ListItem>
                                        <asp:ListItem>NE</asp:ListItem>
                                        <asp:ListItem>NV</asp:ListItem>
                                        <asp:ListItem>NH</asp:ListItem>
                                        <asp:ListItem>NJ</asp:ListItem>
                                        <asp:ListItem>NM</asp:ListItem>
                                        <asp:ListItem>NY</asp:ListItem>
                                        <asp:ListItem>NC</asp:ListItem>
                                        <asp:ListItem>ND</asp:ListItem>
                                        <asp:ListItem>OH</asp:ListItem>
                                        <asp:ListItem>OK</asp:ListItem>
                                        <asp:ListItem>OR</asp:ListItem>
                                        <asp:ListItem>PA</asp:ListItem>
                                        <asp:ListItem>RI</asp:ListItem>
                                        <asp:ListItem>SC</asp:ListItem>
                                        <asp:ListItem>SD</asp:ListItem>
                                        <asp:ListItem>TN</asp:ListItem>
                                        <asp:ListItem>TX</asp:ListItem>
                                        <asp:ListItem>UT</asp:ListItem>
                                        <asp:ListItem>VT</asp:ListItem>
                                        <asp:ListItem>VA</asp:ListItem>
                                        <asp:ListItem>WA</asp:ListItem>
                                        <asp:ListItem>WV</asp:ListItem>
                                        <asp:ListItem>WI</asp:ListItem>
                                        <asp:ListItem>WY</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <asp:Button ID="btnHotelCityStateSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnHotelCityStateSearch_Click" />
                                <div class="form-group">
                                    <div id="divHotelDetails" runat="server">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h4>Search by hotel name</h4>
                                                <div class="form-group">
                                                    <label for="ddlHotelNames">Hotels</label>
                                                    <asp:DropDownList ID="ddlHotelNames" CssClass="form-control" runat="server">
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnHotelNameSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnHotelNameSearch_Click" />
                                            </div>
                                            <div class="col-md-6">
                                                <h4>Search by amenities</h4>
                                                <div class="form-group">
                                                    <label for="ddlWifi">WiFi</label>
                                                    <asp:DropDownList ID="ddlWifi" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="2">No Preference</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlValet">Valet Parking</label>
                                                    <asp:DropDownList ID="ddlValet" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="2">No Preference</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlSmoking">Smoking</label>
                                                    <asp:DropDownList ID="ddlSmoking" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="2">No Preference</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlGym">Gym</label>
                                                    <asp:DropDownList ID="ddlGym" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="2">No Preference</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlPoolBar">Poolside Bar</label>
                                                    <asp:DropDownList ID="ddlPoolBar" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="2">No Preference</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ddlBreakfast">Free Breakfast</label>
                                                    <asp:DropDownList ID="ddlBreakfast" CssClass="form-control" runat="server">
                                                        <asp:ListItem Selected="True" Value="2">No Preference</asp:ListItem>
                                                        <asp:ListItem Value="1">Yes</asp:ListItem>
                                                        <asp:ListItem Value="0">No</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <asp:Button ID="btnHotelAmenitiesSearch" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="btnHotelAmenitiesSearch_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="divHotelResults" runat="server" style="text-align: center" visible="false">
                                    <div class="page-header">
                                        <h3>Rooms available</h3>
                                    </div>
                                    <div style="width: 100%; text-align: center;">
                                        <div class="row">
                                            <asp:Repeater ID="rptHotelResults" runat="server" OnItemCommand="rptHotels_ItemCommand">
                                                <ItemTemplate>
                                                    <div class="col-md-3">
                                                        <div class="panel panel-default">
                                                            <div class="panel-body">
                                                                <h4>
                                                                    <asp:Label ID="lblHotelName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'></asp:Label>
                                                                </h4>
                                                                <p>
                                                                    Price: $ 
                                                                <asp:Label ID="lblHotelPrice" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Price") %>'></asp:Label>
                                                                </p>
                                                                <asp:LinkButton ID="btnHotelAddToCart" CssClass="btn btn-default" runat="server" Text="<span class='glyphicon glyphicon-shopping-cart'></span> Add to cart"></asp:LinkButton>
                                                                <asp:Label ID="lblRoomID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RoomID") %>' Visible="false"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                    <asp:Button ID="btnHotelClear" CssClass="btn btn-default" runat="server" Text="Back" OnClick="btnHotelsClear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>

    <!-- jQuery -->
    <script src="js/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="js/bootstrap.min.js"></script>

    <!-- js Logic -->
    <script src="js/home.js"></script>
</body>
</html>
