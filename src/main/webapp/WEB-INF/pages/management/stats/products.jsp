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
                        Статистика товаров
                    </div>
                    <div class="panel-body" style="padding-top: 5px">

                        <div class="row">

                            <div class="col-lg-12">

                                <div class="vertical_align" style="float:left; margin-top: 7px; margin-right: 7px">

                                    <div class="input-group date" id="datetimepicker1">

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
                                    <img id="selectedProductPhoto" src="${noImage}" style="display: none; max-width: 25px; max-height: 25px; border-radius : 2px; margin-right: 5px">
                                    <span id="selectedProductName" style="font-size: 12px">[ Все товары ]</span>
                                </div>

                                <div class="vertical_align" style="float:left; height: 30px; margin-top: 7px; margin-right: 11px">
                                    <span id="selectedProductSum" style="margin-left: 3px; font-size: 12px; margin-right: 5px">+0,00</span>
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
                                        <canvas id="productSalesChart" width="100%" height="30"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">

                            <div class="col-lg-12">
                                <div class="panel panel-default" style="margin-bottom: 14px">

                                    <div class="panel-body" style="padding-top: 3px; padding-bottom: 7px">
                                        <div class="row">

                                            <div class="col-lg-6 col-md-8 col-sm-12 col-xs-12">

                                                <div class="vertical_align" style="float: left; margin-top: 7px; margin-right: 10px">
                                                    <span style="float: left; margin-right: 5px">Показать</span>
                                                    <select id="productSalesCount" class="form-control input-sm" style="width: 62px; float: left">
                                                        <option value="5">5</option>
                                                        <option value="10">10</option>
                                                        <option value="20">20</option>
                                                        <option value="50">50</option>
                                                        <option value="100">100</option>
                                                    </select>
                                                </div>

                                                <div class="vertical_align" style="float: left; margin-top: 7px; margin-right: 5px">
                                                    <span style="float: left; margin-right: 5px">Тип</span>
                                                    <select id="productType" class="form-control input-sm" style="width: 170px; float: left">
                                                        <option value="">Все товары</option>
                                                        <option value="mobile">Мобильный телефоны</option>
                                                        <option value="notebook">Ноутбуки</option>
                                                    </select>
                                                </div>
                                                <div class="vertical_align" style="float: left; margin-top: 7px">
                                                    <button onclick="onSalesTypeClick()" type="button" class="btn btn-default btn-sm">
                                                        <i class="fa fa-bar-chart"></i>
                                                    </button>
                                                </div>
                                            </div>

                                            <div class="col-lg-6 col-md-4 col-sm-12 col-xs-12">
                                                <div class="vertical_align xs_pull_left left_sm" style="float:right; margin-top: 7px">
                                                    <span style="float: left; margin-right: 5px">Поиск :</span>
                                                    <input id="productSalesInput" class="form-control input-sm" style="float: left; width: 120px"></div>
                                            </div>

                                        </div>
                                        <!-- /.row (nested) -->

                                        <div class="row" style="margin-top: 2px">
                                            <div class="col-lg-12">
                                                <div class="table-responsive" style="margin-top: 7px; font-size: 13px">
                                                    <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="productSalesTable">
                                                        <thead>
                                                        <tr>
                                                            <th class="text-center">#</th>
                                                            <th></th>
                                                            <th>Модель</th>
                                                            <th>Продано</th>
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
                                            <div class="col-lg-12" id="productSalesPag" style="display: none">
                                                <div id="productSalesPagContent" class="custom_pagination pull-right" style="margin-bottom: 0">
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

    var currentProductId = undefined;

    var chartTypeMode = undefined;

    // -- Area Chart
    var productSalesChart = null;

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    $(document).ready(function() {
        getProductSales(1);
    });

    $('#datetimepicker1').datetimepicker({
        format: 'DD.MM.YYYY',
        locale: 'ru'
    });

    $('#datetimepicker2').datetimepicker({
        format: 'DD.MM.YYYY',
        locale: 'ru'
    });


    function getSales() {
        var dateStart = $('#dateStart').val();
        var dateEnd = $('#dateEnd').val();
        var type = $('#productType').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/products/sales/all/",
            data : { type : type, dateStart : dateStart, dateEnd : dateEnd},
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

    function getSalesByProduct(productId) {

        var dateStart = $('#dateStart').val();
        var dateEnd = $('#dateEnd').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/products/sales/" + productId,
            data : { dateStart : dateStart, dateEnd : dateEnd},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);
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

            for (var i = 0; i < points.length; i++) {
                points[i] = parseFloat( points[i].toFixed(2) );
            }

            $('#selectedProductSum').html( ( '+' + sum.toFixed(2) ).replace('.', ',') );

            for (var i = 0; i < points.length; i++) {
                if (max < points[i]) max = points[i];
            }
            if (max == 0) max = 1;
            else max += 2000 - (max % 2000);
            if (productSalesChart != null) productSalesChart.destroy();
            productSalesChart = makeLineChart("productSalesChart", ' Продажи ', dates, points, max, 'products');
        } else {

            points.push(0);
            dates.push( buildDateFromMs(dateEndMs) );

            for (var i = 0; i < sales.length; i++) {
                points[0] += sales[i].totalSum;
            }

            points[0] = (points[0]).toFixed(2);

            $('#selectedProductSum').html( ( '+' + points[0] ).replace('.', ',') );

            max = parseInt(points[0]);
            if (max == 0) max = 1;
            else max = max + 2000 - (max % 2000);

            if (productSalesChart != null) productSalesChart.destroy();
            productSalesChart = makeBarChart("productSalesChart", ' Продажи ', dates, points, max, 'products');
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

            if (chartTypeMode != undefined) {
                getProductSales(1);
                getSales();

            } else {
                getSalesByProduct(currentProductId);
                getProductSales(1);
                selectTableRow('rowId_' + currentProductId);
            }

        } else {
            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Уведомление';
            var content = 'Диапазон указан <b>некорректно</b>.';

            showMessage(element, bodyHeight, caption, content);
        }

    }

    $('#productSalesInput').keyup(function (e) {
        getProductSales(1);
    });

    $('#productSalesCount').change(function () {
        getProductSales(1);
    });

    $('#productType').change(function () {
        getProductSales(1);
    });

    function isEmpty(value) {
        return (value == '' || value == null);
    }

    function getProductSales(page) {

        var dateStart = $('#dateStart').val();
        var dateEnd = $('#dateEnd').val();

        var name = $('#productSalesInput').val();
        var count = $('#productSalesCount').val();
        var type = $('#productType').val();

        $.ajax({
            type : "GET",
            url : "/management/statistics/products/sales/",
            data : { name : name, type : type, page : page, count : count, dateStart : dateStart, dateEnd : dateEnd},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);

                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    var productSales = result.list;

                    buildSalesTable(productSales, page, maxCount, count);

                    if (currentProductId == undefined && productSales.length > 0 && chartTypeMode == undefined) {
                        onSalesTypeClick();
                    }
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });
    }

    function buildSalesTable(productSales, page, maxCount, count) {

        var tbody = $('#productSalesTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < productSales.length; i++) {
            var productStats = productSales[i];

            var productId = productStats.id;
            var preview = productStats.preview;
            var type = productStats.type;
            var name = productStats.name;
            var quantity = productStats.quantity;
            var totalSum = productStats.totalSum;


            var row = '<tr id="rowId_' + productId + '" onclick="onProductSalesRowClick(\'' + productId + '\', \'' + name + '\', \'' + preview + '\')" ' +
                    '  style="height: 40px; cursor : pointer">';

            row += '<td class="text-center" style="vertical-align: middle">' + productId + '</td>';

            var imgSrc = (preview == '') ? '${noImage}' : ( '${location}' + preview );
            var imgElem = '<a href="/' + type + '/' + productId + '"><img src=' + imgSrc + ' style="max-width: 30px; max-height: 30px"></a>';
            row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

            row += '<td style="vertical-align: middle">' + name + '</td>';

            row += '<td style="vertical-align: middle">' + quantity + ' шт.</td>';
            row += '<td style="vertical-align: middle">' + totalSum + ' руб.</td>';

            row += '</tr>';
            tbody.append(row);
        }

        if (maxCount > count) {
            var pagesCount = parseInt( Math.ceil( maxCount / count ) );

            $('#productSalesPag').css('display', 'block');

            var pag_content = $('#productSalesPagContent');
            pag_content.empty();

            if (page - 2 > 0) {
                pag_content.append('<a class="page" onclick="getProductSales(' + 1 + ')" >1</a>');
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
                    pag_content.append('<a class="page" onclick="getProductSales(' + i + ')" >' + i + '</a>')
                }
            }

            if (pagesCount - page > 1) {
                if (pagesCount - page > 2) {
                    pag_content.append('<span class="empty" >...</span>');
                }
                pag_content.append('<a class="page" onclick="getProductSales(' + pagesCount + ')" >' + pagesCount + '</a>')
            }

        } else {
            $('#productSalesPag').css('display', 'none');
        }

        if (currentProductId != undefined) {
            selectTableRow('rowId_' + currentProductId);
        }
    }

    function onProductSalesRowClick(id, name, photo) {

        currentProductId = id;
        chartTypeMode = undefined;

        selectTableRow('rowId_' + id);

        $('#selectedProductName').html(name);

        var photoSrc = (isEmpty(photo) || photo == 'null') ? '${noImage}' : ( '${location}' + photo );
        $('#selectedProductPhoto').attr('src', photoSrc);
        $('#selectedProductPhoto').show();

        getSalesByProduct(id);
    }

    function onSalesTypeClick() {
        var type = $('#productType').find('option:selected').text();

        $('#rowId_' + currentProductId).removeClass('table_selected_row');
        currentProductId = undefined;

        $('#selectedProductName').html( '[ ' +type + ' ]');

        $('#selectedProductPhoto').hide();

        chartTypeMode = type;
        getSales();
    }

    var currentRow = undefined;

    function selectTableRow(rowId) {

        if (currentRow != undefined) {
            $(currentRow).removeClass('table_selected_row');
        }

        currentRow = '#' + rowId;
        $(currentRow).addClass('table_selected_row');
    }

</script>


</body>
</html>
