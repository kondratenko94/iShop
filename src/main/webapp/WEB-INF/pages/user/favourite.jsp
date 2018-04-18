<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
    <title>Избранное</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap" />
    <link href="${bootstrap}" rel="stylesheet" />

    <spring:url value="/resources/font-awesome/css/font-awesome.css" var="awesome" />
    <link href="${awesome}" rel="stylesheet" />

    <spring:url value="/resources/css/MainStyles.css" var="main" />
    <link href="${main}" rel="stylesheet" />

    <spring:url value="/images/" var="location" />

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

</head>
<body>

<!-- jQuery -->
<spring:url value="/resources/vendor/jquery/jquery.min.js" var="jquery" />
<script src="${jquery}"></script>

<div id="header">
    <jsp:include page="../shop/header.jsp" />
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="/"><i class="fa fa-home"></i></a></li>
                <li class="active">Профиль пользователя</li>
            </ol>
        </div>
    </div>
</div>

<div class="container">

    <div class="row">
        <div class="col-lg-12">

            <div class="panel-body" style="padding: 0">

                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                    <li><a href="/profile/"><i class="glyphicon glyphicon-user"></i> Профиль</a>
                    </li>
                    <li class="active"><a><i class="glyphicon glyphicon-heart"></i> Избранное</a>
                    </li>
                    <li><a href="/profile/reviews"><i class="glyphicon glyphicon-edit"></i> Отзывы</a>
                    </li>
                    <li><a href="/profile/settings"><i class="fa fa-wrench"></i> Настройки</a>
                    </li>

                </ul>

                <!-- Tab panes -->
                <div class="tab-content" style="margin-top: 0; display: inline-block; width: 100%;">
                    <div class="tab-pane fade in active">

                        <div style="padding: 4px 0 4px 0; display: inline-block">

                            <c:set var="paginationON" value="${!empty pagesCount && pagesCount > 1}" scope="page"/>

                            <c:if test="${!empty productsList}">

                                <c:forEach items="${productsList}" var="product" varStatus="loop">

                                    <div id="item${product.id}${product.type}" class="col-lg-12 col-md-12 col-sm-12 col-xs-12 favItem"
                                         style="float : left; margin-top: 1em; ${paginationON || !loop.last  ? 'border-bottom: 1px solid #eee; padding-bottom: 1em' : ''} ">

                                        <div class="row">
                                            <i class="fa fa-times"
                                               style="position: absolute; right: 1em; color: #c6cacd; cursor: pointer; z-index: 3"
                                               onclick="deleteFavouriteItem('item${product.id}${product.type}', ${product.id}, '${product.type}')">
                                            </i>

                                            <div class="col-lg-2 col-md-2 col-sm-2 center-block">
                                                <div class="text-center" style="height: 10em">

                                                    <a href="/${product.type}/${product.id}" >

                                                        <c:choose>
                                                            <c:when test="${!empty product.mainScreen}">
                                                                <img src="${location}${product.mainScreen}"
                                                                     style="max-width: 80%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${noImage}"
                                                                     style="max-width: 80%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </div>
                                            </div>

                                            <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 xs_center">

                                                <div>
                                                    <a href="/${product.type}/${product.id}"><b class="tabRow_name xs_center">${product.truncatedName}</b></a>
                                                </div>

                                                <div style="margin-top: .5em; margin-bottom: .2em">${product.shortDescription}</div>

                                                <div class="row" style="margin-top: .8em; padding-left: 15px; padding-right: 15px">

                                                    <div class="col-md-3 col-sm-5 no_side_padding">

                                                        <div id="cart${product.id}${product.type}"
                                                             class="btn_shell ${product.type} adapt_width cart-product"
                                                             onclick="addToCart(${product.id}, '${product.type}', '${product.caption}', '${product.name}', '${product.mainScreen}', ${product.price})">

                                                            <div class="btn_icon vertical_align">
                                                                <i class="fa fa-shopping-cart"></i>
                                                            </div>

                                                            <div class="btn_content vertical_align">
                                                                В корзину
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3 col-sm-5 no_side_padding">

                                                        <div id="compare${product.id}${product.type}"
                                                             class="btn_shell adapt_width compare_btn ${product.type}"
                                                             onclick="addToCompare(${product.id}, '${product.type}')">

                                                            <div class="btn_icon vertical_align">
                                                                <i class="fa fa-balance-scale"></i>
                                                            </div>

                                                            <div class="btn_content vertical_align">
                                                                Сравнить
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 text-center">

                                                <div style="display: inline-block; text-align: left">
                                                    <div class="tabRow_price">
                                                        <fmt:formatNumber pattern="#" minFractionDigits="2" value="${product.price}" /> руб.
                                                    </div>

                                                    <c:choose>
                                                        <c:when test="${product.inStock}">
                                                            <p class="inStock_good" style="margin-top: 1px"><i class="fa fa-check"> В наличии</i></p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="inStock_bad" style="margin-top: 1px"><i class="fa fa-clock-o"> Под заказ</i></p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                            </div>

                                        </div>

                                    </div>
                                </c:forEach>

                                <c:if test="${paginationON}">
                                    <div class="row">
                                        <div class="col-lg-12 col-xs-12" style="margin-bottom: 4px">

                                            <div class="custom_pagination pull-right" style="margin-top: 1em; margin-bottom: 0">
                                                <c:if test="${!empty pagesCount && pagesCount > 1}">

                                                    <c:if test="${page - 2 > 0}">
                                                        <a class="page" href="/profile/favourite">1</a>

                                                        <c:if test="${page - 2 > 1}">
                                                            <span class="empty">...</span>
                                                        </c:if>

                                                    </c:if>

                                                    <c:forEach var="i"
                                                               begin="${ (page - 1) > 0 ? (page - 1) : 1 }"
                                                               end="${ (page + 1) < pagesCount ? (page + 1) : pagesCount }">

                                                        <c:choose>
                                                            <c:when test="${i == page}">
                                                                <span class="page active">${i}</span>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <a class="page" href="/profile/favourite?page=${i}">${i}</a>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:forEach>

                                                    <c:if test="${pagesCount - page > 1}">

                                                        <c:if test="${pagesCount - page > 2}">
                                                            <span class="empty" >...</span>
                                                        </c:if>
                                                        <a class="page" href="/profile/favourite?page=${pagesCount}">${pagesCount}</a>
                                                    </c:if>

                                                </c:if>
                                            </div>

                                        </div>
                                    </div>
                                </c:if>

                            </c:if>

                            <c:if test="${empty productsList}">
                                <h3 style="margin-top: 10px; margin-bottom: 10px">Список любимых товаров пуст.</h3>
                            </c:if>

                        </div>

                    </div>
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.col-lg-12 -->
    </div>

</div>


<div id="footer"> <jsp:include page="../shop/footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<!-- shoppingCart add/onload script -->
<spring:url value="/resources/js/shop/shoppingCart.js" var="shoppingCartjs" />
<script src="${shoppingCartjs}"></script>

<!-- compare add/onload script -->
<spring:url value="/resources/js/shop/compare.js" var="comparejs" />
<script src="${comparejs}"></script>

<script>

    "use strict";

    // Listen for clicks on table originating from .delete element(s)
    // if item removed from shopping cart
    $("table").on("click", ".delete", function ( event ) {

        removeItemFromStorage($(this).attr('id').replace('del', ''));
        // Set all colspans to -1
        var count = $("tr.caption > td").attr('colspan') - 1;
        if (count == 1) {
            location.href = "/";
        } else {
            $("tr.caption > td").attr('colspan', count);


            // Get index of parent TD among its siblings (add one for nth-child)
            var ndx = $(this).parent().index() + 1;
            // Find all TD elements with the same index
            $("td", event.delegateTarget).remove(":nth-child(" + ndx + ")");
        }
    });

    // reset all selected to compare buttons
    $('#compareResetButton').click(function (){
        $(document).find(".compare_btn").each (function() {
            $(this).removeClass("pressed");
        });
    });

    function deleteFavouriteItem(elementIdName, id, type) {

        $.ajax({
            type : "POST",
            url : "/favourite/item",
            contentType : "application/json",
            data : JSON.stringify({ id : id, type : type}),
            dataType : 'json',
            timeout : 100000,
            success : function(result) {
                // 1 - item successfully added to the favourite list
                // 2 - item removed from the favourite list
                if (result == 2) {

                    var length = $('.favItem').length;
                    var page = '${page}';

                    if ( length - 1 <= 0) {
                        if (page != '') {
                            location.href='/profile/favourite?page=' + (page - 1);

                        } else {
                            location.href='/profile/favourite';
                        }

                    } else {
                        $('#' + elementIdName).remove();
                        var paginationON = '${paginationON}';

                        if (paginationON != '' && paginationON == 'false') {
                            $('.favItem:last').css('border-bottom', 'none');
                            $('.favItem:last').css('padding-bottom', '0');
                        }
                    }

                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
                location.href = "/authorization";
            },
            done : function(e) {
                console.log("DONE");
            },
            beforeSend : function(e) {
            }

        });

    }

    function removeItemFromStorage(id) {
        var product = parseInt(id);
        var productList = JSON.parse(localStorage.getItem("compareList"));

        if (productList != null) {
            var position = productList.indexOf(product);

            if (position != -1) {
                productList.splice(position, 1);
                localStorage.setItem("compareList", JSON.stringify(productList));
                updateCompare(productList.length);
            }
        }
    }

</script>

</body>
</html>