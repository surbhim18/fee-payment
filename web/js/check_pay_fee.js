function fee_validate() //no idea why not working here
{
    var fee = document.getElementById("feeamt").value;
    var regex = /^[0-9]+(\.[0-9][0-9]?)?$/;
    
    if (regex.test(fee))
    {
        document.getElementById("feeamtDiv").innerHTML = "";
        return true;
    }
    
    document.getElementById("feeamtDiv").innerHTML = "invalid amount!";
    return false;    
    
}

function validate_pay_fee()
{
    var x = validate_check_fee();
    var y = validateRollNo();
    
    if (x && y)
        return true;
    else
        return false;    
}

function validate_check_fee()
{
    var x = validateCourse();
    var y = validateYear();

    if (x && y)
        return true;
    else
        return false;
}

function validateCourse() 
{

    var course = document.getElementById("course").value;
    if (course === "default")
    {
        document.getElementById("courseDiv").innerHTML = "please select course!";
        return false;
    }

    document.getElementById("courseDiv").innerHTML = "";
    return true;
}

function validateYear() 
{

    var year = document.getElementById("year").value;
    if (year === "default")
    {
        document.getElementById("yearDiv").innerHTML = "please select year!";
        return false;
    }

    document.getElementById("yearDiv").innerHTML = "";
    return true;
}

function validateRollNo()
{
    var rollno = document.getElementById("rollno").value;
    var regex = /^[1-9][0-9][A-Z]{3}[0-9]{4}$/;

    if (regex.test(rollno))
    {
        document.getElementById("rollNoDiv").innerHTML = "";
        return true;
    }
    
    document.getElementById("rollNoDiv").innerHTML = "invalid roll no!";
    return false;    
}

