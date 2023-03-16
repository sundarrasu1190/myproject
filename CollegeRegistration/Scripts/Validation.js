//======================CollegeName val================

function IsValidCollName(e, sender) {

    var keycode = e.keyCode ? e.keyCode : e.charCode
    if ((keycode > 64 && keycode < 91) || (keycode > 96 && keycode < 123) || (keycode == 8) || (keycode == 32) || (keycode == 38) || (keycode == 127) || (keycode == 9) || (keycode == 11)) {
        txtValue = document.getElementById(sender).value;
        txtLength = txtValue.length;
        if (keycode == 32) {
            if (txtLength < 1)
                return false;
            else
                return true;
        }
        else {
            return true;
        }
    }
    else {
        return false;
    }
}
//=================

//==========================College Address Val==========

function IsValidCollAddress(e, sender) {

    var keycode = e.keyCode ? e.keyCode : e.charCode
    if ((keycode > 47 && keycode < 58) || (keycode > 64 && keycode < 91) || (keycode > 96 && keycode < 123) || (keycode == 8) || (keycode == 32) || (keycode == 38) || (keycode == 127) || (keycode == 9) || (keycode == 11) || (keycode == 13)) {
        txtValue = document.getElementById(sender).value;
        txtLength = txtValue.length;
        if (keycode == 32) {
            if (txtLength < 1)
                return false;
            else
                return true;
        }
        else {
            return true;
        }
    }
    else {
        return false;
    }
}
//=======================

//======================Phone number val================

function IsValidPhoneno(e, sender) {

    var keycode = e.keyCode ? e.keyCode : e.charCode
    if ((keycode > 47 && keycode < 58)|| (keycode == 8) || (keycode == 43) || (keycode == 45) || (keycode == 127) || (keycode == 9) || (keycode == 11) || (keycode == 13)) {
        txtValue = document.getElementById(sender).value;
        txtLength = txtValue.length;
        if (keycode == 43) {
            if (txtLength < 1)
                return true;
            else
                return false;
        }
        else if (keycode == 45) {
            if (txtLength == 8)
                return true;
            else
                return false;
        }
        else {
            return true;
        }
    }
    else {
        return false;
    }
}

function IsValidDORO(e, sender) {
var keycode = e.keyCode ? e.keyCode : e.charCode
if ((keycode > 1 && keycode < 127)) {
    return false;
}
else {
    return true;
}
}
//=================

function validateCaseSensitiveEmail(email) {
    var reg = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/;
    if (reg.test(email)) {
        return true;
    }
    else {
        return false;
    }
} 
//left arrow 37,right arrow 39, same time (% 37, ' 39)