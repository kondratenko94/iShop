<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
    <title>Поиск товаров</title>

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
    <jsp:include page="header.jsp" />
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="/"><i class="fa fa-home"></i></a></li>
                <li class="active">Поиск товаров</li>
            </ol>
        </div>
    </div>
</div>

<div class="container">

    <div class="row">
        <div class="col-lg-12">

            <c:if test="${!empty productsList}">

                <c:set var="paginationON" value="${!empty pagesCount && pagesCount > 1}" scope="page"/>

                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                        <div style="border-bottom: 1px solid #eee; padding-bottom: 10px">
                            <span style="font-size: 12px;">Найдено : ${totalCount} товаров по запросу "<b>${input}</b>"</span>
                        </div>

                    </div>
                </div>

                <c:forEach items="${productsList}" var="product" varStatus="loop">

                    <div id="item${product.id}${product.type}" class="col-lg-12 col-md-12 col-sm-12 col-xs-12"
                         style="float : left; margin-top: 1em; ${paginationON || !loop.last ? ' border-bottom: 1px solid #eee; padding-bottom: 1em' : ''}">

                        <div class="row">

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
                    <div class="row" style="margin-bottom: 10px">
                        <div class="col-lg-12 col-xs-12">

                            <div class="custom_pagination pull-right" style="margin-top: 1em; margin-bottom: 0">
                                <c:if test="${page - 2 > 0}">
                                    <a class="page" href="/search/?input=${input}">1</a>

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
                                            <a class="page" href="/search/?input=${input}&page=${i}">${i}</a>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>

                                <c:if test="${pagesCount - page > 1}">

                                    <c:if test="${pagesCount - page > 2}">
                                        <span class="empty" >...</span>
                                    </c:if>
                                    <a class="page" href="/search/?input=${input}&page=${pagesCount}">${pagesCount}</a>
                                </c:if>
                            </div>

                        </div>
                    </div>
                </c:if>

            </c:if>

            <c:if test="${empty productsList}">
                <h3 style="margin-top: 10px">По запросу "${input}" ничего не найдено.</h3>
            </c:if>

        </div>
        <!-- /.col-lg-12 -->
    </div>

</div>

<div id="footer"> <jsp:include page="footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

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

</script>

</body>
</html>