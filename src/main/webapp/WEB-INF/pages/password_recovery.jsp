<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Восстановление пароля</title>

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
    <jsp:include page="shop/header.jsp" />
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="/"><i class="fa fa-home"></i></a></li>
                <li class="active">Восстановление пароля</li>
            </ol>
        </div>
    </div>
</div>

<div class="container">

    <div class="row">

        <c:choose>

            <c:when test="${success}">

                <div class="col-lg-12 col-md-10 col-md-offset-1 col-lg-offset-0">

                    <div class="row">
                        <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 col-xs-offset-0 col-sm-offset-3 col-md-offset-3 col-lg-offset-4">

                            <div class="panel-body" style="padding: 0; margin-bottom: 20px">

                                <div class="row" style="margin-top: 0">

                                    <div class="col-lg-12">

                                        <div class="panel panel-default" style="margin-bottom: 14px">
                                            <div class="panel-body" style="padding-top: 9px; padding-bottom: 8px">

                                                <div class="form-group" style="margin-bottom: 12px;">
                                                    <label class="control-label">Новый пароль</label>
                                                    <input id="password" class="form-control" type="password" placeholder="Новый пароль">
                                                </div>

                                                <div class="form-group" style="margin-bottom: 12px;">
                                                    <label class="control-label">Повторите пароль</label>
                                                    <input id="confirmPassword" class="form-control" type="password" placeholder="Повторите пароль">
                                                </div>

                                                <input id="token" type="hidden" value="${token}">

                                                <button type="button" onclick="sendNewPassword()" class="btn btn-default" style="float: right">
                                                    Сохранить
                                                </button>

                                            </div>
                                        </div>

                                    </div>

                                </div>
                                <!-- /.row (nested) -->

                            </div>
                            <!-- /.panel-body -->

                        </div>

                    </div>
                </div>

            </c:when>

            <c:otherwise>
                <div class="col-lg-12">
                    <h1 style="margin-top: 0">Указанный токен недействителен.</h1>
                </div>
            </c:otherwise>

        </c:choose>

    </div>

</div>


<div id="footer"> <jsp:include page="shop/footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<script>

    "use strict";

    function isEmpty(value) {
        return (value == null || value == '');
    }

    function sendNewPassword() {

        var password1 = $('#password').val();
        var password2 = $('#confirmPassword').val();

        if ( isEmpty(password1) || isEmpty(password2) ) {
            showMSG('Ошибка', 'Необходимо указать <b>пароль</b>.');
            return;
        }
        if (password1 != password2) {
            showMSG('Ошибка', 'Указанные пароли <b>не совпадают</b>.');
            return;
        }
        if (password1.length < 8) {
            showMSG('Ошибка', 'Длина пароля не менее <b>8</b> символов!');
            return;
        }

        var token = $('#token').val();
        $.ajax({
            type : "POST",
            url : "/user/password/change/",
            data : { password : password1, token : token },
            timeout : 100000,
            success : function(result) {

                if (result == true) {
                    location.href = '/';
                } else {
                    showMSG('Ошибка', 'Некорректный <b>пароль</b> или <b>токен</b>.');
                }

            },
            error: function(e) {
                console.log(e);
            }
        });

    }

    function showMSG(caption, content) {
        var element = '#message';
        var bodyHeight = $('html > body').height();
        showMessage(element, bodyHeight, caption, content);
    }

</script>

</body>
</html>