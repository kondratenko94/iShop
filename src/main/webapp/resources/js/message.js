//get parameter from get request
var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
};

var timer;
function showMessage(element, bodyHeight, caption, content) {
    $(element).css('display', 'none');
    if (timer != undefined) {
        clearTimeout(timer);
    }

    var top;
    var left;

    $(element + ' > .message_heading > #messageCaption').html(caption);
    $(element + ' > .message_body > #messageBody').html(content);

    var h = $(element).outerHeight();
    var w = $(element).outerWidth();

    {
        //dual screen disabled
        var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
        var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

        var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
        var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

        if (height > bodyHeight) {
            height = bodyHeight;
        }

        left = ((width / 2) - (w / 2));
        top = ((height / 2) - (h / 2));
        //console.log(height + ' ' + bodyHeight + ' h = ' + h + ' top = ' + top);
    }

    $(element).css('top', top);
    $(element).css('left', left);
    $(element).show(320);

    timer = setTimeout(function () {
        $(element).hide(500);
    }, 3100);
}