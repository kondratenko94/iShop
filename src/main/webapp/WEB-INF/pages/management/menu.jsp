<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Message CSS -->
<spring:url value="/resources/css/CustomMessage.css" var="main" />
<link href="${main}" rel="stylesheet" />

<!-- Message JavaScript -->
<spring:url value="/resources/js/message.js" var="messagejs" />
<script src="${messagejs}"></script>

<spring:url value="/pictures/no_photo.png" var="noImage"/>

<spring:url value="/images/" var="location" />

<sec:authentication var="principal" property="principal" />

<div id="message" style="display: none">
    <div class="message_heading" >
        <span id="messageCaption">заголовок</span>
    </div>

    <div class="message_body">
        <span  id="messageBody">описание</span>
    </div>
</div>

<!-- Navigation -->
<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/management/desktop/">Управление магазином</a>
    </div>
    <!-- /.navbar-header -->

    <ul class="nav menu navbar-top-links navbar-right" style="height: 50px; margin-right: 12px">
        <!-- /.dropdown -->
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" style="overflow: hidden; padding-top: 12px; padding-right: 5px; padding-bottom: 0px; font-size: 17px;" href="#">

                <div style="margin-top: 3px">
                    <i class="fa fa-tasks fa-fw"></i> <i class="fa fa-caret-down"></i>
                </div>
            </a>
            <ul id="tasks" class="dropdown-menu" style="width: 200px; padding: 10px">
            </ul>
            <!-- /.dropdown-tasks -->
        </li>
        <!-- /.dropdown -->

        <li class="dropdown">

            <sec:authorize access="isFullyAuthenticated() or isRememberMe()">

                <a class="dropdown-toggle" data-toggle="dropdown" style="overflow: auto; padding: 10px; padding-right: 0px" href="#">
                    <c:choose>
                        <c:when test="${!empty principal.photo}">
                            <img src="${location}${principal.photo}" width="30px" height="30px" style="border-radius: 15px">
                        </c:when>

                        <c:otherwise>
                            <img src="${noImage}" width="30px" height="30px" style="border-radius: 15px">
                        </c:otherwise>
                    </c:choose>
                </a>

                <form action="/logout" method="post" hidden="hidden">
                    <button id="logoutButton" hidden="hidden" type="submit"></button>
                    <sec:csrfInput/>
                </form>

            </sec:authorize>

            <ul class="dropdown-menu custom_dropdown">
                <li>
                    <a href="/profile/">
                        <div class="full_width full_height">
                            <span class="margin_right_3px glyphicon glyphicon-user"></span> Профиль
                        </div>
                    </a>
                </li>
                <li class="divider"></li>

                <li>
                    <a href="/">
                        <div class="full_width full_height">
                            <span class="margin_right_3px fa fa-shopping-cart" style="font-size: 15px"></span> Магазин
                        </div>
                    </a>
                </li>
                <li class="divider"></li>

                <li>
                    <a href="/profile/settings">
                        <div class="full_width full_height">
                            <span class="margin_right_3px glyphicon glyphicon-cog"></span> Настройки
                        </div>
                    </a>
                </li>
                <li class="divider"></li>

                <li>
                    <a href="#" onclick="$('#logoutButton').click()">
                        <div class="full_width full_height">
                            <span class="margin_right_3px glyphicon glyphicon-log-out"></span> Выйти
                        </div>
                    </a>
                </li>
            </ul>
            <!-- /.dropdown-tasks -->
        </li>
        <!-- /.dropdown -->
    </ul>
    <!-- /.navbar-top-links -->

    <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse collapse in" aria-expanded="true">
            <ul class="nav menu" id="side-menu">
                <li>
                    <a href="/management/desktop/" ${selectedMenu.equals("desktop") ? 'class="active"' : ''}><i class="fa fa-desktop fa-fw"></i> Рабочий стол</a>
                </li>
                <li>
                    <a href="/management/tasks/orders/" ${selectedMenu.equals("tasks") ? 'class="active"' : ''}><i class="fa fa-tasks fa-fw"></i> Мои задачи</a>
                </li>
                <sec:authorize access="hasRole('ADMIN')">
                    <li ${selectedMenu.contains("stats/") ? 'class="active"' : ''}>
                        <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Статистика<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li ${selectedMenu.equals("stats/users") ? 'class="active"' : ''}>
                                <a href="/management/statistics/users/" ${selectedMenu.equals("stats/users") ? 'class="active"' : ''}><i class="fa fa-users fa-fw"></i> Сотрудники</a>
                            </li>
                            <li>
                                <a href="/management/statistics/products/" ${selectedMenu.equals("stats/products") ? 'class="active"' : ''}><i class="fa fa-star fa-fw"></i> Товары</a>
                            </li>
                        </ul>
                        <!-- /.nav-second-level -->
                    </li>
                </sec:authorize>
                <sec:authorize access="hasRole('ADMIN')">
                    <li>
                        <a href="/management/users/" ${selectedMenu.equals("staff") ? 'class="active"' : ''}><i class="fa fa-user fa-fw"></i> Персонал</a>
                    </li>
                </sec:authorize>
                <li ${selectedMenu.contains("stock/") ? 'class="active"' : ''}>
                    <a href="#"><i class="fa fa-diamond fa-fw"></i> Склад<span class="fa arrow"></span></a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a href="/management/stock/create/mobile" ${selectedMenu.equals("stock/add") ? 'class="active"' : ''}><i class="fa fa-plus fa-fw"></i> Добавить товар</a>
                        </li>
                        <li>
                            <a href="/management/stock/edit/mobile" ${selectedMenu.equals("stock/edit") ? 'class="active"' : ''}><i class="fa fa-pencil fa-fw"></i> Изменить товар</a>
                        </li>
                    </ul>
                    <!-- /.nav-second-level -->
                </li>
            </ul>
        </div>
        <!-- /.sidebar-collapse -->
    </div>
    <!-- /.navbar-static-side -->
</nav>

<!-- Orders JavaScript -->
<spring:url value="/resources/js/management/orders.js" var="orders" />
<script src="${orders}"></script>

<script>

    "use strict";

    window.onload = loadReminders;

    var reminders = [];

    function loadReminders() {

        $.ajax({
            type : "GET",
            url : "/management/tasks/",
            dataType : 'json',
            timeout : 100000,
            success : function(result) {
                if (result != null) {
                    buildReminder(result);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

    function buildReminder(orders) {
        var tasks = $('#tasks');
        tasks.empty();

        if (orders != undefined && orders.length > 0) {
            reminders = [];
            for (var i = 0; i < orders.length; i++) {
                var order = orders[i];

                var task = '<li style="border-bottom: 1px solid #e5e5e5; padding-bottom: 3px; margin-bottom: 3px"><a href="/management/tasks/orders/?id=' + order.id + '">';
                task += '<div>Заказ №' + order.id + '</div>';

                if (order.dateDeal != '' && order.state == STATE_DEAL) {
                    task += '<div style="font-size: 12px; color: #777777">Встреча : ' + order.dateDeal + '</div>';
                }

                task += '<div class="vertical_align" style="height: 40px">';

                var icon = '';
                icon += '<div style="width : 20%; float: left">';
                icon += '<img src="' + getImgSrcByState(order.state) + '" style="width : 100%">';
                icon += '</div>';

                var bar = '';
                bar += '<div style="width : 77%; float : left; margin-left: 3%">';
                bar += progressBarByState(order.state);
                bar += '</div>';

                task += icon + bar;
                task += '</div>';

                task += '</a></li>';

                reminders.push(order);
                tasks.append(task);
            }

            var showAll = '';
            showAll += '<li>';
            showAll +=   '<a class="text-center" href="/management/tasks/orders/">';
            showAll +=     '<strong>Показать все</strong>';
            showAll +=     '<i class="fa fa-angle-right" style="margin-left: 5px"></i>';
            showAll +=   '</a>';
            showAll += '</li>';
            tasks.append(showAll);

        } else {
            var noTasks = '';
            noTasks += '<li>';
            noTasks +=   '<span>(!) Нет активных задач</span>';
            noTasks += '</li>';
            tasks.append(noTasks);
        }
    }

    function addOrderToReminders(order) {
        console.log(reminders);

        if (order == null) return;

        var updatedReminders;

        if (order.state < 0 || order.state >= 4) {
            for (var i = 0; i < reminders.length; i++) {
                if (reminders[i].id == order.id) {
                    reminders.splice(i, 1);
                    updatedReminders = reminders;
                    break;
                }
            }

        } else {
            var insertMode = true;
            for (var i = 0; i < reminders.length; i++) {
                if (reminders[i].id == order.id) {
                    reminders[i] = order;

                    insertMode = false;
                    break;
                }
            }

            if (insertMode) {
                reminders.push(order);
            }

            reminders.sort(function (a, b) {
                if (a.state > b.state) {
                    return -1;
                }
                if (a.state < b.state) {
                    return 1;
                }
                if (a.dateDeal != '' && b.dateDeal) {
                    if (a.dateDeal < b.dateDeal) {
                        return -1;
                    }
                    if (a.dateDeal > b.dateDeal) {
                        return 1;
                    }
                }
                return 0;
            });

            var size = (reminders.length >= 5) ? 5 : reminders.length;
            updatedReminders = reminders.slice(0, size);
        }

        buildReminder(updatedReminders);
    }

</script>

