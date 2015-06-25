var xmlhttp;
var currentChatRoom;
var chatTimer;

if (window.XMLHttpRequest) {
    // Code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
}
else {
    // Code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}

function getChatRooms() {
    // Open a new asynchronous request, set the callback function, and send the request.
    xmlhttp.open("POST", "AJAX_Data.aspx", true);
    xmlhttp.onreadystatechange = onCompleteGetChatRooms;
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("get_chat_rooms=yes");
}

function postChat() {
    var email = currentChatRoom;
    var chat = '[admin] ' + $('#chatInput').val();

    // Open a new asynchronous request, set the callback function, and send the request.
    xmlhttp.open("POST", "AJAX_Data.aspx", true);
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("chat_post=" + chat + "&chat_username=" + email);
}

function getChat() {
    var email = currentChatRoom;

    // Open a new asynchronous request, set the callback function, and send the request.
    xmlhttp.open("POST", "AJAX_Data.aspx", true);
    xmlhttp.onreadystatechange = onComplete;
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("get_chat_username=" + currentChatRoom);
}

function changeChatRoom() {
    currentChatRoom = $("#ddlChatRoomList").find(":selected").val();
    getChat();
}

$(document).ready(function () {
    getChatRooms();

    $("#chatBody").css("height", $(window).height() - 200);
    $("#chatBody").css("max-height", $(window).height() - 200);

    $('#chatEnterButton').click(function () {
        postChat();
        $('#chatInput').val('');
    });

    $('#refreshChatroomsButton').click(function () {
        location.reload();
    });
});

// Callback function used to update the page when the server completes a response
// to an asynchronous request.
function onCompleteGetChatRooms() {
    //Response is READY and Status is OK
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        console.log(xmlhttp.responseText);
        $("#ddlChatRoomList").html(xmlhttp.responseText);
        changeChatRoom();
        chatTimer = setInterval(getChat, 5000);
    }

}

function onComplete() {
    //Response is READY and Status is OK
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        console.log(xmlhttp.responseText);
        if (xmlhttp.responseText.length > 0) {
            $("#chatBody").html(xmlhttp.responseText);
            var elem = document.getElementById('chatBody');
            elem.scrollTop = elem.scrollHeight;
        }
    }

}