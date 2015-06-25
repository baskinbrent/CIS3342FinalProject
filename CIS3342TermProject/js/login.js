$(document).ready(function () {
    $("#jsAlert").css("display", "none");

    validateTextField("#txtUserName");
    validateTextField("#txtPassword");
});

function validateTextField(element) {
    $(element).keyup(function () {
        var username = $("#txtUserName").val();
        var password = $("#txtPassword").val();

        if ((username.length > 0) && (password.length > 0)) {
            $("#btnLogin").removeClass("disabled");
        }
        else {
            $("#btnLogin").addClass("disabled");
        }
    });
}