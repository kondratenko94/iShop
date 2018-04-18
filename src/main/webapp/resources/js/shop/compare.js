
    "use strict";

    $(document).ready(function(){

        var currentType = localStorage.getItem("type");
        var compareList = JSON.parse(localStorage.getItem("compareList"));

        if (compareList != null) {
            for (var i = 0; i < compareList.length; i++) {
                var id = compareList[i];
                $('#compare' + id + currentType).addClass("pressed");

            }
        }

    });

    function addToCompare(id, type) {
        var currentType = localStorage.getItem('type');
        if (currentType != type) {
            localStorage.setItem('compareList', JSON.stringify([]));
            $('.compare_btn').not(type).each(function (){
               $(this).removeClass('pressed');
            });
        }

        localStorage.setItem('type', type);

        var product = id;
        var productList = JSON.parse(localStorage.getItem("compareList"));

        if (productList == null) {

            productList = [product];
            $('#compare' + id + type).addClass('pressed');

        } else {

            var position = productList.indexOf(product);

            if (position == -1) {
                productList.push(product);
                $('#compare' + id + type).addClass('pressed');

            } else {
                productList.splice(position, 1);
                $('#compare' + id + type).removeClass('pressed');
            }
            updateCompare(productList.length);
        }

        localStorage.setItem("compareList", JSON.stringify(productList));
    }