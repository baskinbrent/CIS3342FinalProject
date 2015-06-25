<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupportChat.aspx.cs" Inherits="CIS3342TermProject.SupportChat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

    <title>Support Chatroom - VacationOCity</title>
</head>
<body>
    <div class="panel panel-default" style="position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; border-radius: 0px; border: none;">
        <div class="panel-heading">
            <h3 class="panel-title">Tech support chat</h3>
        </div>
        <div class="panel-body">
            <div class="form-group" style="margin-bottom: 15px;">
                <form id="form1" role="form" class="form-inline">
                    <label for="ddlChatRoomList">Chatrooms</label>
                    <select id="ddlChatRoomList" class="form-control" onchange="changeChatRoom()">
                        <option value="test">test</option>
                    </select>
                    <button id="refreshChatroomsButton" type="button" class="btn btn-default"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
                </form>
            </div>
            <div id="chatBody" class="well" style="max-height: 300px; overflow: auto;"></div>
            <p><small>There could be a delay of up to 5 seconds before messages are displayed in the chat window</small></p>
            <form id="form2" role="form">
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" class="form-control" id="chatInput" placeholder="Chat" onkeydown="if (window.event.keyCode == 13) { event.returnValue=false; event.cancel = true; searchLocations(); }" />
                        <div id="chatEnterButton" class="input-group-addon">Go</div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- jQuery -->
    <script src="js/jquery-1.11.1.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="js/bootstrap.min.js"></script>

    <!-- js Logic -->
    <script src="js/supportchat.js"></script>
</body>
</html>
