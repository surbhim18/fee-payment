function validate()
{
    var x = validateUsername();
    var y = validatePassword();
    var z = comparePassword();

    if (x && y && z)
        return true;
    else
        return false;
}

function validateUsername() {

    if (document.getElementById("username").value.length == 0) {
        document.getElementById("usernameDiv").innerHTML = "cannot be empty!";
        return false;
    }

    var username = document.getElementById("username").value;
    var regex = /^[1-9A-Za-z_]{4,32}$/;

    if (!regex.test(username))
    {
        document.getElementById("usernameDiv").innerHTML = "invalid username! (min length:4)";
        return true;
    }

    document.getElementById("usernameDiv").innerHTML = "";
    return true;
}

function validatePassword() {

    if (document.getElementById("password").value.length == 0) {
        document.getElementById("passwordDiv").innerHTML = "cannot be empty!";
        return false;
    }

    var password = document.getElementById("password").value;
    var regex = /^[^ /]{5,128}$/;

    if (!regex.test(password))
    {
        document.getElementById("passwordDiv").innerHTML = "invalid password! (min length:5)";
        return true;
    }

    document.getElementById("passwordDiv").innerHTML = "";
    return true;

}

function comparePassword() {

    var password = document.getElementById("password").value;
    var password2 = document.getElementById("password2").value;

    if (password !== password2)
    {
        document.getElementById("password2Div").innerHTML = "password does not match!";
        return false;
    }

    document.getElementById("password2Div").innerHTML = "";
    return true;
}