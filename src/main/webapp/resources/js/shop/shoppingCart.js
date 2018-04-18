
    "use strict";

    $(document).ready(function(){

        var shoppingCartList = JSON.parse(localStorage.getItem("shoppingCart"));
        if (shoppingCartList != null && shoppingCartList.length > 0) {

            for (var i = 0; i < shoppingCartList.length; i++) {
                var product = shoppingCartList[i];
                $('#cart' + product.id + product.type).addClass("pressed");
            }

        }

    });

    function addToCart(id, type, caption, name, link, price) {

        var product = new Product(id, type, caption, name, link, price);
        var productList = JSON.parse(localStorage.getItem('shoppingCart'));

        if (productList == null) {
            productList = [product];
            $('#shoppingCart').addClass('selected');

        } else {
            var position = -1;

            for (var i = 0; i < productList.length; i++) {
                var p = productList[i];

                if (JSON.stringify(product) == JSON.stringify(p)) {
                    position = i;
                    break;
                }
            }

            if (position == -1) {
                productList.push(product);
                $('#cart' + id + type).addClass('pressed');

            } else {
                productList.splice(position, 1);
                $('#cart' + id + type).removeClass('pressed');
            }
            updateShoppingCart(productList.length);
        }

        localStorage.setItem('shoppingCart', JSON.stringify(productList));

    }