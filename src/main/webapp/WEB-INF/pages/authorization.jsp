<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Авторизация</title>

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
                <li class="active">Авторизация</li>
            </ol>
        </div>
    </div>
</div>

<div class="container">

    <div class="row">

        <div class="col-lg-12 col-md-10 col-md-offset-1 col-lg-offset-0">

            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 col-xs-offset-0 col-sm-offset-3 col-md-offset-3 col-lg-offset-4">

                    <div class="panel-body" style="padding: 0; margin-bottom: 20px">

                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs">
                            <li class="${mode eq 'auth' ? 'active' : ''}" onclick="deleteAllPopovers()">
                                <a href="#auth" data-toggle="tab"><i class="fa fa-user"></i> Авторизация</a>
                            </li>
                            <li class="${mode eq 'reg' ? 'active' : ''}">
                                <a href="#register" data-toggle="tab"><i class="fa fa-user-plus"></i> Регистрация</a>
                            </li>

                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0;">
                            <div class="tab-pane fade ${mode eq 'auth' ? 'in active' : ''}" id="auth">
                                <div class="form-group" style="margin-top: 0; margin-bottom: 0; padding: 0.5em 1em">

                                    <div class="row" style="margin-top: 0">

                                        <div class="col-lg-12">

                                            <form name='frm' action='/login' method="post">

                                                <div class="form-group" style="margin-bottom: 12px;">
                                                    <label class="control-label">Логин</label>
                                                    <input class="form-control" type="text" name="username" placeholder="Логин" value="<c:if test="${!empty param.login_error}">${param.login_error}</c:if>">
                                                </div>

                                                <div class="form-group" style="margin-bottom: 12px;">
                                                    <label class="control-label">Пароль</label>
                                                    <span onclick="$('#passwordRecoveryModal').modal('toggle');" style="margin-top : 4px; font-size: 12px; color: #666; float: right; cursor: pointer">Забыли пароль?</span>
                                                    <input class="form-control" type="password" name="password" placeholder="Пароль" value="">
                                                </div>

                                                <input class="btn btn-default pull-right" type="hidden" name="<c:out value="${_csrf.parameterName}"/>"
                                                       value="<c:out value="${_csrf.token}"/>"/>

                                                <div class="row" style="margin-bottom: .3em">
                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                                        <div class="vertical_align" style="height: 20px; width: 100px">
                                                            <div style="float: left"><input type='checkbox' name='remember-me-parameter'></div>
                                                            <div class="center-block" style="float: left; margin-left: 4px">Запомнить</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                                        <button type="submit" class="btn btn-default pull-right">Войти</button>
                                                    </div>
                                                </div>

                                                <c:if test="${not empty param.login_error}">
                                                    <div style="display: inline-block; margin-top: .5em; margin-bottom: .5em">

                                                        <c:choose>
                                                            <c:when test="${SPRING_SECURITY_LAST_EXCEPTION.message == 'Bad credentials'}">
                                                                <span><i class="fa fa-exclamation" style="margin-right: 4px"></i>Неверное имя пользователя или пароль</span>
                                                            </c:when>

                                                            <c:when test="${SPRING_SECURITY_LAST_EXCEPTION.message == 'User is disabled'}">
                                                                <span><i class="fa fa-times" style="margin-right: 4px"></i>Учетная запись заблокирована</span>
                                                            </c:when>
                                                        </c:choose>


                                                    </div>
                                                </c:if>

                                            </form>

                                        </div>

                                    </div>
                                    <!-- /.row (nested) -->

                                </div>
                            </div>

                            <div class="tab-pane fade ${mode eq 'reg' ? 'in active' : ''}" id="register">
                                <div class="form-group" style="margin-top: 0; margin-bottom: 5px; padding: 0.5em 1em">

                                    <div class="row" style="margin-top: 0">

                                        <div class="col-lg-12">

                                            <form:form id="registration" action="/registration/" modelAttribute="user" method="post" >

                                                <spring:bind path="username">
                                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Логин *</label>
                                                        <form:input path="username" type="text" class="form-control"
                                                                    id="username" placeholder="Логин"
                                                                    data-container="body" data-toggle="popover" data-placement="right" data-content=""/>
                                                        <form:errors path="username" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="surname">
                                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Фамилия</label>
                                                        <form:input path="surname" type="text" class="form-control"
                                                                    id="surname" placeholder="Фамилия"/>
                                                        <form:errors path="surname" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="name">
                                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Имя</label>
                                                        <form:input path="name" type="text" class="form-control"
                                                                    id="name" placeholder="Имя"/>
                                                        <form:errors path="name" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="patronymic">
                                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Отчество</label>
                                                        <form:input path="patronymic" type="text" class="form-control"
                                                                    id="patronymic" placeholder="Отчество"/>
                                                        <form:errors path="patronymic" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="phone">
                                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Телефон</label>
                                                        <form:input path="phone" type="text" class="form-control"
                                                                    id="phone" placeholder="Номер телефона"/>
                                                        <form:errors path="phone" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="email">
                                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">E-mail *</label>
                                                        <form:input path="email" type="text" class="form-control"
                                                                    id="email" placeholder="E-mail адрес"
                                                                    data-container="body" data-toggle="popover" data-placement="right" data-content=""/>
                                                        <form:errors path="email" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="address">
                                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Адрес</label>
                                                        <form:input path="address" type="text" class="form-control"
                                                                    id="address" placeholder="Адрес"/>
                                                        <form:errors path="address" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="password">
                                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Пароль *</label>
                                                        <form:input path="password" type="password" class="form-control"
                                                                    id="password" placeholder="Пароль"
                                                                    data-container="body" data-toggle="popover" data-placement="right" data-content=""/>
                                                        <form:errors path="password" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <spring:bind path="confirmPassword">
                                                    <div class="form-group tooltip-demo ${status.error ? 'has-error' : ''}">
                                                        <label class="control-label">Подтверждение пароля *</label>
                                                        <form:input path="confirmPassword" type="password" class="form-control"
                                                                    id="confirmPassword" placeholder="Подтвердите пароль"
                                                                    data-container="body" data-toggle="popover" data-placement="right" data-content="" />
                                                        <form:errors path="confirmPassword" class="control-label" />
                                                    </div>
                                                </spring:bind>

                                                <div class="tooltip-demo">
                                                    <form:button id="reg_btn" type="submit" class="btn btn-default pull-right"
                                                                 data-container="body" data-toggle="popover" data-placement="right">
                                                        <i class="fa fa-user-plus"></i> Отправить
                                                    </form:button>
                                                </div>

                                            </form:form>
                                        </div>

                                    </div>
                                    <!-- /.row (nested) -->

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.panel-body -->

                </div>

            </div>
        </div>

    </div>

</div>

<!-- Modal -->
<div class="modal fade text-left" id="passwordRecoveryModal" tabindex="-1" role="dialog" aria-labelledby="myPasswordRecoveryModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                <div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times" style="font-size: 0.8em"></i>
                    </button>
                </div>

                <h4 class="modal-title" id="myPasswordRecoveryModal">Восстановление пароля :</h4>
            </div>

            <div class="modal-body center-block" style="width: 100%; padding : 6px 16px">

                <label class="control-label">Укажите ваш E-mail</label>
                <input id="targetEmail" class="form-control space_bottom" style="margin-bottom: 7px">
            </div>

            <div class="modal-footer">
                <button type="button" onclick="passwordRecovery()" class="btn btn-primary">
                    <i class="fa fa-check"> Восстановить</i>
                </button>

                <button type="button" onclick="$('#passwordRecoveryModal').modal('toggle');" class="btn btn-default">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div id="footer"> <jsp:include page="shop/footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<!-- Page-Level Demo Scripts - Notifications - Use for reference -->
<script>
    // popover demo
    $("[data-toggle=popover]")
            .popover({
                trigger: 'manual'
            });
</script>

<script>

    "use strict";

    $("#registration").submit(function(e){
        var sendBtn = $('#reg_btn');

        var errors = $('#registration').find('.has-warning').length;
        if (errors > 0) {
            setWarningPopover(sendBtn, 'Форма содержит некорректные данные.');
            e.preventDefault();

            setTimeout(function (){
                removeWarningPopover(sendBtn);
            }, 2000);

            return;
        }

        var login = $('#username').val();
        var email = $('#email').val();
        var password = $('#password').val();
        var confirmPassword = $('#confirmPassword').val();

        if (isEmpty(login) || isEmpty(email) || isEmpty(password) || isEmpty(confirmPassword)) {
            setWarningPopover(sendBtn, 'Заполните все обязательные поля.');
            setTimeout(function (){
                removeWarningPopover(sendBtn);
            }, 2000);

            e.preventDefault();

        }

    });

    function setWarningPopover(element, message) {
        element.parent().addClass('has-warning');
        element.attr('data-content', message);
        element.popover('show');
    }

    function removeWarningPopover(element) {
        element.parent().removeClass('has-warning');
        element.attr('data-content', '');
        element.popover('hide');
    }

    function deleteAllPopovers() {
        $('.popover-content').each(function (){
            $(this).parent().popover('hide');
        });
    }

    function isEmpty(value) {

        return (value == null || value == '');
    }

    $('#username').change(function () {
        var element = $(this);
        var username = element.val();

        if ((/^[A-Za-z_0-9]+$/).test(username) || isEmpty(username)) {
            removeWarningPopover(element);
        } else {
            setWarningPopover(element, 'Поле содержит недопустимые символы');
        }
    });

    $('#email').change(function () {
        var element = $(this);
        var email = element.val();
        if ((/^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$/).test(email) || isEmpty(email)) {
            removeWarningPopover(element);
        } else {
            setWarningPopover(element, 'E-mail адрес задан некорректно');
        }
    });

    function checkPasswords() {
        var password1 = $('#password');
        var password2 = $('#confirmPassword');

        var warning1 = false;
        var warning2 = false;

        var popover1 = '';
        var popover2 = '';

        if (password1.val() != '' && password2.val() != '') {
            if (password1.val() != password2.val()) {
                warning2 = true;
                popover2 = 'Указанные пароли не совпадают';
            }
        }

        if (password1.val() != '') {

            var value1 = password1.val();

            if (value1.length < 8) {
                warning1 = true;
                if (popover1 == '') popover1 = 'Длина пароля не менее 8 символов';
            } else if (value1.length > 30) {
                warning1 = true;
                if (popover1 == '') popover1 = 'Длина пароля не более 30 символов';
            } else if (value1.indexOf(" ") != -1) {
                warning1 = true;
                if (popover1 == '') popover1 = 'Пароль не должен содержать пробелов';
            }
        }

        if (password2.val() != '') {

            var value2 = password2.val();

            if (value2.length < 8) {
                warning1 = true;
                if (popover2 == '') popover2 = 'Длина пароля не менее 8 символов';
            } else if (value2.length > 30) {
                warning1 = true;
                if (popover2 == '') popover2 = 'Длина пароля не более 30 символов';
            } else if (value2.indexOf(" ") != -1) {
                warning1 = true;
                if (popover2 == '') popover2 = 'Пароль не должен содержать пробелов';
            }
        }

        if (warning1 == true) {
            setWarningPopover(password1, popover1);
        } else {
            removeWarningPopover(password1);
        }

        if (warning2 == true) {
            setWarningPopover(password2, popover2);
        } else {
            removeWarningPopover(password2);
        }
    }

    $('#password').change( function () {
        checkPasswords();
    });

    $('#confirmPassword').change(function () {
        checkPasswords();
    });

    function passwordRecovery() {
        var email = $('#targetEmail').val();

        if ( !(/^[_A-Za-z0-9-\+]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})$/).test(email) || isEmpty(email)) {
            showMSG('Ошибка', 'Вы указали <b>некорректный e-mail</b>.');
            return;

        } else {

            $.ajax({
                type : "POST",
                url : "/user/password/reset/",
                data : { email : email },
                timeout : 100000,
                success : function(result) {

                    console.log(result);

                    if (result == true) {
                        $('#passwordRecoveryModal').modal('toggle'); //hide modal

                        showMSG('Уведомление', 'Заявка подана. Проверьте вашу <b>почту</b>.');

                    } else {
                        showMSG('Ошибка', 'Пользователь с указанным e-mail адресом <b>не найден</b>.');
                    }

                },
                error: function(e) {
                    console.log(e);
                }
            });
        }
    }

    function showMSG(caption, content) {
        var element = '#message';
        var bodyHeight = $('html > body').height();
        showMessage(element, bodyHeight, caption, content);
    }

</script>

</body>
</html>