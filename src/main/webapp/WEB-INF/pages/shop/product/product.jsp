<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>${product.caption} ${product.name}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap" />
    <link href="${bootstrap}" rel="stylesheet" />

    <spring:url value="/resources/font-awesome/css/font-awesome.css" var="awesome" />
    <link href="${awesome}" rel="stylesheet" />

    <spring:url value="/resources/css/MainStyles.css" var="main" />
    <link href="${main}" rel="stylesheet" />

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />

    <sec:authentication var="principal" property="principal" />

</head>
<body style="overflow: visible">

<!-- jQuery -->
<spring:url value="/resources/vendor/jquery/jquery.min.js" var="jquery" />
<script src="${jquery}"></script>

<div id="header">
    <jsp:include page="../header.jsp" />
</div>

<c:choose>

    <c:when test="${!empty product}">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ol class="breadcrumb">
                        <li><a href="/"><i class="fa fa-home"></i></a></li>
                        <li><a href="/${product.type}/">${section}</a></li>
                        <li class="active">${product.name}</li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="container">

            <!-- Portfolio Item Row -->
            <div class="row">

                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" >

                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel" style="margin-bottom: 2.8em">

                        <!-- Indicators -->
                        <ol class="carousel-indicators" style="bottom: -2.5em">

                            <c:forEach items="${product.nonEmptyImages}" var="image" varStatus="loop">

                                <li data-target="#carousel-example-generic" data-slide-to="${loop.index}" ${loop.first ? "class='active'" : ''}></li>

                            </c:forEach>

                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <c:choose>

                                <c:when test="${!empty product.nonEmptyImages}">
                                    <c:forEach items="${product.nonEmptyImages}" var="image" varStatus="loop">

                                        <div class="item ${product_height} ${loop.first ? 'active' : ''}">
                                            <img class="img-responsive center-block" src="${location}${image.link}" style="max-width: 80%; max-height: 100%; position:relative; top: 50%; transform: translateY(-50%);">
                                        </div>

                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <div class="item ${product_height} active">
                                        <img class="img-responsive center-block" src="${noImage}" style="max-width: 80%; max-height: 100%; position:relative; top: 50%; transform: translateY(-50%);">
                                    </div>
                                </c:otherwise>

                            </c:choose>
                        </div>

                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev" style="background-image: none">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next" style="background-image: none">
                            <span class="glyphicon glyphicon-chevron-right"></span>
                        </a>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12" >
                    <h3 class="product_name" style="margin-top : 0">${product.caption} ${product.name}</h3>
                    <p class="product_description">
                            ${product.shortDescription}
                    </p>

                    <p style="margin-top: 12px; margin-bottom: 0">
                        <span class="product_price">
                            <fmt:formatNumber pattern="#" minFractionDigits="2" value="${product.price}" /> руб.
                        </span>
                    </p>

                    <c:choose>
                        <c:when test="${product.inStock}">
                            <p class="inStock_good" style="margin: 3px 0 12px"><i class="fa fa-check"> В наличии</i></p>
                        </c:when>
                        <c:otherwise>
                            <p class="inStock_bad" style="margin: 3px 0 12px"><i class="fa fa-clock-o"> Под заказ</i></p>
                        </c:otherwise>
                    </c:choose>

                    <div class="col-lg-6 col-md-6 col-sm-6" style="padding-left: 0">
                        <div  id="buyProduct"  class="product_button">
                            <div class="icon vertical_align">
                                <i class="fa fa-shopping-cart"></i>
                            </div>

                            <div class="content vertical_align">
                                Купить
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-6" style="padding-left: 0">
                        <div id="shoppingCart" class="product_button">
                            <div class="icon vertical_align">
                                <i class="fa fa-shopping-cart"></i>
                            </div>

                            <div class="content vertical_align">
                                Добавить в корзину
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-6" style="padding-left: 0">
                        <div id="compare" class="product_button">
                            <div class="icon vertical_align">
                                <i class="fa fa-balance-scale"></i>
                            </div>

                            <div class="content vertical_align">
                                Сравнить
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-md-6 col-sm-6" style="padding-left: 0">
                        <div id="like" class="product_button <c:if test="${!empty favourite}">selected</c:if>">
                            <div class="icon vertical_align">
                                <i class="fa fa-heart"></i>
                            </div>

                            <div class="content vertical_align">
                                В избранное
                            </div>
                        </div>
                    </div>


                </div>

            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">

                    <div class="panel-body" style="padding: 0">

                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs">
                            <li id="headerParamsTab" class="active">
                                <a href="#paramsTab" data-toggle="tab">Характеристики</a>
                            </li>
                            <li id="headerReviewsTab">
                                <a href="#reviewsTab" data-toggle="tab"><i class="glyphicon glyphicon-edit"></i> Отзывы</a>
                            </li>

                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0;">
                            <div class="tab-pane fade in active" id="paramsTab">
                                <div class="form-group" style="margin-top: 0; margin-bottom: 0; padding: 0.5em 1em">
                                    <jsp:include page="info_${product.type}.jsp" />
                                </div>
                            </div>
                            <div class="tab-pane fade" id="reviewsTab">
                                <div class="form-group" style="margin-top: 0; margin-bottom: 5px; padding: 0.5em 1em">

                                    <div>
                                        <sec:authorize access="isFullyAuthenticated() or isRememberMe()">

                                            <button class="btn btn-default" onclick="addReview()" data-toggle="modal" data-target="#modalReview"
                                                    style="margin-top: 0.6em">
                                                <i class="fa fa-plus"></i> Добавить отзыв
                                            </button>

                                        </sec:authorize>

                                        <c:if test="${!empty product.reviewsList}">

                                            <hr style="margin-bottom: 10px; margin-top: 15px">

                                            <c:forEach items="${product.reviewsList}" var="review">

                                                <div id="review${review.id}">

                                                    <div style="display: inline-block; width: 100%">

                                                        <a href="/user/${review.username}">
                                                            <img src=${!empty review.user.photo ? location.concat(review.user.photo) : noImage} class="review_icon">
                                                            <b><span class="review_username">${review.username}</span></b>
                                                        </a>

                                                        <span class="review_date" style="margin-right: 4px">${review.postedDateString}</span>

                                                        <sec:authorize access="isFullyAuthenticated() or isRememberMe()">
                                                            <c:if test="${review.username == pageContext.request.userPrincipal.name and !review.timeIsOver()}">
                                                                <i class="fa fa-pencil control_btn" style="font-size: 0.9em" onclick="editReview(${review.id})"
                                                                   data-toggle="modal" data-target="#modalReview"></i>
                                                            </c:if>
                                                        </sec:authorize>

                                                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                                                            <i class="fa fa-times control_btn delReview"></i>
                                                        </sec:authorize>

                                                        <div class="vertical_align pull-right" style="height: 1.2em;">

                                                            <span id="reputation${review.id}" class="reputation" style="margin-right: .2em; color : ${review.reputation >= 0 ? '#6c9007' : '#d53c30'}">${review.reputation}</span>
                                                            <sec:authorize access="isFullyAuthenticated() or isRememberMe()">

                                                                <c:set var="vote" value="${review.voteByUsername( pageContext.request.userPrincipal.name )}" />

                                                                <c:choose>

                                                                    <c:when test="${vote == 0}">
                                                                        <i id="like${review.id}" class="fa fa-thumbs-o-up like_btn" onclick="sendReviewVote(${review.id}, true)" ></i>
                                                                        <i id="dislike${review.id}" class="fa fa-thumbs-o-down like_btn" onclick="sendReviewVote(${review.id}, false)" ></i>
                                                                    </c:when>

                                                                    <c:otherwise>
                                                                        <i class="fa fa-thumbs-o-up ${vote > 0 ? 'like_btn_on' : 'like_btn_off'}"></i>
                                                                        <i class="fa fa-thumbs-o-down ${vote < 0 ? 'like_btn_on' : 'like_btn_off'}"></i>
                                                                    </c:otherwise>

                                                                </c:choose>

                                                            </sec:authorize>

                                                        </div>
                                                    </div>

                                                    <div id="reviewContent${review.id}" class="review_content" style="${review.reputation < 0 ? 'opacity: .7' : ''}" >${review.content}</div>

                                                    <hr style="margin-top: 10px; margin-bottom: 10px">
                                                </div>
                                            </c:forEach>
                                        </c:if>

                                        <c:if test="${empty product.reviewsList}">
                                            <h3 style="margin-top: .5em;">Список отзывов пуст.</h3>
                                        </c:if>

                                    </div>

                                    <!-- Modal -->
                                    <div class="modal fade" id="modalReview" tabindex="-1" role="dialog" aria-labelledby="modalLabelReview" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <div class="modal-header">

                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                                        <i class="fa fa-times" style="font-size: 0.8em"></i>
                                                    </button>

                                                    <h4 class="modal-title" id="modalLabelReview">Отзыв :</h4>
                                                </div>

                                                <form:form id="reviewForm" action="/review/" modelAttribute="newReview" method="post">

                                                    <div class="modal-body center-block" style="width: 100%; padding: 1em">
                                                        <div>
                                                            <form:hidden path="id" id="reviewId" value=""/>
                                                            <form:hidden path="productId" value="${product.id}"/>
                                                            <form:hidden path="type" value="${product.type}"/>
                                                            <form:textarea path="content" id="formContent" maxlength="250" rows="5" cssStyle="width: 100%; resize: none; padding: 3px 6px"/>
                                                        </div>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <form:button id="modalReviewBtn" type="submit" class="btn btn-primary pull-right">Добавить отзыв</form:button>
                                                    </div>

                                                </form:form>

                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.col-lg-12 -->
            </div>

        </div>

        <!-- Modal confirm edit -->
        <div class="modal fade" id="modalConfirmDel" tabindex="-1" role="dialog" aria-labelledby="modalLabelConfirmEdit" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div id="" class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <i class="fa fa-times" style="font-size: 0.8em"></i>
                        </button>

                        <h4 class="modal-title" id="modalLabelConfirmDel">Подтверждение действия :</h4>
                    </div>

                    <div class="modal-body">
                        Вы действительно хотите удалить отзыв ?

                        <div style="display: inline-block; width: 100%; margin-top: 1em">

                            <img id="delReviewImg" src="" class="review_icon">
                            <b><span id="delReviewUsername" class="review_username"></span></b>
                            <span id="delReviewDate" class="review_date" style="margin-right: 4px"></span>
                        </div>

                        <div id="delReviewContent" style="overflow:auto; margin-top: .5em; white-space: pre-line;" ></div>
                    </div>

                    <div class="modal-footer">
                        <button id="delConfirmBtn" class="btn btn-primary">
                            <i class="fa fa-check"></i>
                        </button>

                        <button onclick="$('#modalConfirmDel').find('.close').click();" class="btn btn-default">
                            <i class="fa fa-times"></i>
                        </button>
                    </div>

                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal confirm edit-->


        <!-- Modal -->
        <div class="modal fade" id="singleOrderModal" tabindex="-1" role="dialog" aria-labelledby="singleOrderModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">

                        <div>
                            <button type="button" class="close space_left" onclick="$('#singleOrderModal').modal('toggle')">
                                <i class="fa fa-times" style="font-size: 0.8em"></i>
                            </button>
                        </div>

                        <h4 class="modal-title" id="orderModalLabel">Информация о покупателе :</h4>
                    </div>

                    <div id="orderData" class="modal-body center-block" style="width: 100%; padding : 6px 16px;">

                        <sec:authorize access="isAnonymous()" var="isAnonymous" />

                        <div class="form-group">
                            <label class="control-label">Ф.И.О.</label>
                            <input type="text" class="form-control" autocomplete="off" id="singleOrder_name"
                                   value="${!isAnonymous && !empty principal.name ? principal.name : ''}" />
                        </div>

                        <div class="form-group">
                            <label class="control-label">E-mail *</label>
                            <input type="text" class="form-control" autocomplete="off" id="singleOrder_email"
                                   value="${!isAnonymous && !empty principal.email ? principal.email : ''}" />
                        </div>

                        <div class="form-group">
                            <label class="control-label">Телефон *</label>
                            <input type="text" class="form-control" autocomplete="off" id="singleOrder_phone"
                                   value="${!isAnonymous && !empty principal.phone ? principal.phone : ''}" />
                        </div>

                        <div class="form-group">
                            <label class="control-label">Адрес доставки</label>
                            <input type="text" class="form-control" autocomplete="off" id="singleOrder_address"
                                   value="${!isAnonymous && !empty principal.address ? principal.address : ''}" />
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" onclick="sendSingleOrder()" class="btn btn-primary pull-right" style="margin-left: 0.8em">Отправить заказ</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

    </c:when>

    <c:otherwise>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ol class="breadcrumb">
                        <li><a href="/"><i class="fa fa-home"></i></a></li>
                        <li class="active">Ошибка</li>
                    </ol>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 style="margin-top: 0">Запрашиваемого товара не существует.</h1>
                </div>
            </div>
        </div>
    </c:otherwise>

</c:choose>

<div id="footer"> <jsp:include page="../footer.jsp" /> </div>


<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<script>

    "use strict";

    $(document).ready(function() {

        var url = document.location.toString();
        if (url.match('#')) $('body,html').animate({scrollTop: 0}, 1);

        var productId = ${product.id};
        var productType = '${product.type}';
        var compareList = JSON.parse(localStorage.getItem("compareList"));
        var currentType = localStorage.getItem('type');

        if (compareList != null && currentType == productType) {
            if (compareList.indexOf(productId) != -1) {
                $('#compare').addClass('selected');
            }
        }

        var shoppingCart = JSON.parse(localStorage.getItem('shoppingCart'));

        for (var i = 0; i < shoppingCart.length; i++) {
            var product = shoppingCart[i];
            if (product.id == productId && product.type == productType) {
                $('#shoppingCart').addClass('selected');
                break;
            }
        }

        // autoshow error message
        var error = getUrlParameter('error');
        if (error == 1) {
            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Уведомление';
            var content = 'Вы не можете оставлять <b>отзывы</b>.';

            showMessage(element, bodyHeight, caption, content);
        }

        // handle anchor #review{id}
        if (url.match('#')) {

            $('#headerParamsTab').removeClass('active');
            $('#headerReviewsTab').addClass('active');

            $('#paramsTab').removeClass('in');
            $('#paramsTab').removeClass('active');

            $('#reviewsTab').addClass('in');
            $('#reviewsTab').addClass('active');

            var hash = url.substring(url.indexOf("#")+1);
            var anchorOffset = $('#' + hash).offset();
            if (anchorOffset != undefined) {
                var top = parseInt(anchorOffset.top);
                $('body,html').animate({scrollTop: top}, 800);
            }
        }

    });

    $('.delReview').click(function () {

        var parentDiv = $(this).parent();

        var id = parentDiv.parent().attr('id').replace('review', '');
        var img = parentDiv.find('.review_icon').attr('src');
        var username = parentDiv.find('.review_username').html();
        var date = parentDiv.find('.review_date').html();
        var content = parentDiv.parent().find('.review_content').html();

        $('#delReviewImg').attr('src', img);
        $('#delReviewUsername').html(username);
        $('#delReviewDate').html(date);
        $('#delReviewContent').html(content);

        $('#delConfirmBtn').attr('onclick', 'deleteReview(' + id + ')');
        $('#modalConfirmDel').modal('toggle');

    });

    $('#buyProduct').click(function () {
        $('#singleOrderModal').modal('toggle');
    });

    function sendSingleOrder() {

        var name = $('#singleOrder_name').val();
        var email = $('#singleOrder_email').val();
        var phone = $('#singleOrder_phone').val();
        var address = $('#singleOrder_address').val();

        if (email != '' && phone != '') {
            var items = [];
            var item = new Item(null, null, 1, null, ${product.id}, null, null);

            items.push(item);

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

                        $('#singleOrderModal').modal('toggle');

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

    // product class placed in header.jsp
    $('#shoppingCart').click(function () {

        var id = ${product.id};
        var type = '${product.type}';
        var caption = '${product.caption}';
        var name = '${product.name}';
        var link = '${product.mainScreen}';
        var price = ${product.price};

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
                $('#shoppingCart').addClass('selected');

            } else {
                productList.splice(position, 1);
                $('#shoppingCart').removeClass('selected');
            }
            updateShoppingCart(productList.length);
        }

        localStorage.setItem('shoppingCart', JSON.stringify(productList));

    });

    //reset shopping cart button
    $('#cartResetButton').click(function (){
        $('#shoppingCart').removeClass('selected');
    });

    // reset shopping cart button if current item removed
    function resetCartButton(id, type) {

        var productId = '${product.id}';
        var productType = '${product.type}';

        if (id == productId && type == productType) {
            $('#shoppingCart').removeClass('selected');
        }
    }

    // reset compare button
    $('#compareResetButton').click(function (){
        $('#compare').removeClass('selected');
    });

    $('#compare').click( function(){

        var currentType = localStorage.getItem('type');
        if (currentType != '${product.type}') {
            localStorage.setItem('compareList', JSON.stringify([]));
        }

        localStorage.setItem('type', '${product.type}');

        var product = ${product.id};
        var productList = JSON.parse(localStorage.getItem("compareList"));

        if (productList == null) {

            productList = [product];
            $('#compare').addClass('selected');

        } else {

            var position = productList.indexOf(product);

            if (position == -1) {
                productList.push(product);
                $('#compare').addClass('selected');
            } else {
                productList.splice(position, 1);
                $('#compare').removeClass('selected');

            }
            updateCompare(productList.length);
        }

        localStorage.setItem("compareList", JSON.stringify(productList));

    });


    $('#like').click( function(){

        var id = ${product.id};
        var type = '${product.type}';

        $.ajax({
            type : "POST",
            url : "/favourite/item",
            contentType : "application/json",
            data : JSON.stringify({ id : id, type : type}),
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                switch (result) {
                    case 1 : $('#like').addClass('selected'); break;
                    case 2 : $('#like').removeClass('selected'); break;
                }

            },
            error : function(e) {
                location.href = "/authorization";
            },
            done : function(e) {
                console.log("DONE");
            },
            beforeSend : function(e) {
            }

        });

    });

    function remakeLikeBtn(button, selected) {

        button.removeClass("like_btn");
        button.attr("onclick", '');

        if (selected) {
            button.addClass("like_btn_on");
        } else {
            button.addClass("like_btn_off");
        }

    }

    function sendReviewVote(id, vote) {
        $.ajax({
            type : "POST",
            url : "/reviews/",
            contentType : "application/json",
            data : JSON.stringify({ id : id, vote : vote}),
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                if (result != 0) {
                    var reputationElement = $('#reputation' + id);
                    var value = parseInt(reputationElement.html());

                    value += result;
                    reputationElement.html(value);

                    var likeBtn = $('#like' + id);
                    var dislikeBtn = $('#dislike' + id);

                    remakeLikeBtn(likeBtn, result > 0);
                    remakeLikeBtn(dislikeBtn, result < 0);

                } else {
                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Уведомление';
                    var content = 'Вы не можете <b>проголосовать</b>.';

                    showMessage(element, bodyHeight, caption, content);
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


    function deleteReview(id) {

        $.ajax({
            type : "POST",
            url : "/reviews/delete/",
            data : { id : id},
            timeout : 100000,
            success : function(result) {

                if (result == true) {
                    $('#review' + id).remove();
                    $('#modalConfirmDel').find('.close').click();

                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Уведомление';
                    var content = 'Отзыв успешно <b>удален</b>.';

                    showMessage(element, bodyHeight, caption, content);
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

    function sendEditedReview() {

        function Review(id, productType, productId, content) {
            this.id = id;
            this.productType = productType;
            this.productId = productId;
            this.content = content;
        }

        var reviewId = $('#reviewId').val();
        var productType = $('#productType').val();
        var productId = $('#productId').val();
        var content = $('#formContent').val();

        var review = new Review(reviewId, productType, productId, content);

        $.ajax({
            type : "POST",
            url : "/review/edit/",
            contentType : "application/json",
            data : JSON.stringify(review),
            timeout : 100000,
            success : function(result) {
                if (result == true) {
                    $("#modalReview").find(".close").click();
                    var updatedContent = $('#formContent').val();
                    $('#reviewContent' + reviewId).html(updatedContent);
                } else {
                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Уведомление';
                    var content = 'Нельзя изменить <b>отзыв</b>. Прошло слишком много времени.';
                    $("#modalReview").find(".close").click();

                    showMessage(element, bodyHeight, caption, content);
                }
            },
            error : function(e) {
                console.log("ERROR : ", e);

                var element = '#message';
                var bodyHeight = $('html > body').height();
                var caption = 'Уведомление';
                var content = 'Нельзя изменить <b>отзыв</b>.';
                $("#modalReview").find(".close").click();

                showMessage(element, bodyHeight, caption, content);
            }
        });

    }

    function editReview(id) {

        $('#modalLabelReview').html("Редактирование отзыва :");
        $('#modalReviewBtn').html("Изменить отзыв");
        $('#modalReviewBtn').attr('type', 'button');
        $('#modalReviewBtn').attr('onclick', 'sendEditedReview()');

        var reviewForm = $('#reviewForm');
        reviewForm.attr('action', '/review/edit/');

        var content = $('#reviewContent' + id).html();

        $('#formContent').val(content);
        $('#reviewId').val(id);
    }

    function addReview() {

        $('#modalLabelReview').html("Добавление отзыва :");
        $('#modalReviewBtn').html("Добавить отзыв");
        $('#modalReviewBtn').attr('type', 'submit');
        $('#modalReviewBtn').attr('onclick', '');

        var reviewForm = $('#reviewForm');
        reviewForm.attr('action', '/review/');

        $('#formContent').val('');
        $('#reviewId').val('');

    }


</script>


</body>
</html>