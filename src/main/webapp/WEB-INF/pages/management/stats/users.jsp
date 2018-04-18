<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Рабочий стол</title>

    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <spring:url value="/resources/css/bootstrap.css" var="bootstrap" />
    <link href="${bootstrap}" rel="stylesheet" />

    <spring:url value="/resources/dist/css/sb-admin-2.css" var="sb" />
    <link href="${sb}" rel="stylesheet" />

    <spring:url value="/resources/vendor/metisMenu/metisMenu.min.css" var="menu" />
    <link href="${menu}" rel="stylesheet" />

    <spring:url value="/resources/font-awesome/css/font-awesome.css" var="awesome" />
    <link href="${awesome}" rel="stylesheet" />

    <spring:url value="/resources/css/AdminPanel.css" var="panel" />
    <link href="${panel}" rel="stylesheet" />

    <spring:url value="/resources/vendor/datetimepicker/css/bootstrap-datetimepicker.min.css" var="datetimepicker_css" />
    <link href="${datetimepicker_css}" rel="stylesheet" />

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />

    <sec:authentication var="principal" property="principal" />

</head>
<body>

<div id="wrapper">

    <jsp:include page="../menu.jsp" />

    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Статистика</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Статистика пользователей
                    </div>
                    <div class="panel-body" style="padding-top: 5px">

                        <div class="row">

                            <div class="col-lg-12">

                                <div class="vertical_align" style="float:left; margin-top: 7px; margin-right: 7px">

                                    <script>

                                        function buildDate(day, month, year) {

                                            if (day < 10) day = '0' + day;
                                            if (month < 10) month = '0' + month;

                                            return day + '.' + month + '.' + year;;
                                        }

                                        function buildDateFromMs(ms) {
                                            var date = new Date(ms);
                                            var dateDay = date.getDate();
                                            var dateMonth = date.getMonth() + 1;
                                            var dateYear = date.getFullYear();

                                            return buildDate(dateDay, dateMonth, dateYear);
                                        }

                                    </script>

                                    <div class="input-group date" id="datetimepicker1">
                                        <script>
                                            var today = new Date();

                                            var month = today.getMonth() + 1;
                                            var year = today.getFullYear();

                                            var date = buildDate(1, month, year);

                                            document.writeln('<input id="dateStart" class="form-control input-sm" value="' + date + '" style="float: left; width: 100px">');

                                        </script>
                                        <span class="input-group-addon input-sm vertical_align" style="float: left; width: 30px">
                                            <span class="fa fa-clock-o"></span>
                                        </span>
                                    </div>

                                </div>

                                <div class="vertical_align" style="float:left; margin-top: 7px; margin-right: 6px">
                                    <span class="xs_hide" style="float: left; margin-right: 7px; font-size: 12px">:</span>

                                    <div class="input-group date" id="datetimepicker2">
                                        <script>
                                            var today = new Date();

                                            var day = today.getDate();
                                            var month = today.getMonth() + 1;
                                            var year = today.getFullYear();

                                            var date = buildDate(day, month, year);

                                            document.writeln('<input id="dateEnd" class="form-control input-sm" value="' + date + '" style="float: left; width: 100px">');

                                        </script>
                                        <span class="input-group-addon input-sm vertical_align" style="float: left; width: 30px">
                                            <span class="fa fa-clock-o"></span>
                                        </span>
                                    </div>

                                </div>

                                <div class="vertical_align" style="float:left; height: 30px; margin-top: 7px; margin-right: 7px">
                                    <img id="selectedUserPhoto" src="${noImage}" style="max-width: 25px; max-height: 25px; border-radius : 2px;">
                                    <span id="selectedUserName" style="margin-left: 3px; font-size: 12px">Не выбран</span>
                                </div>

                                <div class="vertical_align" style="float:left; height: 30px; margin-top: 7px; margin-right: 11px">
                                    <span id="selectedUserSum" style="margin-left: 3px; font-size: 12px; margin-right: 5px">+0,00</span>
                                    <i class="fa fa-money"></i>
                                </div>

                                <div class="btn btn-default btn-sm vertical_align" onclick="updatePage()" style="float:left; margin-top: 7px; height: 30px;">
                                    <span>Обновить</span>
                                </div>

                            </div>

                        </div>

                        <div class="row" style="margin-top: 9px">

                            <div class="col-lg-12" style="padding-bottom: 0">
                                <div class="panel panel-default" style="margin-bottom: 14px">
                                    <div class="panel-body" style="padding-bottom: 8px">
                                        <canvas id="userSalesChart" width="100%" height="30"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-lg-6">
                                <div class="panel panel-default" style="margin-bottom: 14px">

                                    <div class="panel-body" style="padding-top: 3px; padding-bottom: 7px">
                                        <div class="row">

                                            <div class="col-lg-6 col-md-6">

                                                <div class="vertical_align" style="float: left; margin-top: 7px; margin-right: 10px">
                                                    <span style="float: left; margin-right: 5px">Показать</span>
                                                    <select id="userSalesCount" class="form-control input-sm" style="width: 62px; float: left">
                                                        <option value="5">5</option>
                                                        <option value="10">10</option>
                                                        <option value="20">20</option>
                                                        <option value="50">50</option>
                                                        <option value="100">100</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-lg-6 col-md-6">
                                                <div class="vertical_align xs_pull_left" style="float:right; margin-top: 7px">
                                                    <span style="float: left; margin-right: 5px">Поиск :</span>
                                                    <input id="userSalesInput" class="form-control input-sm" style="float: left; width: 120px"></div>
                                            </div>

                                        </div>
                                        <!-- /.row (nested) -->

                                        <div class="row" style="margin-top: 2px">
                                            <div class="col-lg-12">
                                                <div class="table-responsive" style="margin-top: 7px; font-size: 13px">
                                                    <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="userSalesTable">
                                                        <thead>
                                                        <tr>
                                                            <th>Менеджер</th>
                                                            <th>Фамилия</th>
                                                            <th>Сделок</th>
                                                            <th>Итого</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>

                                                </div>
                                                <!-- /.table-responsive -->
                                            </div>
                                            <!-- /.col-lg-12 (nested) -->
                                            <div class="col-lg-12" id="userSalesPag" style="display: none">
                                                <div id="userSalesPagContent" class="custom_pagination pull-right" style="margin-bottom: 0">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="panel panel-default" style="margin-bottom: 14px">
                                    <div class="panel-body" style="padding-top: 3px;">
                                        <div class="row" style="margin-bottom: 6px">

                                            <div class="col-lg-12">

                                                <div class="vertical_align pull-right" style="float: left; margin-top: 7px; margin-left: 10px;">
                                                    <span style="float: left; margin-right: 5px">Год</span>
                                                    <select id="yearTopChart" class="form-control input-sm" style="width: 100px; float: left">

                                                        <script>

                                                            function buildYearOptions() {
                                                                var today = new Date();
                                                                var currentYear = today.getFullYear();

                                                                for (var i = 0; i < 5; i++) {
                                                                    var year = currentYear - i;
                                                                    document.write('<option value="' + year +'">' + year + '</option>');
                                                                }
                                                            }
                                                            buildYearOptions();

                                                        </script>

                                                    </select>
                                                </div>

                                                <div class="vertical_align pull-right" style="float: left; margin-top: 7px">
                                                    <span style="float: left; margin-right: 5px">Месяц </span>
                                                    <select id="monthTopChart" class="form-control input-sm" style="width: 120px; float: left">

                                                        <script>

                                                            function buildMonthOptions() {
                                                                var today = new Date();
                                                                var currentMonth = today.getMonth();

                                                                for (var i = 0; i < 12; i++) {
                                                                    var selected = '';
                                                                    if (i == currentMonth) selected='selected="selected"';

                                                                    switch (i) {
                                                                        case 0 : writeOption("Январь", 0, selected); break;
                                                                        case 1 : writeOption("Февраль", 1, selected); break;
                                                                        case 2 : writeOption("Март", 2, selected); break;
                                                                        case 3 : writeOption("Апрель", 3, selected); break;
                                                                        case 4 : writeOption("Май", 4, selected); break;
                                                                        case 5 : writeOption("Июнь", 5, selected); break;
                                                                        case 6 : writeOption("Июль", 6, selected); break;
                                                                        case 7 : writeOption("Август", 7, selected); break;
                                                                        case 8: writeOption("Сентябрь", 8, selected); break;
                                                                        case 9 : writeOption("Октябрь", 9, selected); break;
                                                                        case 10 : writeOption("Ноябрь", 10, selected); break;
                                                                        case 11 : writeOption("Декабрь", 11, selected); break;
                                                                    }
                                                                }

                                                                function writeOption(name, value, selected) {
                                                                    document.writeln('<option value="' + value + '" ' + selected + '>' + name + '</option>');
                                                                }
                                                            }
                                                            buildMonthOptions();

                                                        </script>

                                                    </select>
                                                </div>
                                            </div>

                                        </div>
                                        <canvas id="topUsersChart" width="100" height="50"></canvas>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">

                            <div class="col-lg-12">
                                <div id="historyBlock" style="display: none">

                                    <div class="panel panel-default">
                                        <div class="panel-body" style="padding-top: 3px; padding-bottom: 8px">
                                            <%-- History --%>
                                            <div class="row">

                                                <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                                                    <div class="vertical_align" style="float: left; margin-top: 7px">
                                                        <span style="float: left; margin-right: 5px">Показать</span>
                                                        <select id="historyCount" class="form-control input-sm" style="width: 62px; float: left">
                                                            <option value="5">5</option>
                                                            <option value="10">10</option>
                                                            <option value="20">20</option>
                                                            <option value="50">50</option>
                                                            <option value="100">100</option>
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>
                                            <!-- /.row (nested) -->

                                            <div class="row" style="margin-top: 2px">
                                                <div class="col-lg-12">
                                                    <div class="table-responsive" style="margin-top: 7px; font-size: 13px">
                                                        <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="historyTable">
                                                            <thead>
                                                            <tr>
                                                                <th style="text-align: center">#</th>
                                                                <th>Менеджер</th>
                                                                <th>Статус</th>
                                                                <th>E-mail</th>
                                                                <th>Телефон</th>
                                                                <th>Дата сделки</th>
                                                                <th>Сумма</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>

                                                    </div>
                                                    <!-- /.table-responsive -->
                                                </div>
                                                <!-- /.col-lg-12 (nested) -->
                                                <div class="col-lg-12" id="historyPag" style="display: none">
                                                    <div id="historyPagContent" class="custom_pagination pull-right" style="margin-bottom: 0">
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>

                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->

    </div>
    <!-- /#page-wrapper -->

    <!-- Modal -->
    <div class="modal fade text-left" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="myOrderModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                    <div>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <i class="fa fa-times" style="font-size: 0.8em"></i>
                        </button>
                    </div>

                    <h4 class="modal-title" id="myOrderModal">Данные заказа :</h4>
                </div>

                <div class="modal-body center-block" style="width: 100%; padding : 6px 16px">

                    <input type="hidden" id="targetId" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Ф.И.О.</label>
                    <input id="targetName" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">E-mail</label>
                    <input id="targetEmail" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Телефон</label>
                    <input id="targetPhone" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Адрес доставки</label>
                    <input id="targetAddress" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Дата заказа</label>
                    <input id="targetDateReceived" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Список товаров</label>
                    <div class="table-responsive" style="font-size: 13px">
                        <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="productsTable">
                            <thead>
                            <tr>
                                <th style="text-align: center">#</th>
                                <th></th>
                                <th>Название</th>
                                <th>Количество</th>
                                <th>Сумма</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                    </div>
                    <!-- /.table-responsive -->

                    <label class="control-label">Сумма</label>
                    <input id="targetTotalSum" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Статус</label>
                    <input id="targetState" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Дата сделки</label>
                    <input id="targetDateDeal" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Менеджер</label>
                    <input id="targetManager" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Комментарий</label>
                    <textarea id="targetCommentary" class="form-control space_bottom" rows="3" style="resize: vertical" disabled="disabled"></textarea>

                </div>

                <div class="modal-footer">
                    <button type="button" onclick="$('#orderModal').modal('toggle');" class="btn btn-primary">
                        <i class="fa fa-check"></i>
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

</div>

<!-- jQuery -->
<spring:url value="/resources/vendor/jquery/jquery.min.js" var="jquery" />
<script src="${jquery}"></script>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<!-- Metis Menu Plugin JavaScript -->
<spring:url value="/resources/vendor/metisMenu/metisMenu.min.js" var="metisjs" />
<script src="${metisjs}"></script>

<!-- Custom Theme JavaScript -->
<spring:url value="/resources/dist/js/sb-admin-2.js" var="sbjs" />
<script src="${sbjs}"></script>

<!-- JSON objects JavaScript -->
<spring:url value="/resources/js/model.js" var="model" />
<script src="${model}"></script>

<!-- Page level plugin JavaScript-->
<spring:url value="/resources/vendor/chart/Chart.min.js" var="charts" />
<script src="${charts}"></script>

<!-- Chart configs JavaScript-->
<spring:url value="/resources/js/management/charts_configs.js" var="chart_configs" />
<script src="${chart_configs}"></script>

<!-- Moment.js JavaScript -->
<spring:url value="/resources/vendor/datetimepicker/js/moment-with-locales.min.js" var="momentjs" />
<script src="${momentjs}"></script>

<!-- DateTimePicker JavaScript -->
<spring:url value="/resources/vendor/datetimepicker/js/bootstrap-datetimepicker.js" var="datetimepickerjs" />
<script src="${datetimepickerjs}"></script>

<script>

    "use strict";

    var orders = undefined;

    var currentUsername = undefined;

    // -- Area Chart
    var userSalesChart = null;

    // -- Bar Chart
    var topUsersChart = null;

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    $(document).ready(function() {
        getUserSales(1);
        getTopUsers();
    });

    $('#datetimepicker1').datetimepicker({
        format: 'DD.MM.YYYY',
        locale: 'ru'
    });

    $('#datetimepicker2').datetimepicker({
        format: 'DD.MM.YYYY',
        locale: 'ru'
    });

    function getSalesByUsername(username) {

        var dateStart = $('#dateStart').val();
        var dateEnd = $('#dateEnd').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/users/sales/" + username,
            data : { dateStart : dateStart, dateEnd : dateEnd},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                if (result != null) {
                    buildSalesChart(result);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });
    }

    function buildSalesChart(sales) {
        var oneDay = 24*60*60*1000;
        var dateStartMs = ( parseDate( $('#dateStart').val()) ).getTime() ;
        var dateEndMs = ( parseDate( $('#dateEnd').val()) ).getTime() ;

        var diffDays = 1 + Math.round(Math.abs((dateStartMs - dateEndMs)/(oneDay)));

        var divSize = parseInt(diffDays / 10) + 1;

        var points = [];
        var dates = [];
        var max = 0;

        if (diffDays > 1) {
            var step = oneDay * divSize;
            for (var t = dateStartMs; t < dateEndMs; t += step) {

                dates.push( buildDateFromMs(t) );
                points.push(0);

                if (t + step >= dateEndMs) {
                    dates.push( buildDateFromMs(dateEndMs) );
                    points.push(0);
                }
            }

            var sum = 0;
            for (var i = 0; i < sales.length; i++) {
                var dateMs = ( parseDate(sales[i].dateDeal) ).getTime();

                var pos = Math.ceil( (dateMs - dateStartMs) / step );
                points[pos] += sales[i].totalSum;

                sum += sales[i].totalSum;
            }
            $('#selectedUserSum').html( ( '+' + sum.toFixed(2) ).replace('.', ',') );

            for (var i = 0; i < points.length; i++) {
                points[i] = parseFloat( points[i].toFixed(2) );
                if (max < points[i]) max = points[i];
            }
            if (max == 0) max = 1;
            else max += 2000 - (max % 2000);

            if (userSalesChart != null) userSalesChart.destroy();
            userSalesChart = makeLineChart("userSalesChart", ' Продажи ', dates, points, max, 'users');

        } else {


            points.push(0);
            dates.push( buildDateFromMs(dateEndMs) );

            for (var i = 0; i < sales.length; i++) {
                points[0] += sales[i].totalSum;
            }

            points[0] = (points[0]).toFixed(2);

            max = parseInt(points[0]);
            if (max == 0) max = 1;
            else max = max + 2000 - (max % 2000);

            if (userSalesChart != null) userSalesChart.destroy();
            userSalesChart = makeBarChart("userSalesChart", ' Продажи ', dates, points, max, 'users');
        }

    }

    function parseDate(string) {
        var parts = string.split('.');
        return new Date(parts[2], parts[1] - 1, parts[0]);
    }

    function updatePage() {

        var dateStartMs = ( parseDate( $('#dateStart').val()) ).getTime();
        var dateEndMs = ( parseDate( $('#dateEnd').val()) ).getTime();

        if (dateStartMs <= dateEndMs) {
            getSalesByUsername(currentUsername);
            getUserSales(1);
            selectTableRow('rowId_' + currentUsername);
            getUserSalesHistory(currentUsername, 1);

        } else {
            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Уведомление';
            var content = 'Диапазон указан <b>некорректно</b>.';

            showMessage(element, bodyHeight, caption, content);
        }

    }

    $('#userSalesInput').keyup(function (e) {
        getUserSales(1);
    });

    $('#userSalesCount').change(function () {
        getUserSales(1);
    });

    function isEmpty(value) {
        return (value == '' || value == null);
    }

    function getUserSales(page) {

        var dateStart = $('#dateStart').val();
        var dateEnd = $('#dateEnd').val();

        var username = $('#userSalesInput').val();
        var count = $('#userSalesCount').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/users/sales/",
            data : { username : username, page : page, count : count, dateStart : dateStart, dateEnd : dateEnd},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);

                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    var userSales = result.list;

                    buildSalesTable(userSales, page, maxCount, count);

                    if (currentUsername == undefined && userSales.length > 0) {
                        onUserSalesRowClick(userSales[0].username, userSales[0].photo);
                    }
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });
    }

    function buildSalesTable(userSales, page, maxCount, count) {

        var tbody = $('#userSalesTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < userSales.length; i++) {
            var stats = userSales[i];

            var username = stats.username;
            var photo = stats.photo;
            var name = stats.name;
            var surname = stats.surname;
            var patronymic = stats.patronymic;
            var quantity = stats.quantity;
            var totalSum = stats.totalSum;

            var row = '<tr id="rowId_' + username + '" onclick="onUserSalesRowClick(\'' + username + '\', \'' + photo + '\')" ' +
                    '  style="height: 40px; cursor : pointer">';

            var manager = buildManagerBlock(username, photo);
            row += '<td style="vertical-align: middle">' + manager + '</td>';

            row += '<td style="vertical-align: middle">' + surname + '</td>';
            row += '<td style="vertical-align: middle">' + quantity + '</td>';
            row += '<td style="vertical-align: middle">' + totalSum + ' руб.</td>';

            row += '</tr>';
            tbody.append(row);
        }

        if (maxCount > count) {
            var pagesCount = parseInt( Math.ceil( maxCount / count ) );

            $('#userSalesPag').css('display', 'block');

            var pag_content = $('#userSalesPagContent');
            pag_content.empty();

            if (page - 2 > 0) {
                pag_content.append('<a class="page" onclick="getUserSales(' + 1 + ')" >1</a>');
                if (page - 2 > 1) {
                    pag_content.append('<span class="empty">...</span>');
                }
            }

            var begin = (page - 1) > 0 ? (page - 1) : 1;
            var end = (page + 1) < pagesCount ? (page + 1) : pagesCount;

            for (var i = begin; i <= end; i++) {
                if (i == page) {
                    pag_content.append('<span class="page active">' + i + '</span>');

                } else {
                    pag_content.append('<a class="page" onclick="getUserSales(' + i + ')" >' + i + '</a>')
                }
            }

            if (pagesCount - page > 1) {
                if (pagesCount - page > 2) {
                    pag_content.append('<span class="empty" >...</span>');
                }
                pag_content.append('<a class="page" onclick="getUserSales(' + pagesCount + ')" >' + pagesCount + '</a>')
            }

        } else {
            $('#userSalesPag').css('display', 'none');
        }

        if (currentUsername != undefined) {
            selectTableRow('rowId_' + currentUsername);
        }
    }

    function getUserSalesHistory(username, page) {
        var dateStart = $('#dateStart').val();
        var dateEnd = $('#dateEnd').val();

        var count = $('#historyCount').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/users/history/",
            data : { username : username, page : page, count : count, dateStart : dateStart, dateEnd : dateEnd },
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    var historyOrders = result.list;
                    orders = historyOrders;

                    buildUserSalesHistoryTable(page, maxCount, count, historyOrders);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

    function buildUserSalesHistoryTable(page, maxCount, count, historyOrders) {

        $('#historyBlock').css('display', 'block');
        var tbody = $('#historyTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < historyOrders.length; i++) {
            var order = historyOrders[i];

            var id = order.id;
            var email = order.email;
            var phone = order.phone;
            var dateDeal = order.dateDeal;
            var state = order.state;
            var totalSum = order.totalSum;

            var row = '<tr onclick="showOrder(' + id + ')" style="height: 60px; cursor: pointer">';

            row += '<td style="vertical-align: middle; text-align: center">' + id + '</td>';

            var manager;
            if (!isEmpty(order.manager)) {
                manager = buildManagerBlock(order.manager, order.managerPhoto);
            } else {
                manager = 'Открыто';
            }
            row += '<td style="vertical-align: middle">' + manager + '</td>';

            row += '<td style="vertical-align: middle">' + progressBarByState(state) + '</td>';
            row += '<td style="vertical-align: middle">' + email + '</td>';
            row += '<td style="vertical-align: middle">' + phone + '</td>';
            row += '<td style="vertical-align: middle;     color: #777777; font-size: 12px;">' + dateDeal + '</td>';
            row += '<td style="vertical-align: middle">' + totalSum + ' руб.</td>';

            row += '</tr>';
            tbody.append(row);
        }

        if (maxCount > count) {
            var pagesCount = parseInt( Math.ceil( maxCount / count ) );

            $('#historyPag').css('display', 'block');

            var pag_content = $('#historyPagContent');
            pag_content.empty();

            if (page - 2 > 0) {
                pag_content.append('<a class="page" onclick="getUserSalesHistory(\'' + order.manager + '\', 1)" >1</a>');
                if (page - 2 > 1) {
                    pag_content.append('<span class="empty">...</span>');
                }
            }

            var begin = (page - 1) > 0 ? (page - 1) : 1;
            var end = (page + 1) < pagesCount ? (page + 1) : pagesCount;

            for (var i = begin; i <= end; i++) {
                if (i == page) {
                    pag_content.append('<span class="page active">' + i + '</span>');

                } else {
                    pag_content.append('<a class="page" onclick="getUserSalesHistory(\'' + order.manager + '\', ' + i + ' )" >' + i + '</a>')
                }
            }

            if (pagesCount - page > 1) {
                if (pagesCount - page > 2) {
                    pag_content.append('<span class="empty" >...</span>');
                }
                pag_content.append('<a class="page" onclick="getUserSalesHistory(\'' + order.manager + '\', ' + pagesCount + ' )" >' + pagesCount + '</a>')
            }

        } else {
            $('#historyPag').css('display', 'none');
        }
    }

    function showOrder(id) {

        var targetOrder = null;
        for (var i = 0; i < orders.length; i++) {
            var order = orders[i];
            if (order.id == id) {
                targetOrder = order;
                break;
            }
        }

        if (targetOrder != null) {

            $('#targetId').val( targetOrder.id );
            $('#targetName').val ( targetOrder.name );
            $('#targetEmail').val( targetOrder.email );
            $('#targetPhone').val( targetOrder.phone );
            $('#targetAddress').val( targetOrder.meetingPoint );
            $('#targetDateReceived').val(targetOrder.dateReceived);
            $('#targetState').val( captionByState(targetOrder.state) );
            $('#targetTotalSum').val( targetOrder.totalSum + " руб." );
            $('#targetDateDeal').val( targetOrder.dateDeal );
            $('#targetManager').val( targetOrder.manager );
            $('#targetCommentary').val( targetOrder.commentary );

            buildProductsTable(targetOrder.products);
            $('#orderModal').modal('toggle');
        }
    }

    function buildProductsTable(products) {

        var tbody = $('#productsTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < products.length; i++) {
            var product = products[i];

            var id = product.id;
            var name = product.name;
            var price = product.price;
            var count = product.count;
            var sum = (count * price).toFixed(2);

            var row = '<tr style="height: 60px; cursor : pointer">';

            row += '<td style="vertical-align: middle">' + id + '</td>';

            var imgSrc = (product.preview == '') ? '${noImage}' : ( '${location}' + product.preview );
            var imgElem = '<a href="/' + product.type + '/' + product.productId + '"><img src=' + imgSrc + ' style="max-width: 2em; max-height: 3em"></a>';
            row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

            row += '<td style="vertical-align: middle">' + name + '</td>';
            row += '<td style="vertical-align: middle">' + count + '</td>';
            row += '<td style="vertical-align: middle">' + sum + ' р.</td>';

            row += '</tr>';
            tbody.append(row);
        }
    }

    $('#historyCount').change(function () {
        if (currentUsername != undefined) {
            getUserSalesHistory(currentUsername, 1);
        }
    });

    function buildManagerBlock(username, photo) {
        var imgSrc = (isEmpty(photo)) ? '${noImage}' : ( '${location}' + photo );
        var login = '<span style="margin-left: 3px">' + username + '</span>';
        var result = '<a href="/user/' + username + '"><img src=' + imgSrc + ' style="max-width: 20px; max-height: 20px; border-radius : 2px; margin-top: -3px"></a>' + login;
        return result;
    }

    function onUserSalesRowClick(username, photo) {

        currentUsername = username;
        selectTableRow('rowId_' + username);

        $('#selectedUserName').html(username);

        var photoSrc = (isEmpty(photo) || photo == 'null') ? '${noImage}' : ( '${location}' + photo );
        $('#selectedUserPhoto').attr('src', photoSrc);

        getSalesByUsername(username);

        getUserSalesHistory(username, 1);
    }

    var currentRow = undefined;

    function selectTableRow(rowId) {

        if (currentRow != undefined) {
            $(currentRow).removeClass('table_selected_row');
        }

        currentRow = '#' + rowId;
        $(currentRow).addClass('table_selected_row');
    }

    $('#yearTopChart').change(function () {
        getTopUsers();
    });

    $('#monthTopChart').change(function () {
        getTopUsers();
    });

    function getTopUsers() {
        var month = $('#yearTopChart').val();
        var year = $('#monthTopChart').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/users/top/",
            data : { month : month, year : year },
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);
                if (result != null) {
                    var userSales = result; // ?
                    buildTopChart(result);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });
    }

    function buildTopChart(userSales) {

        var labels = [];
        var data = [];

        var max = 0;
        for (var i = 0; i < userSales.length; i++) {

            if (max < userSales[i].totalSum) max = userSales[i].totalSum;

            labels.push( userSales[i].username );
            data.push( userSales[i].totalSum );
        }

        if (max == 0) max = 1;
        else max += 2000 - (max % 2000);

        if (topUsersChart != null) topUsersChart.destroy();
        topUsersChart = makeBarChart("topUsersChart", ' Итого ', labels, data, max, 'users');
    }

</script>


</body>
</html>
