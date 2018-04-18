<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
    <title>Сравнение товаров</title>

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap" />
    <link href="${bootstrap}" rel="stylesheet" />

    <spring:url value="/resources/font-awesome/css/font-awesome.css" var="awesome" />
    <link href="${awesome}" rel="stylesheet" />

    <spring:url value="/resources/css/MainStyles.css" var="main" />
    <link href="${main}" rel="stylesheet" />

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />

</head>
<body>

<!-- jQuery -->
<spring:url value="/resources/vendor/jquery/jquery.min.js" var="jquery" />
<script src="${jquery}"></script>

<div id="header">
    <jsp:include page="../header.jsp" />
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="/"><i class="fa fa-home"></i></a></li>
                <c:if test="${!empty section}">
                    <li>
                        <a href="/${type}/">${section}</a>
                    </li>
                </c:if>
                <li class="active">Сравнение товаров</li>
            </ol>
        </div>
    </div>
</div>

<div class="container margin_before_footer">

    <div class="row">

        <div class="col-md-12">

            <c:if test="${!empty products && products.size() > 0}">
                <table class="table compare" style="width: 100%; margin-bottom: 1em; margin-top: 0.4em; table-layout: fixed">
                    <tbody>

                    <tr style="border-left: none; border-top: none">
                        <td style="border-left: none; border-top: none"></td>

                        <c:forEach items="${products}" var="product">

                            <td class="text-center" style="position: relative">
                                <i id="del${product.id}" class="fa fa-times delete" style="position: absolute; right: 1em; color: #c6cacd; cursor: pointer"></i>

                                <div style="height: 12em; margin-bottom: 0.5em">
                                    <a href="/${type}/${product.id}">

                                        <c:choose>

                                            <c:when test="${!empty product.mainScreen}">
                                                <img src="${location}${product.mainScreen}" style="max-width: 70%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">
                                            </c:when>

                                            <c:otherwise>
                                                <img src="${noImage}" style="max-width: 70%; max-height: 100%; position:relative; top:50%; transform: translateY(-50%)">
                                            </c:otherwise>

                                        </c:choose>

                                    </a>
                                </div>
                                ${product.name}
                            </td>
                        </c:forEach>

                    </tr>

                    <jsp:include page="compare_${type}.jsp" />

                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty products}">
                <h2 style="margin-top: 0">Список выбранных товаров пуст.</h2>
            </c:if>

        </div>

    </div>

</div>


<div id="footer"> <jsp:include page="../footer.jsp" /> </div>

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
            location.href = "/${type}/";
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