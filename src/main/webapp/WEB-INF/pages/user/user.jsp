<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Профиль ${user.name}</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">

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
    <jsp:include page="../shop/header.jsp" />
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><a href="/"><i class="fa fa-home"></i></a></li>
                <li class="active">Страница пользователя</li>
            </ol>
        </div>
    </div>
</div>

<div class="container">

    <div class="row">

        <c:choose>

            <c:when test="${!empty user}">
                <div class="text-center col-lg-3 col-md-3 col-sm-3 col-xs-12" style="margin-bottom: 1em">

                    <div class="vertical_align" style="position: relative; height: 15em; width: 100%">
                        <c:choose>
                            <c:when test="${!empty user.photo}">
                                <img id="photo" class="img-responsive center-block" src="${location}${user.photo}" style="border-radius: 5px; max-width: 100%; max-height: 100%">
                            </c:when>
                            <c:otherwise>
                                <img id="photo" class="img-responsive center-block" src="${noImage}" style="border-radius: 5px; max-width: 100%; max-height: 100%">
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>

                <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                    <b style="font-size: 20px; padding-left: 3px">${user.username}</b>

                    <div class="btn-group pull-right">

                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                            <i class="fa fa-ban disable_box_shadow dropdown-toggle" style="cursor: pointer; margin-top: 6px" data-toggle = "dropdown"></i>

                            <div class = "dropdown-menu dropdown-menu-right">

                                <ul class="custom_dropdown ban_menu">

                                    <li class="addBan">
                                        <div class="full_width full_height link" style="cursor: pointer" onclick="punishUser('${user.username}', 0)">
                                            <span class="margin_right_3px fa fa-ban"></span> 1 час
                                        </div>
                                    </li>
                                    <li class="divider addBan"></li>

                                    <li class="addBan">
                                        <div class="full_width full_height link" onclick="punishUser('${user.username}', 1)">
                                            <span class="margin_right_3px fa fa-ban"></span> 6 часов
                                        </div>
                                    </li>
                                    <li class="divider addBan"></li>

                                    <li class="addBan">
                                        <div class="full_width full_height link" onclick="punishUser('${user.username}', 2)">
                                            <span class="margin_right_3px fa fa-ban"></span> 1 день
                                        </div>
                                    </li>
                                    <li class="divider addBan"></li>

                                    <li class="addBan">
                                        <div class="full_width full_height link" onclick="punishUser('${user.username}', 3)">
                                            <span class="margin_right_3px fa fa-ban"></span> 1 неделя
                                        </div>
                                    </li>
                                    <li class="divider addBan"></li>

                                    <li class="addBan">
                                        <div class="full_width full_height link" onclick="punishUser('${user.username}', 4)">
                                            <span class="margin_right_3px fa fa-ban"></span> 1 месяц
                                        </div>
                                    </li>
                                    <li class="divider addBan"></li>

                                    <li class="addBan">
                                        <div class="full_width full_height link" onclick="punishUser('${user.username}', 5)">
                                            <span class="margin_right_3px fa fa-ban"></span> 1 год
                                        </div>
                                    </li>
                                    <li class="divider addBan"></li>

                                    <li class="removeBan">
                                        <div class="full_width full_height link" onclick="amnestyUser('${user.username}', 0)">
                                            <span class="margin_right_3px fa fa-ban"></span> Снять бан
                                        </div>
                                    </li>
                                    <li class="divider removeBan"></li>

                                    <li class="disableUser">
                                        <div class="full_width full_height link" onclick="punishUser('${user.username}', 6)">
                                            <span class="margin_right_3px fa fa-lock"></span> Заблокировать
                                        </div>
                                    </li>
                                    <li class="divider disableUser"></li>

                                    <li class="enableUser">
                                        <div class="full_width full_height link" onclick="amnestyUser('${user.username}', 1)">
                                            <span class="margin_right_3px fa fa-unlock-alt"></span> Разблокировать
                                        </div>
                                    </li>
                                    <li class="divider enableUser"></li>

                                </ul>

                            </div>

                        </sec:authorize>
                    </div>

                    <table class="table user_info">
                        <tbody>

                        <c:choose>
                            <c:when test="${user.banned()}">
                                <tr>
                                    <td>Статус :</td>
                                    <td>
                                        <span id="userStatus" class="bad_color">${user.bannedTerm}</span>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td>Статус :</td>
                                    <td>
                                        <span id="userStatus" class="good_color">Активен</span>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>

                        <tr>
                            <td>Группа :</td>
                            <td>${user.group.caption}</td>
                        </tr>

                        <tr>
                            <td>Репутация :</td>
                            <td>
                                <c:choose>
                                    <c:when test="${reputation > 0}">
                                        <span style="color: #6c9007">+${reputation}</span>
                                    </c:when>

                                    <c:when test="${reputation < 0}">
                                        <span style="color: #d53c30">${reputation}</span>
                                    </c:when>

                                    <c:otherwise>
                                        ${reputation}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr>
                            <td>Отзывов :</td>
                            <td>${reviewsCount}</td>
                        </tr>

                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                            <c:if test="${!empty user.surname}">
                                <tr>
                                    <td>Фамилия :</td>
                                    <td>${user.surname}</td>
                                </tr>
                            </c:if>
                        </sec:authorize>

                        <c:if test="${!empty user.name}">
                            <tr>
                                <td>Имя :</td>
                                <td>${user.name}</td>
                            </tr>
                        </c:if>

                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                            <c:if test="${!empty user.patronymic}">
                                <tr>
                                    <td>Отчество :</td>
                                    <td>${user.patronymic}</td>
                                </tr>
                            </c:if>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                            <c:if test="${!empty user.email}">
                                <tr>
                                    <td>E-mail :</td>
                                    <td>${user.email}</td>
                                </tr>
                            </c:if>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                            <c:if test="${!empty user.phone}">
                                <tr>
                                    <td>Телефон :</td>
                                    <td>${user.phone}</td>
                                </tr>
                            </c:if>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ADMIN') or hasRole('MODER')">
                            <c:if test="${!empty user.address}">
                                <tr>
                                    <td>Адрес :</td>
                                    <td>${user.address}</td>
                                </tr>
                            </c:if>
                        </sec:authorize>

                        </tbody>
                    </table>

                </div>
            </c:when>

            <c:otherwise>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <h1 style="margin-top: 0">Указанного пользователя не существует</h1>
                </div>
            </c:otherwise>

        </c:choose>

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

    function updateBanMenu() {

        var state = $('#userStatus').html();

        switch (state) {

            case 'Активен' : {
                $('.addBan').removeClass('hidden');
                $('.removeBan').addClass('hidden');
                $('.disableUser').removeClass('hidden');
                $('.enableUser').addClass('hidden');
                break;
            }
            case 'Заблокирован' : {
                $('.addBan').addClass('hidden');
                $('.removeBan').addClass('hidden');
                $('.disableUser').addClass('hidden');
                $('.enableUser').removeClass('hidden');
                break;
            }
            default : {
                $('.addBan').addClass('hidden');
                $('.removeBan').removeClass('hidden');
                $('.disableUser').removeClass('hidden');
                $('.enableUser').addClass('hidden');
            }
        }

        var lastDivider = $('.ban_menu .divider:not(.hidden)').last();
        lastDivider.addClass('hidden');
    }

    $(document).ready(function () {
        updateBanMenu();
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

    function punishUser(username, mode) {

        $.ajax({
            type : "POST",
            url : "/user/punishment/",
            data : {"username" : username, "mode" : mode},
            timeout : 100000,
            success : function(result) {

                if (result == 'fail') {
                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Ошибка';
                    var content = 'Недостаточно прав для совершения <b>действия</b>.';

                    showMessage(element, bodyHeight, caption, content);

                } else if (result == 'disabled') {
                    $('#userStatus').html("Заблокирован");
                    $('#userStatus').removeClass("good_color");
                    $('#userStatus').addClass("bad_color");
                    updateBanMenu();

                } else {
                    $('#userStatus').html("Забанен до " + result);
                    $('#userStatus').removeClass("good_color");
                    $('#userStatus').addClass("bad_color");
                    updateBanMenu();
                }

            },
            error : function(e) {
                console.log(e)
            },
            done : function(e) {
                console.log("DONE");
            }

        });
    }

    function amnestyUser(username, mode) {
        $.ajax({
            type : "POST",
            url : "/user/amnesty/",
            data : {"username" : username, "mode" : mode},
            timeout : 100000,
            success : function(result) {

                if (result == 'fail') {
                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Ошибка';
                    var content = 'Недостаточно прав для совершения <b>действия</b>.';

                    showMessage(element, bodyHeight, caption, content);

                } else {
                    $('#userStatus').html("Активен");
                    $('#userStatus').removeClass("bad_color");
                    $('#userStatus').addClass("good_color");
                    updateBanMenu();
                }

            },
            error : function(e) {
                console.log(e)
            },
            done : function(e) {
                console.log("DONE");
            }

        });
    }

</script>

</body>
</html>