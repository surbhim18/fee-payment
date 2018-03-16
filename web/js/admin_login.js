function validate()
{
    var x = isNotEmptyUsername()
    var y = isNotEmptyPassword();
    if(x&&y)
        return true;
    else
        return false;
}

function isNotEmptyUsername()
{
    if (document.getElementById("username").value.length == 0) {
        document.getElementById("usernameDiv").innerHTML = "cannot be empty!";
        return false;
    }
    
    document.getElementById("usernameDiv").innerHTML = "";
    return true;

}

function isNotEmptyPassword()
{
    if (document.getElementById("password").value.length == 0) {
        document.getElementById("passwordDiv").innerHTML = "cannot be empty!";
        return false;
    }
    
    document.getElementById("passwordDiv").innerHTML = "";
    return true;
}