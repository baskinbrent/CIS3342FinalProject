var xmlhttp;
var chatTimer;

if (window.XMLHttpRequest) {
    // Code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
}
else {
    // Code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}

function postChat() {
    var email = $('#chatUserName').val();
    var chat = '[' + email + '] ' + $('#chatInput').val();

    // Open a new asynchronous request, set the callback function, and send the request.
    xmlhttp.open("POST", "AJAX_Data.aspx", true);
    //xmlhttp.onreadystatechange = onComplete;
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("chat_post=" + chat + "&chat_username=" + email);
}

function getChat() {
    var email = $('#chatUserName').val();

    // Open a new asynchronous request, set the callback function, and send the request.
    xmlhttp.open("POST", "AJAX_Data.aspx", true);
    xmlhttp.onreadystatechange = onComplete;
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("get_chat_username=" + email);
}


$(document).ready(function () {
    $("#chatButton").click(function () {
        $("#chatButton").css("display", "none");
        $("#divTechSupportChat").css("display", "block");

        getChat();
        chatTimer = setInterval(getChat, 5000);
    });

    $('#chatEnterButton').click(function () {
        postChat();
        $('#chatInput').val('');
    });

    $('#btnCloseSupportChat').click(function () {
        $("#chatButton").css("display", "block");
        $("#divTechSupportChat").css("display", "none");

        clearInterval(chatTimer);
    });
});

// Callback function used to update the page when the server completes a response
// to an asynchronous request.
function onComplete() {
    //Response is READY and Status is OK
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        if (xmlhttp.responseText.length > 0) {
            $("#chatBody").html(xmlhttp.responseText);
            var elem = document.getElementById('chatBody');
            elem.scrollTop = elem.scrollHeight;
        }
    }

}