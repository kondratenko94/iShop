<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Header</title>

    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />

    <sec:authentication var="principal" property="principal" />

</head>
<body>

    <!-- Message JavaScript -->
    <spring:url value="/resources/js/message.js" var="messagejs" />
    <script src="${messagejs}"></script>

    <div id="message" style="display: none">
        <div class="message_heading" >
            <span id="messageCaption">заголовок</span>
        </div>

        <div class="message_body">
            <span  id="messageBody">описание</span>
        </div>
    </div>

    <div class="container" style="margin-bottom: 0.6em">

        <div class="row" style="margin-top: .6em">

            <div class="col-lg-2 col-md-2 col-sm-6 col-xs-5 vertical_align height4em">

                <div style="display: inline-block;">
                    <h1 class="site_title">iShop</h1>
                    <h2 class="site_caption">Интернет-магазин</h2>
                </div>

            </div>

            <div class="hidden-lg hidden-md col-sm-6 col-xs-7 vertical_align height4em" style="padding-left : 0;justify-content: flex-end">
                <div style="display: inline-block">
                    <i class="fa fa-phone" style="white-space: pre"> +375 (25) 555-55-55</i> <br>
                    <i class="fa fa-phone" style="white-space: pre"> +375 (29) 777-77-77</i>
                </div>
            </div>

            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12 vertical_align height4em">
                <div class = "dropdown" style="width: 100%">
                    <div class="search_block input-group">
                        <input id="search" type = "text" class = "form-control" autocomplete="off" placeholder="Поиск товаров">
                        <span class = "input-group-addon search_btn" onclick="openSearchPage()"><i class="fa fa-search"></i></span>
                    </div>

                    <ul id="search_menu" class="dropdown-menu"></ul>

                </div>

            </div>

            <div class = "col-lg-2 col-md-2 hidden-sm hidden-xs vertical_align height4em" style="padding : 0; justify-content: center">

                <div style="display: inline-block;">
                    <i class="fa fa-phone" style="white-space: pre"> +375 (25) 555-55-55</i> <br>
                    <i class="fa fa-phone" style="white-space: pre"> +375 (29) 777-77-77</i>
                </div>
            </div>

            <div class="col-lg-3 col-md-3 col-sm-12 vertical_align height4em">

                <!-- navbar-collapse -->
                <ul class="nav navbar-nav li_left">

                    <li>
                        <button id="cartButton" class="btn btn-default btn-lg btn_nav disable_focus"
                                data-toggle="modal" data-target="#myModal"
                                style="border-top-right-radius: 0; border-bottom-right-radius: 0; border-right: none">
                            <i class="fa fa-shopping-cart quick-btn">
                                <span id="cartCount" class="custom_label vertical_align"></span>

                                <script>
                                    var cartList = JSON.parse(localStorage.getItem("shoppingCart"));
                                    if (cartList != null && cartList.length > 0) {
                                        $('#cartCount').html(cartList.length);
                                    } else {
                                        $('#cartCount').html(0);
                                    }
                                </script>
                            </i>

                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <div class="modal-header">

                                        <div>
                                            <button type="button" onclick="$('#myModal').modal('toggle')" class="close space_left">
                                                <i class="fa fa-times" style="font-size: 0.8em"></i>
                                            </button>
                                            <button id="cartResetButton" type="button" class="close space_left" onclick="clearCartStorage()">
                                                <i class="fa fa-trash" style="font-size: 0.72em"></i>
                                            </button>
                                            <button type="button" class="close space_left" onclick="updateCartStorage()">
                                                <i class="fa fa-refresh" style="font-size: 0.68em"></i>
                                            </button>
                                        </div>

                                        <h4 class="modal-title" id="myModalLabel">Корзина товаров :</h4>
                                    </div>

                                    <div id="cartItems" class="modal-body center-block" style="width: 100%; padding : 0">
                                        Список товаров
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" id="checkout" class="btn btn-primary pull-right" style="margin-left: 0.8em">Оформить заказ</button>
                                        <h4 id="totalSum" class="pull-right" style="margin-bottom: 0; margin-top: 0.5em"></h4>
                                    </div>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                    </li>

                    <li class="dropdown hover_drop">

                        <button class="btn btn-default btn-lg disable_focus btn_nav" id="compare_trash_down" onclick="compareSelectedItems()"
                                style="border-top-right-radius: 0; border-bottom-right-radius: 0; border-top-left-radius: 0; border-bottom-left-radius: 0;">
                            <i class="fa fa-bar-chart quick-btn">
                                <span id="compareCount" class="custom_label vertical_align"></span>

                                <script>
                                    var compareList = JSON.parse(localStorage.getItem("compareList"));
                                    if (compareList != null && compareList.length > 0) {
                                        $('#compareCount').html(compareList.length);
                                    } else {
                                        $('#compareCount').html(0);
                                    }
                                </script>

                            </i>
                        </button>

                        <button id="compareResetButton" class="btn btn-default btn-lg disable_focus dropdown-menu btn_nav" onclick="clearCompareStorage()">
                            <i class="fa fa-trash" ></i>
                        </button>
                    </li>

                    <li>
                        <button id="favouriteButton" class="btn btn-default  btn-lg disable_focus btn_nav"
                                style="border-top-left-radius: 0; border-bottom-left-radius: 0; border-left: none">
                            <i class="glyphicon glyphicon-heart"></i>
                        </button>

                    </li>
                </ul>
                <!-- ./navbar-collapse -->
                <div class = "btn-group" style="margin-left: auto">

                    <sec:authorize access="isFullyAuthenticated() or isRememberMe()">
                        <div class="user_icon btn dropdown-toggle pull-right" data-toggle = "dropdown">

                            <c:choose>
                                <c:when test="${!empty principal.photo}">
                                    <img src="${location}${principal.photo}" width="30px" height="30px" style="border-radius: 15px">
                                </c:when>

                                <c:otherwise>
                                    <img src="${noImage}" width="30px" height="30px" style="border-radius: 15px">
                                </c:otherwise>
                            </c:choose>

                        </div>

                        <div id="user_drop_menu" class = "dropdown-menu dropdown-menu-right" role = "menu">

                            <ul class="custom_dropdown">
                                <li>
                                    <a href="/profile/">
                                        <div class="full_width full_height">
                                            <span class="margin_right_3px glyphicon glyphicon-user"></span> Профиль
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>

                                <sec:authorize access="hasRole('MODER')">
                                    <li>
                                        <a href="/management/desktop/">
                                            <div class="full_width full_height">
                                                <span class="margin_right_3px glyphicon glyphicon-wrench"></span> Управление
                                            </div>
                                        </a>
                                    </li>
                                    <li class="divider"></li>
                                </sec:authorize>

                                <li>
                                    <a href="/profile/settings">
                                        <div class="full_width full_height">
                                            <span class="margin_right_3px glyphicon glyphicon-cog"></span> Настройки
                                        </div>
                                    </a>
                                </li>
                                <li class="divider"></li>

                                <li>
                                    <a href="#" onclick="$('#logoutButton').click()">
                                        <div class="full_width full_height">
                                            <span class="margin_right_3px glyphicon glyphicon-log-out"></span> Выйти
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>

                        <form action="/logout" method="post" hidden="hidden">
                            <button id="logoutButton" hidden="hidden" type="submit"></button>
                            <sec:csrfInput/>
                        </form>

                    </sec:authorize>

                    <sec:authorize access="isAnonymous()">
                        <div class="pull-right user_icon">
                            <a href="/authorization" class="vertical_align btn-circle">
                                <i class="glyphicon glyphicon-user" style="margin-top: -4px"></i>
                            </a>
                        </div>
                    </sec:authorize>

                </div>

            </div>

        </div>

    </div>

    <form:form id="compareForm" action="/compare/" method="get" modelAttribute="compareProduct">
        <form:hidden path="type" id="type"/>
        <form:hidden path="idList" id="compareList"/>
    </form:form>


    <!-- Modal -->
    <div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="orderModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">

                    <div>
                        <button type="button" class="close space_left" onclick="$('#orderModal').modal('toggle')">
                            <i class="fa fa-times" style="font-size: 0.8em"></i>
                        </button>
                    </div>

                    <h4 class="modal-title" id="orderModalLabel">Информация о покупателе :</h4>
                </div>

                <div id="orderData" class="modal-body center-block" style="width: 100%; padding : 6px 16px;">

                    <sec:authorize access="isAnonymous()" var="isAnonymous" />

                    <div class="form-group">
                        <label class="control-label">Ф.И.О.</label>
                        <input type="text" class="form-control" autocomplete="off" id="cart_name"
                               value="${!isAnonymous && !empty principal.name ? principal.name : ''}" />
                    </div>

                    <div class="form-group">
                        <label class="control-label">E-mail *</label>
                        <input type="text" class="form-control" autocomplete="off" id="cart_email"
                               value="${!isAnonymous && !empty principal.email ? principal.email : ''}" />
                    </div>

                    <div class="form-group">
                        <label class="control-label">Телефон *</label>
                        <input type="text" class="form-control" autocomplete="off" id="cart_phone"
                               value="${!isAnonymous && !empty principal.phone ? principal.phone : ''}" />
                    </div>

                    <div class="form-group">
                        <label class="control-label">Адрес доставки</label>
                        <input type="text" class="form-control" autocomplete="off" id="cart_address"
                               value="${!isAnonymous && !empty principal.address ? principal.address : ''}" />
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" onclick="sendOrder()" class="btn btn-primary pull-right" style="margin-left: 0.8em">Отправить заказ</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- JSON objects JavaScript -->
    <spring:url value="/resources/js/model.js" var="model" />
    <script src="${model}"></script>

<script>

    "use strict";

    function setTotalCartCost() {
        var total = 0;

        $('.sumElement').each(function () {
            total += parseFloat($(this).html());
        });

        if (total > 0) {
            $('#totalSum').html(' Итого : ' + total.toFixed(2) + ' руб.');
        } else {
            $('#totalSum').html('');
        }

    }

    function changeSum(sumId, countId, price, delta) {

        var currentCount = $('#' + countId).html();
        var newCount = parseInt(currentCount) + delta;;

        if (newCount < 1) {
            newCount = 1;

        } else if (newCount > 20) {
            newCount = 20;
        }

        $('#' + sumId).html( (newCount * price).toFixed(2) );
        $('#' + countId).html(newCount);

        setTotalCartCost();

    }

    function buildShoppingCartMenu() {
        var productList = JSON.parse(localStorage.getItem('shoppingCart'));

        if (productList != null && productList.length != 0) {

            var table = '<div class="table-responsive" style="border : none; margin-bottom: 0"><table id="cartTable" class="table"><tbody>';

            var result = 0;
            for (var i = 0; i < productList.length; i++) {

                var product = productList[i];

                if (product.price == undefined) product.price = 0;
                result += product.price;

                table += '<tr id="' + product.type + product.id + '">';

                var imgSrc = (product.link == '') ? '${noImage}' : ( '${location}' + product.link );
                var imgElem = '<a href="/' + product.type + '/' + product.id + '"><img src=' + imgSrc + ' style="max-width: 6em; max-height: 7em"></a>';

                table += '<td class="text-center"><div class="vertical_align" style="height: 7em; justify-content: center">' + imgElem + '</div></td>';

                table += '<td colspan="2" style="vertical-align: middle; text-align: center">' + product.caption + ' ' + product.name + '</td>';

                var sumId = 'sum_' + product.type + product.id;
                var countId = 'cnt_' + product.type + product.id;
                var onclickMinus = 'onclick="changeSum(\'' + sumId + '\',\'' + countId + '\',' + product.price + ', -1)"';
                var onclickPlus = 'onclick="changeSum(\'' + sumId + '\',\'' + countId + '\',' + product.price + ', 1)"';

                var countElem = '<div ' + onclickMinus + ' class="item_counter noselect item_btn vertical_align" style="border-top-left-radius: 3px; border-bottom-left-radius: 3px">-</div>' +
                        '<div class="item_counter noselect vertical_align" id="' + countId + '" style="border-left: none; border-right: none">1</div>' +
                        '<div ' + onclickPlus + ' class="item_counter noselect item_btn vertical_align" style="border-top-right-radius: 3px; border-bottom-right-radius: 3px">+</div>';
                table += '<td class="text-center" style="vertical-align: middle"><div style="display: inline-flex; vertical-align: middle">' + countElem + '<div></td>';

                var closeBtnElem = '<button style="position:absolute; right:0.7em; top:0.3em" class="close" onclick="removeItemFromCart(' + product.id + ',\'' + product.type + '\',\'' + product.type + product.id + '\')" type="button">&times;</button>';
                var sumElem = '<span id="' + sumId + '" class="sumElement">' + product.price.toFixed(2) + '</span> р.';
                table += '<td style="vertical-align: middle; text-align: center; position: relative">' + sumElem + closeBtnElem + '</td>';

                table += "</tr>";
            }

            table += '</tbody></table></div>';

            $('#cartItems').html(table);
            setTotalCartCost();

        } else {
            $('#cartItems').html("<div style='padding: 15px'>Корзина товаров пуста.</div>");
        }
    }

    function openSearchPage() {

        var input = $('#search').val();
        if (input.length > 0) {
            location.href = "/search/?input=" + input;
        }

    }

    function loadSearchMenu(input) {
        $.ajax({
            type : "GET",
            url : "/search/product/",
            data : {'name' : input, page : 1},
            timeout : 100000,
            success : function(result) {

                var maxCount = result.maxCount;
                var products = result.list;

                var menu = $('#search_menu');

                if (maxCount > 0) {
                    var content = '';

                    for (var i = 0; i < products.length; i++) {

                        var img;
                        if (products[i].link != '') {
                            img = '${location}' +products[i].link;

                        } else img = '${noImage}';

                        var id = products[i].id;
                        var name = products[i].name;
                        var type = products[i].type;
                        var caption = products[i].caption;
                        var price = products[i].price;

                        var element = '<div class="row" style="height: 5em">';

                        element += '<div class="vertical_align col-lg-3 col-md-3 col-sm-3 col-xs-3" style="justify-content: center; height: 100%"> <img src="' + img + '" style="max-height : 94%; max-width: 4.5em"> </div>';
                        element += '<div class="vertical_align col-lg-6 col-md-6 col-sm-6 col-xs-6" style="justify-content: center; white-space: pre-line; overflow: hidden; height: 100%; font-size: 12px"> ' + caption +'<br>' + name + ' </div>';
                        element += '<div class="vertical_align product_price col-lg-3 col-md-3 col-sm-3 col-xs-3" style="justify-content: center; height: 100%; font-size: 14px"> ' + price + ' руб. </div>';

                        element += '</div>';

                        content += '<li><a href="/' + type + '/' + id + '"> ' + element + '</a></li>';
                    }

                    var closeBtn = '(<span style="color: #1d4064; cursor: pointer" onclick="hideSearchMenu()">Скрыть</span>)';
                    content += '<li style="margin-top : 4px; font-size: 12px; border-top: 1px solid #eee; padding: 5px">Найдено : ' + maxCount +' товаров ' + closeBtn + '</li>';


                    menu.html(content);

                    menu.toggle();
                } else {
                    menu.html('<li style="font-size: 12px; padding: 3px">Нет совпадений.</li>');
                    menu.toggle();
                }
            },
            error : function(e) {
                console.log("ERROR: ", e);
            },
            done : function(e) {
                console.log("DONE");
            }

        });
    }

    $('#checkout').click(function (){

        var count = ( JSON.parse(localStorage.getItem('shoppingCart')) ).length;
        if (count > 0) {
            $('#myModal').modal('toggle');

            setTimeout(function () {
                $('#orderModal').modal('toggle');
            }, 320);
        } else {

            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Уведомление';
            var content = 'Необходимо выбрать хотя бы один <b>товар</b>.';

            showMessage(element, bodyHeight, caption, content);
        }

    });

    var timer = null;
    $('#search').keyup(function () {

        var input = $('#search').val();
        if (input.length == 0) {
            clearTimeout(timer);
            $("#search_menu").html('');
            return;
        }

        if (timer) {
            clearTimeout(timer);
        }

        timer = setTimeout( function () {
            loadSearchMenu(input);
        }, 720);

    });

    //reset search block if key pressed
    $('#search').on('keydown', function () {

        var isHidden = $("#search_menu").is( ":hidden" );
        if (isHidden == false) {
            $("#search_menu").html('');
            $("#search_menu").toggle();
        }
    });

    function hideSearchMenu() {
        var isHidden = $("#search_menu").is( ":hidden" );
        if (!isHidden) {
            $("#search_menu").toggle();
        }
    }

    //
    $('#search').on('focusin', function () {

        var menu = $("#search_menu");
        if (menu.html() != '') {

            var isHidden = menu.is( ":hidden" );
            if (isHidden) {
                menu.toggle();
            }
        }
    });

    $('#cartButton').click(function () {
        buildShoppingCartMenu();
    });

    function sendOrder() {
        var name = $('#cart_name').val();
        var email = $('#cart_email').val();
        var phone = $('#cart_phone').val();
        var address = $('#cart_address').val();

        if (email != '' && phone != '') {
            var items = [];

            $('#cartTable').find('> tbody > tr').each(function () {

                var rowId = $(this).attr('id');

                var id = rowId.match('[0-9]+$')[0];
                var count = $('#cnt_' + rowId).html();

                var item = new Item(null, null, count, null, id, null, null);

                items.push(item);
            });

            var order = new Order(null, email, phone, name, null, null, null, address, null, null, null, null, items);

            $.ajax({
                type : "POST",
                url : "/cart/order",
                contentType : "application/json",
                data : JSON.stringify(order),
                dataType : 'json',
                timeout : 100000,
                success : function(result) {

                    if (result != null && result == true) {

                        $('#orderModal').modal('toggle');

                        var element = '#message';
                        var bodyHeight = $('html > body').height();
                        var caption = 'Уведомление';
                        var content = 'Заказ успешно <b>отправлен</b>.';

                        showMessage(element, bodyHeight, caption, content);
                    } else {

                        var element = '#message';
                        var bodyHeight = $('html > body').height();
                        var caption = 'Ошибка';
                        var content = 'Произошла ошибка';

                        showMessage(element, bodyHeight, caption, content);
                    }
                },
                error : function(e) {
                    console.log(e)
                }
            });

        } else {
            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Ошибка';
            var content = 'Заполните обязательные <b>поля</b>.';

            showMessage(element, bodyHeight, caption, content);
        }

    }

    function removeItemFromCart(id, type, rowId) {

        // if product page opened
        if (typeof resetCartButton !== "undefined") {
            resetCartButton(id, type);
        }

        var productList = JSON.parse(localStorage.getItem('shoppingCart'));
        if (productList != null) {

            for (var i = 0; i < productList.length; i++) {
                var p = productList[i];

                if (p.id == id && p.type == type) {

                    productList.splice(i, 1);
                    localStorage.setItem('shoppingCart', JSON.stringify(productList));
                    updateShoppingCart(productList.length);

                    $('#' + rowId).fadeOut(300, function () {
                        $('#' + rowId).remove();
                        setTotalCartCost();

                        var rowCount = $('#cartTable').find('>tbody >tr').length;

                        if (rowCount == 0) {
                            $("#myModal").find(".close").click();
                        }
                    });

                    $('#cart' + id + type).removeClass('pressed');

                    return;
                }
            }
        }

    }

    function updateShoppingCart(length) {
        $('#cartCount').html(length);
    }

    function updateCompare(length) {
        $('#compareCount').html(length);
    }

    function compareSelectedItems() {

        if ($('#compareCount').html() != 0) {
            $('#type').val(localStorage.getItem('type'));
            $('#compareList').val(localStorage.getItem('compareList'));
            $('#compareForm').submit();
        }
    }

    $('#favouriteButton').click(function (){
        location.href = "/profile/favourite";
    });

    function updateCartStorage() {

        var productList = JSON.parse(localStorage.getItem("shoppingCart"));

        if (productList != null && productList.length > 0) {

            var productListMin = [];

            for (var i = 0; i < productList.length; i++) {
                var id = productList[i].id;
                var type = productList[i].type;
                var productMin = new ProductMin(id, type);

                productListMin.push(productMin);
            }

            if (productListMin.length == 0) return;

            $.ajax({
                type : "POST",
                url : "/cart/update",
                contentType : "application/json",
                data : JSON.stringify(productListMin),
                dataType : 'json',
                timeout : 100000,
                success : function(result) {

                    var updatedProductList = [];

                    for (var i = 0; i < result.length; i++) {
                        var id = result[i].id;
                        var type = result[i].type;
                        var caption = result[i].caption;
                        var name = result[i].name;
                        var link = result[i].link;
                        var price = result[i].price;

                        updatedProductList.push( new Product(id, type, caption, name, link, price) );
                    }

                    localStorage.setItem('shoppingCart', JSON.stringify(updatedProductList));
                    $('#cartTable').remove();
                    buildShoppingCartMenu();
                },
                error : function(e) {
                    console.log(e)
                },
                done : function(e) {
                    console.log("DONE");
                },
                beforeSend : function(e) {
                }

            });


        }
    }

    function clearCompareStorage(){
        localStorage.setItem('compareList', JSON.stringify([]));
        $('#compareCount').html(0);
    }

    function clearCartStorage() {
        localStorage.setItem('shoppingCart', JSON.stringify([]));
        $('#cartCount').html(0);
        $('#totalSum').html('');
        $('#cartItems').html("<div style='padding: 15px'>Корзина товаров пуста.</div>");

        $('.cart-product').removeClass('pressed');
    }

    // show/hide trash button (on hover main compare button)
    $('ul.nav li.dropdown.hover_drop').hover(function() {
        $(this).find('.dropdown-menu').stop(true, true).delay(20).fadeIn(100);
    }, function() {
        $(this).find('.dropdown-menu').stop(true, true).delay(20).fadeOut(100);
    });

</script>

</body>
</html>
