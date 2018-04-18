<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Отзывы пользователя</title>

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
                    <li><a href="/profile/favourite"><i class="glyphicon glyphicon-heart"></i> Избранное</a>
                    </li>
                    <li class="active"><a><i class="glyphicon glyphicon-edit"></i> Отзывы</a>
                    </li>
                    <li><a href="/profile/settings"><i class="fa fa-wrench"></i> Настройки</a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content" style="padding-top: 0; margin-top: 0;">
                    <div class="tab-pane fade in active">

                        <div style="padding: 10px 0 4px 0">

                            <c:set var="paginationON" value="${!empty pagesCount && pagesCount > 1}" scope="page"/>

                            <c:choose>

                                <c:when test="${!empty reviewsList}">

                                    <c:forEach items="${reviewsList}" var="review" varStatus="loop">

                                        <div id="review${review.id}"
                                             style="margin : 0px 12px 10px 12px"
                                             class="reviewBlock"
                                             onclick="location.href='/${review.product.type}/${review.product.id}#review${review.id}' ">

                                            <div style="display: inline-block; width: 100%">

                                                <img src="${!empty review.user.photo ? location.concat(review.user.photo) : noImage}" class="review_icon">
                                                <b><span class="review_username">${review.username}</span></b>
                                                <span class="review_date" style="margin-right: 4px">${review.postedDateString}</span>

                                                <div class="vertical_align pull-right" style="height: 1.2em;">

                                                    <span id="reputation${review.id}" class="reputation" style="margin-right: .2em; color : ${review.reputation >= 0 ? '#6c9007' : '#d53c30'}">${review.reputation}</span>
                                                </div>
                                            </div>

                                            <div id="reviewContent${review.id}" class="review_content" style="${review.reputation < 0 ? 'opacity: .7' : ''}" >${review.content}</div>

                                        </div>

                                        <c:if test="${paginationON || !loop.last}">
                                            <hr style="margin-top: 0; margin-bottom: 10px">
                                        </c:if>

                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <h3 style="margin-top: 4px; margin-bottom: 10px">Список отзывов пуст.</h3>
                                </c:otherwise>

                            </c:choose>

                            <c:if test="${paginationON}">
                                <div class="row" style="margin-bottom: 4px">
                                    <div class="col-lg-12 col-xs-12">

                                        <div class="custom_pagination pull-right" style="margin-top: 6px; margin-bottom: 4px">
                                            <c:if test="${!empty pagesCount && pagesCount > 1}">

                                                <c:if test="${page - 2 > 0}">
                                                    <a class="page" href="/profile/reviews">1</a>

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
                                                            <a class="page" href="/profile/reviews?page=${i}">${i}</a>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </c:forEach>

                                                <c:if test="${pagesCount - page > 1}">

                                                    <c:if test="${pagesCount - page > 2}">
                                                        <span class="empty" >...</span>
                                                    </c:if>
                                                    <a class="page" href="/profile/reviews?page=${pagesCount}">${pagesCount}</a>
                                                </c:if>

                                            </c:if>
                                        </div>

                                    </div>
                                </div>
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

<script>

    "use strict";

    // Listen for clicks on table originating from .delete element(s)
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