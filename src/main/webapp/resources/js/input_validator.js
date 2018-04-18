$('.val_dbl').keyup(function () {
    var value = $(this).val();

    var valid = value.replace(/[^0-9.]/g, '');

    var comma = false;
    for (var i = 0; i < valid.length; i++) {
        var c = valid.charAt(i);

        if (c == '.') {
            if (comma) {
                valid = valid.slice(0, i) + valid.slice(i + 1, valid.length);
                i--;
            } else {
                comma = true;
            }
        }
    }

    if (value != valid) {
        $(this).val(valid);
    }

});

$('.val_int').keyup(function () {
    var value = $(this).val();

    var valid = value.replace(/[^0-9]/g, '');

    if (value != valid) {
        $(this).val(valid);
    }
});