<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>${section}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap" />
    <link href="${bootstrap}" rel="stylesheet" />

    <spring:url value="/resources/font-awesome/css/font-awesome.css" var="awesome" />
    <link href="${awesome}" rel="stylesheet" />

    <spring:url value="/resources/css/MainStyles.css" var="main" />
    <link href="${main}" rel="stylesheet" />

    <spring:url value="/resources/css/MainFilterPanel.css" var="elements" />
    <link href="${elements}" rel="stylesheet" />

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />

</head>
<body>

<!-- jQuery -->
<spring:url value="/resources/vendor/jquery/jquery.min.js" var="jquery" />
<script src="${jquery}"></script>

<div id="header">
    <jsp:include page="header.jsp" />
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="/"><i class="fa fa-home"></i></a></li>
                <li class="active">${section}</li>
            </ol>
        </div>
    </div>
</div>


<div class="container">

    <hr class="hr_no_margin">

    <div class="row grid-divider">

        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 filter_menu center-block" style="margin-bottom: 10px; z-index: 100">

            <span class="filter_toggle full_width text-center center-block" data-toggle="collapse" data-target=".my_nav_collapse.navbar-collapse">
                <i class="fa fa-caret-down"></i>
            </span>

            <div class="row navbar-collapse my_nav_collapse collapse" style="padding-left: 15px; padding-right: 15px; margin-top: 15px">
                <form:form id="filterForm" action="/${type}/" commandName="productFilter" method="get">

                        <input type="hidden" id="sortMode" name="sort" value="${sortMode}">

                        <c:if test="${!empty filtersPanel}">

                            <c:forEach items="${filtersPanel}" var="panel" varStatus="i">

                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 custom_option">

                                    <div style="margin-bottom: 0.5em;">

                                        <c:set var="isActive" value="${ i.index < 3 || productFilter.isPanelCollapsed(panel.title) }"/>

                                        <div style="padding-bottom: 5px; line-height: 20px; height: 22px">
                                            <a class="accordion-toggle criteria_header ${ isActive == true ? '' : 'collapsed'}" data-toggle="collapse" href="#collapse${i.index}" style="position: relative">
                                                <span style='width: 85%; float: left; font-family: "PT Sans Narrow", sans-serif; font-size: 18px'>${panel.title}</span>
                                                <span style="width: 15%; float: left"></span>
                                            </a>
                                        </div>

                                        <div id="collapse${i.index}" class="panel-collapse collapse ${ isActive == true ? 'in' : ''}" style="clear: both">
                                            <div class="panel-body" style="padding: 0; padding-top: 3px">
                                                <c:choose>
                                                    <c:when test="${panel.type eq 'RANGE'}">
                                                        <div class="">
                                                            <form:input path="${panel.pathStart}" autocomplete="off" type = "text"
                                                                        class = "form-control hide_disabled left_input ${fieldTypeDeterminer.getFieldType(productFilter, panel.pathStart)}"
                                                                        placeholder="От" />
                                                            <form:input path="${panel.pathEnd}" autocomplete="off" type = "text"
                                                                        class = "form-control hide_disabled right_input ${fieldTypeDeterminer.getFieldType(productFilter, panel.pathStart)}"
                                                                        placeholder="До" />
                                                        </div>
                                                    </c:when>

                                                    <c:when test="${panel.type eq 'RADIO'}">
                                                        <div class = "input-group full_width">

                                                            <div class="btn-group btn-group-lg full_width">

                                                                <div class="btn-group full_width" data-toggle="buttons">

                                                                    <form:select path="${panel.pathStart}" class="form-control custom_combo hide_disabled">
                                                                        <option ${empty criteria.isRadioSelected(panel.pathStart) ? 'selected' : ''}
                                                                                value="">Не важно</option>
                                                                        <option ${criteria.isRadioSelected(panel.pathStart) == true ? 'selected' : ''}
                                                                                value="true">Да</option>
                                                                        <option ${criteria.isRadioSelected(panel.pathStart) == false ? 'selected' : ''}
                                                                                value="false">Нет</option>
                                                                    </form:select>

                                                                </div>

                                                            </div>

                                                        </div>
                                                    </c:when>

                                                    <c:when test="${panel.type eq 'LIST'}">

                                                        <div style="color: #555; padding-top: 0; padding-bottom: 0">

                                                            <c:if test="${!empty panel.checkBoxList}">

                                                                <c:forEach items="${panel.checkBoxList}" var="value" varStatus="n">
                                                                    <div class="checkbox" style="margin-top: 0.4em; margin-bottom: 0">
                                                                        <input type="checkbox" id="${panel.pathStart.concat(n.index)}" name="${panel.pathStart}" class="css-checkbox lrg" value="${value}"
                                                                            ${criteria.isItemChecked(panel.pathStart, value) == true ? 'checked' : ''} />
                                                                        <label for="${panel.pathStart.concat(n.index)}" class="css-label lrg klaus">${value}</label>
                                                                    </div>
                                                                </c:forEach>

                                                            </c:if>

                                                        </div>

                                                    </c:when>

                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </c:forEach>

                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0; padding-right: 4px">
                                <form:button class="btn btn-default criteria_button">Подбор</form:button>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 4px ;padding-right: 0">
                                <form:button type="button" class="btn btn-default criteria_button"
                                             onclick="location.href='/${type}/${sortMode != 0 ? ('?sort=').concat(sortMode) : '' }'"
                                        >Сброс</form:button>
                            </div>

                        </c:if>

                    </form:form>
            </div>

        </div>

        <div class="col-md-10">

            <div class="row margin_top_default">

                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                    <div class="col-lg-8 col-md-7 col-sm-7 col-xs-12" style="padding: 0 0">
                        <div class="btn-toolbar pull-right" style="padding-top: 2px">

                            <div class="btn-group btn-group-lg xs_no_margin">
                                <a id="tabModeTable" class="tab_mode ${tabMode eq 'table' ? 'active' : ''}">
                                    <i class="glyphicon glyphicon-th fa-2x"></i>
                                </a>
                                <a id="tabModeRow" class="tab_mode ${tabMode eq 'row' ? 'active' : ''}">
                                    <i class="glyphicon glyphicon-th-list fa-2x"></i>
                                </a>
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-4 col-md-5 col-sm-5 col-xs-12 pull-right" style="padding: 0">

                        <select id="sort" class="form-control" style="border-color: rgb(228,228,228)">

                            <option <c:if test="${sortMode == 0}">selected</c:if>
                                    value="0">Сортировать по добавлению (вверх)</option>

                            <option <c:if test="${sortMode == 2}">selected</c:if>
                                    value="2">Сортировать по названию (вверх)</option>

                            <option <c:if test="${sortMode == 4}">selected</c:if>
                                    value="4">Сортировать по цене (вверх)</option>

                            <option <c:if test="${sortMode == 1}">selected</c:if>
                                    value="1">Сортировать по добавлению (вниз)</option>

                            <option <c:if test="${sortMode == 3}">selected</c:if>
                                    value="3">Сортировать по названию (вниз)</option>

                            <option <c:if test="${sortMode == 5}">selected</c:if>
                                    value="5">Сортировать по цене (вниз)</option>
                        </select>
                    </div>

                </div>

            </div>

            <c:choose>

                <c:when test="${!empty productsList}">
                    <c:choose>
                        <c:when test="${tabMode eq 'row'}">

                            <c:forEach items="${productsList}" var="product">

                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tabRow_product" style="border-top: 1px solid #eee; float : left">

                                    <div class="row">

                                        <div class="col-lg-2 col-md-2 col-sm-2 center-block">
                                            <div class="text-center ${height}">
                                                <a href="/${type}/${product.id}" >
                                                    <c:choose>
                                                        <c:when test="${!empty product.mainScreen}">
                                                            <img src="${location}${product.mainScreen}"
                                                                 style="max-width: 100%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">                                                </c:when>
                                                        <c:otherwise>
                                                            <img src="${noImage}"
                                                                 style="max-width: 100%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </div>
                                        </div>

                                        <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 xs_center">

                                            <div>
                                                <a href="/${type}/${product.id}"><b class="tabRow_name xs_center">${product.truncatedName}</b></a>
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
                                                         class="btn_shell adapt_width compare_btn"
                                                         onclick="addToCompare(${product.id}, '${product.type}')">

                                                        <div class="btn_icon vertical_align">
                                                            <i class="fa fa-balance-scale"></i>
                                                        </div>

                                                        <div class="btn_content vertical_align">
                                                            Сравнить
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-3 col-sm-5 no_side_padding">

                                                    <div id="favourite${product.id}"
                                                         class="btn_shell ${product.favourite ? 'pressed' : ''} adapt_width"
                                                         onclick="addToFavourite(${product.id})">

                                                        <div class="btn_icon vertical_align">
                                                            <i class="fa fa-heart"></i>
                                                        </div>

                                                        <div class="btn_content vertical_align" >
                                                            В избранное
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

                        </c:when>

                        <c:otherwise>

                            <c:forEach items="${productsList}" var="product">

                                <div class="col-xxs xxs_no_left_padding col-xs-6 col-sm-4 col-md-4 col-lg-3">
                                    <div class="wrapper center-block text-center">

                                        <div class="center-block">
                                            <div class="itemPreview">

                                                <div class="itemScreen ${height} ${maxWidth}">
                                                    <a href="/${type}/${product.id}">
                                                        <c:choose>
                                                            <c:when test="${!empty product.mainScreen}">
                                                                <img src="${location}${product.mainScreen}"
                                                                     style="max-width: 100%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">                                                </c:when>
                                                            <c:otherwise>

                                                                <img src="${noImage}"
                                                                     style="max-width: 100%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">

                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </div>

                                                <div class="itemButtons btn-group-vertical">
                                                    <a id="cart${product.id}${product.type}" class="${product.type} cart-product btn btn-default"
                                                       onclick="addToCart(${product.id}, '${product.type}', '${product.caption}', '${product.name}', '${product.mainScreen}', ${product.price})">
                                                        <i class="fa fa-shopping-cart"></i>
                                                    </a>
                                                    <a id="compare${product.id}${product.type}" class="btn btn-default compare_btn" onclick="addToCompare(${product.id}, '${product.type}')"><i class="fa fa-bar-chart"></i> </a>
                                                    <a id="favourite${product.id}" class="btn btn-default <c:if test="${product.favourite}">pressed</c:if>" onclick="addToFavourite(${product.id})"><i class="fa fa-heart"></i> </a>
                                                </div>

                                            </div>

                                            <h3 class="center-block text-center description clear_both" style='font-family: "PT Sans Narrow", sans-serif ;font-size: 26px; line-height: 28px; max-width: 88%'>
                                                <a href="/${type}/${product.id}">${product.truncatedName}</a>
                                            </h3>

                                            <p class="text-center" style='margin-top: 3px; font-size: 16px; font-family: "PT Sans Narrow", sans-serif'><fmt:formatNumber pattern="#" minFractionDigits="2" value="${product.price}" /> руб.</p>
                                        </div>

                                    </div>
                                </div>

                            </c:forEach>

                        </c:otherwise>

                    </c:choose>

                    <div class="row">
                        <div class="col-lg-12 col-xs-12">

                            <div class="custom_pagination pull-right" style="margin-top: 1em; margin-bottom: 0">
                                <c:if test="${!empty pagesCount && pagesCount > 1}">

                                    <c:if test="${page - 2 > 0}">
                                        <span class="page" onclick="openPage(1)">1</span>

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
                                                <span class="page" onclick="openPage(${i})">${i}</span>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>

                                    <c:if test="${pagesCount - page > 1}">

                                        <c:if test="${pagesCount - page > 2}">
                                            <span class="empty" >...</span>
                                        </c:if>
                                        <span class="page" onclick="openPage(${pagesCount})">${pagesCount}</span>
                                    </c:if>

                                </c:if>
                            </div>

                        </div>
                    </div>

                    <div class="clear_both" style="margin-bottom: 10px"></div>

                </c:when>

                <c:otherwise>
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <h2 style='border-top: 1px solid #eee; padding-top: 10px; font-size: 18px; line-height: 30px'>Товаров не найдено. Попробуйте изменить критерии поиска.</h2>
                    </div>
                </c:otherwise>

            </c:choose>

        </div>
    </div>

</div>

<div id="footer"> <jsp:include page="footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<!-- Cookie -->
<spring:url value="/resources/js/cookieManager.js" var="cookjs" />
<script src="${cookjs}"></script>

<!-- shoppingCart add/onload script -->
<spring:url value="/resources/js/shop/shoppingCart.js" var="shoppingCartjs" />
<script src="${shoppingCartjs}"></script>

<!-- compare add/onload script -->
<spring:url value="/resources/js/shop/compare.js" var="comparejs" />
<script src="${comparejs}"></script>

<!-- Input validation -->
<spring:url value="/resources/js/input_validator.js" var="input_validator" />
<script src="${input_validator}"></script>

<script>

    "use strict";

    // change sort mode
    $('#sort').change(function () {

        var mode = $(this).find(":selected").val();
        $('#sortMode').val(mode);

        $('#filterForm').submit();

    });

    //
    function openPage(page) {
        var input = $("<input>")
                .attr("type", "hidden")
                .attr("name", "page").val(page);
        $('#filterForm').append($(input));

        $('#filterForm').submit();
    }

    // delete empty fields from filter form
    $('#filterForm').submit(function () {
        $('form#filterForm :input').each(function () {
            if ($(this).val() == '') {
                $(this).attr('disabled', 'disabled');
            }
        });
    });

    // reset all selected to compare buttons
    $('#compareResetButton').click(function (){
        $(document).find(".compare_btn").each (function() {
            $(this).removeClass("pressed");
        });
    });

    function addToFavourite(id) {

        var type = '${type}';

        $.ajax({
            type : "POST",
            url : "/favourite/item",
            contentType : "application/json",
            data : JSON.stringify({ id : id, type : type}),
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                switch (result) {
                    case 1 : $('#favourite' + id).addClass('pressed'); break;
                    case 2 : $('#favourite' + id).removeClass('pressed'); break;
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

    function updateCompare(length) {
        $('#compareCount').html(length);
    }

    // display type of products (row || table)
    $('.tab_mode').click(function () {
        var tabMode = $(this).attr('id');

        if (tabMode == 'tabModeTable') {
            $('#tabModeTable').addClass('active');
            $('#tabModeRow').removeClass('active');
            createCookie('tabMode', 'table', 14);

        } else if (tabMode == 'tabModeRow') {
            $('#tabModeRow').addClass('active');
            $('#tabModeTable').removeClass('active');
            createCookie('tabMode', 'row', 14);
        }

        $('#filterForm').submit();
    });

</script>

</body>
</html>
