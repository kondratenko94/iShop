<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Настройки</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap" />
    <link href="${bootstrap}" rel="stylesheet" />

    <spring:url value="/resources/font-awesome/css/font-awesome.css" var="awesome" />
    <link href="${awesome}" rel="stylesheet" />

    <spring:url value="/resources/css/MainStyles.css" var="main" />
    <link href="${main}" rel="stylesheet" />

    <spring:url value="/images/" var="location" />

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
                    <li><a href="/profile/reviews"><i class="glyphicon glyphicon-edit"></i> Отзывы</a>
                    </li>
                    <li class="active"><a><i class="fa fa-wrench"></i> Настройки</a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0;">
                    <div class="tab-pane fade in active" id="settings">

                        <div style="width: 100%; display: inline-block; padding: 12px 14px">
                            <form:form action="/profile/settings" modelAttribute="newPassword" method="post">

                                <spring:bind path="oldPassword">
                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                        <label class="control-label">Текущий пароль</label>
                                        <form:input path="oldPassword" type="password" class="form-control"
                                                    id="oldPassword" placeholder="Пароль"
                                                    data-container="body" data-toggle="popover" data-placement="top" data-content=""/>
                                        <form:errors path="oldPassword" class="control-label" />
                                    </div>
                                </spring:bind>

                                <spring:bind path="password">
                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                        <label class="control-label">Новый пароль</label>
                                        <form:input path="password" type="password" class="form-control"
                                                    id="password" placeholder="Пароль"
                                                    data-container="body" data-toggle="popover" data-placement="top" data-content=""/>
                                        <form:errors path="password" class="control-label" />
                                    </div>
                                </spring:bind>

                                <spring:bind path="confirmPassword">
                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                        <label class="control-label">Подтверждение пароля</label>
                                        <form:input path="confirmPassword" type="password" class="form-control"
                                                    id="confirmPassword" placeholder="Подтвердите пароль"
                                                    data-container="body" data-toggle="popover" data-placement="top" data-content="" />
                                        <form:errors path="confirmPassword" class="control-label" />
                                    </div>
                                </spring:bind>

                                <form:button type="submit" class="btn btn-default pull-right"><i class="fa fa-check"></i> Отправить</form:button>

                            </form:form>
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