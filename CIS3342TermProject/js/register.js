var formValidated = [false, false, false, false, false];

var xmlhttp;

if (window.XMLHttpRequest) {
    // Code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest();
}
else {
    // Code for IE6, IE5
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
}

function checkEmail(email) {
    // Open a new asynchronous request, set the callback function, and send the request.
    xmlhttp.open("POST", "AJAX_Data.aspx", true);
    xmlhttp.onreadystatechange = onComplete;
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send("email=" + email);
}

// Callback function used to update the page when the server completes a response
// to an asynchronous request.
function onComplete() {
    //Response is READY and Status is OK
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        if (xmlhttp.responseText == "true") {
            $("#emailGroup").removeClass("has-success");
            $("#emailGroup").addClass("has-error");

            $("#emailGroup > span.glyphicon").removeClass("glyphicon-ok");
            $("#emailGroup > span.glyphicon").addClass("glyphicon-remove");

            formValidated[2] = false;

            checkFormValidation();

            if ($("#emailAlert").css("display") == "none") {
                $("#emailAlert").html("The selected email is already used, please choose another!");
                $("#emailAlert").slideDown("slow", function () {
                    $("#emailAlert").css("display", "block");
                });
            }
        }
        else {
            $("#emailGroup").removeClass("has-error");
            $("#emailGroup").addClass("has-success");

            $("#emailGroup > span.glyphicon").removeClass("glyphicon-remove");
            $("#emailGroup > span.glyphicon").addClass("glyphicon-ok");

            formValidated[2] = true;

            checkFormValidation();

            $("#emailAlert").html("");
            $("#emailAlert").slideUp("slow", function () {
                $("#emailAlert").css("display", "none");
            });
        }
    }

}

$(document).ready(function () {
    $("#jsAlert").css("display", "none");

    $("#firstNameGroup > input.form-control").keyup(function () {
        var fieldValue = $("#firstNameGroup > input.form-control").val();
        if (fieldValue.length > 1) {
            $("#firstNameGroup").removeClass("has-error");
            $("#firstNameGroup").addClass("has-success");

            $("#firstNameGroup > span.glyphicon").removeClass("glyphicon-remove");
            $("#firstNameGroup > span.glyphicon").addClass("glyphicon-ok");

            formValidated[0] = true;
        }
        else {
            $("#firstNameGroup").removeClass("has-success");
            $("#firstNameGroup").addClass("has-error");

            $("#firstNameGroup > span.glyphicon").removeClass("glyphicon-ok");
            $("#firstNameGroup > span.glyphicon").addClass("glyphicon-remove");

            formValidated[0] = false;
        }

        checkFormValidation();
    });

    $("#lastNameGroup > input.form-control").keyup(function () {
        var fieldValue = $("#lastNameGroup > input.form-control").val();
        if (fieldValue.length > 1) {
            $("#lastNameGroup").removeClass("has-error");
            $("#lastNameGroup").addClass("has-success");

            $("#lastNameGroup > span.glyphicon").removeClass("glyphicon-remove");
            $("#lastNameGroup > span.glyphicon").addClass("glyphicon-ok");

            formValidated[1] = true;
        }
        else {
            $("#lastNameGroup").removeClass("has-success");
            $("#lastNameGroup").addClass("has-error");

            $("#lastNameGroup > span.glyphicon").removeClass("glyphicon-ok");
            $("#lastNameGroup > span.glyphicon").addClass("glyphicon-remove");

            formValidated[1] = false;
        }

        checkFormValidation();
    });

    $("#emailGroup > input.form-control").keyup(function () {
        var emailText = $("#emailGroup > input.form-control").val();
        if (validateEmail(emailText)) {
            checkEmail(emailText);
        }
        else {
            $("#emailGroup").removeClass("has-success");
            $("#emailGroup").addClass("has-error");

            $("#emailGroup > span.glyphicon").removeClass("glyphicon-ok");
            $("#emailGroup > span.glyphicon").addClass("glyphicon-remove");

            formValidated[2] = false;
        }

        checkFormValidation();
    });

    $("#passwordGroup1 > input.form-control").keyup(function () {
        var primaryPassword = $("#passwordGroup1 > input.form-control").val();
        var secondaryPassword = $("#passwordGroup2 > input.form-control").val();
        if (validatePassword(primaryPassword)) {
            $("#passwordGroup1").removeClass("has-error");
            $("#passwordGroup1").addClass("has-success");

            $("#passwordGroup1 > span.glyphicon").removeClass("glyphicon-remove");
            $("#passwordGroup1 > span.glyphicon").addClass("glyphicon-ok");

            formValidated[3] = true;

            if (secondaryPassword == primaryPassword) {
                $("#passwordGroup2").removeClass("has-error");
                $("#passwordGroup2").addClass("has-success");

                $("#passwordGroup2 > span.glyphicon").removeClass("glyphicon-remove");
                $("#passwordGroup2 > span.glyphicon").addClass("glyphicon-ok");

                formValidated[4] = true;
            }
            else {
                $("#passwordGroup2").removeClass("has-success");
                $("#passwordGroup2").addClass("has-error");

                $("#passwordGroup2 > span.glyphicon").removeClass("glyphicon-ok");
                $("#passwordGroup2 > span.glyphicon").addClass("glyphicon-remove");

                formValidated[4] = false;
            }
        }
        else {
            $("#passwordGroup1").removeClass("has-success");
            $("#passwordGroup1").addClass("has-error");

            $("#passwordGroup1 > span.glyphicon").removeClass("glyphicon-ok");
            $("#passwordGroup1 > span.glyphicon").addClass("glyphicon-remove");

            formValidated[3] = false;
        }

        checkFormValidation();
    });

    $("#passwordGroup2 > input.form-control").keyup(function () {
        var password1 = $("#passwordGroup1 > input.form-control").val();
        var password2 = $("#passwordGroup2 > input.form-control").val();
        if (password2 == password1) {
            $("#passwordGroup2").removeClass("has-error");
            $("#passwordGroup2").addClass("has-success");

            $("#passwordGroup2 > span.glyphicon").removeClass("glyphicon-remove");
            $("#passwordGroup2 > span.glyphicon").addClass("glyphicon-ok");

            formValidated[4] = true;
        }
        else {
            $("#passwordGroup2").removeClass("has-success");
            $("#passwordGroup2").addClass("has-error");

            $("#passwordGroup2 > span.glyphicon").removeClass("glyphicon-ok");
            $("#passwordGroup2 > span.glyphicon").addClass("glyphicon-remove");

            formValidated[4] = false;
        }

        checkFormValidation();
    });
});

function checkFormValidation() {
    var enableButton = true;

    for (var i = 0; i < formValidated.length; i++) {
        if (!formValidated[i]) {
            enableButton = false;
            break;
        }
    }

    if (enableButton) {
        $("#btnRegister").removeClass("disabled");
    }
    else {
        $("#btnRegister").addClass("disabled");
    }
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function validatePassword(str) {
    // at least one number, one lowercase and one uppercase letter
    // at least six characters
    var re = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/;
    return re.test(str);
}