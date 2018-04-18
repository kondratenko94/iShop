<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Заказы</title>

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
                <h1 class="page-header">Мои заказы</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>

        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Список задач
                    </div>
                    <div>
                        <div class="row">
                            <div class="col-lg-12">

                                <!-- /.panel-heading -->
                                <div class="panel-body">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs">
                                        <li ${ true ? 'class="active"' : ''}><a href="#orders" data-toggle="tab"><i class="fa fa-search fa-fw"></i> Задачи</a>
                                        </li>
                                        <li ${ false ? 'class="active"' : ''}><a href="#order" id="orderTab" data-toggle="tab"><i class="fa fa-tasks fa-fw"></i> Заказ</a>
                                        </li>

                                    </ul>

                                    <!-- Tab panes -->
                                    <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0">
                                        <div class="tab-pane fade ${ true ? 'in active' : ''}" id="orders">
                                            <div class="form-group" style="margin-top: 0; margin-bottom: 0; padding: 0.5em 1em">

                                                <div class="row">

                                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                                        <div class="vertical_align xss_no_r_margin" style="float: left; margin-right: 10px; margin-top: 7px">
                                                            <span style="float: left; margin-right: 5px">Статус :</span>
                                                            <select id="selectedStatus" class="form-control input-sm" style="width: 125px; float: left">
                                                                <option value="" selected="selected">Все</option>
                                                                <option value="0">Открыты</option>
                                                                <option value="1">Завершены</option>
                                                            </select>
                                                        </div>

                                                        <div class="vertical_align xss_no_r_margin" style="float: left; margin-right: 10px; margin-top: 7px">
                                                            <span style="float: left; margin-right: 5px">Состояние :</span>
                                                            <select id="selectedState" class="form-control input-sm" style="width: 145px; float: left">
                                                                <option value="">Любое</option>
                                                                <option value="0">Открыты</option>
                                                                <option value="1">Принятые</option>
                                                                <option value="2">В процессе</option>
                                                                <option value="4">Завершены</option>
                                                                <option value="-1">Некорректные</option>
                                                                <option value="-2">Отклонены</option>
                                                            </select>
                                                        </div>

                                                        <div class="vertical_align xss_no_r_margin" style="float: left; margin-top: 7px">
                                                            <span style="float: left; margin-right: 5px">Показать</span>
                                                            <select id="count" class="form-control input-sm" style="width: 62px; float: left">
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
                                                            <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="ordersTable">
                                                                <thead>
                                                                <tr>
                                                                    <th style="text-align: center">#</th>
                                                                    <th>Менеджер</th>
                                                                    <th>Статус</th>
                                                                    <th>E-mail</th>
                                                                    <th>Телефон</th>
                                                                    <th>Дата заявки</th>
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
                                                    <div class="col-lg-12" id="pagination" style="display: none">
                                                        <div id="paginationContent" class="custom_pagination pull-right" style="margin-bottom: 0">
                                                        </div>
                                                    </div>
                                                </div>


                                                <div id="historyBlock" style="display: none">
                                                    <%-- History --%>
                                                    <div class="row">

                                                        <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                                                            <div class="vertical_align xss_no_r_margin" style="float: left; margin-right: 10px; margin-top: 7px">
                                                                <span style="float: left; margin-right: 5px">Статус :</span>
                                                                <select id="historyState" class="form-control input-sm" style="width: 145px; float: left">
                                                                    <option value="">Все</option>
                                                                    <option value="0">Открытые</option>
                                                                    <option value="1">Принятые</option>
                                                                    <option value="2">В процессе</option>
                                                                    <option value="4">Завершенные</option>
                                                                    <option value="-1">Некорректные</option>
                                                                    <option value="-2">Отклонены</option>
                                                                </select>
                                                            </div>

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
                                                                        <th>Дата заявки</th>
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
                                        <div class="tab-pane fade ${ false ? 'in active' : ''}" id="order">
                                            <div class="form-group" id="orderContent" style="margin-top: 0; margin-bottom: 0; padding: 0.5em 1em; overflow: auto"></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel-body -->

                            </div>
                            <!-- /.col-lg-12 (nested) -->

                        </div>
                        <!-- /.row (nested) -->
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

<!-- Modal -->
<div class="modal fade text-left" id="reasonModal" tabindex="-1" role="dialog" aria-labelledby="myReasonModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                <div>
                    <button type="button" class="close" onclick="$('#reasonModal').modal('toggle');">
                        <i class="fa fa-times" style="font-size: 0.8em"></i>
                    </button>
                </div>

                <h4 class="modal-title" id="myReasonModal">Данные заказа :</h4>
            </div>

            <div class="modal-body center-block" style="width: 100%; padding : 6px 16px">

                <label class="control-label">Выберите причину отклонения заказа</label>
                <select id="reasonTemplate" class="form-control" style="margin-bottom: 10px">
                    <option value="Не удалось связаться с клиентом.">Не удалось связаться с клиентом.</option>
                    <option value="Клиент отказался от заказа.">Клиент отказался от заказа.</option>
                    <option value="">Другое</option>
                </select>
                <label class="control-label">Причина</label>
                <textarea id="reason" class="form-control space_bottom" rows="3" style="resize: vertical">Не удалось связаться с клиентом.</textarea>

            </div>

            <div class="modal-footer">
                <button type="button" id="rejectOrderButton" class="btn btn-primary">
                    <i class="fa fa-check"> Отклонить</i>
                </button>

                <button type="button" onclick="$('#reasonModal').modal('toggle');" class="btn btn-default">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!-- Edit products Modal -->
<div class="modal fade text-left" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myEditModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                <div>
                    <button type="button" class="close" onclick="$('#editModal').modal('toggle');">
                        <i class="fa fa-times" style="font-size: 0.8em"></i>
                    </button>
                </div>

                <h4 class="modal-title" id="myEditModal">Уточнить товары :</h4>
            </div>

            <div class="modal-body center-block" style="width: 100%; padding : 6px 16px">

                <div id="editContent"></div>

                <div class="vertical_align" style="float:right; margin-top: 3px; margin-bottom: 7px">
                    <span style="float: left; margin-right: 5px">Поиск :</span>
                    <input id="productsName" class="form-control input-sm" style="float: left; width: 120px">
                </div>

                <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em; margin-top: 10px" id="productTable">
                    <thead>
                    <tr>
                        <th style="text-align: center">#</th>
                        <th></th>
                        <th>Название</th>
                        <th>Цена</th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                </table>

                <div id="pagProductRow" class="row" style="display: none">
                    <div class="col-lg-12">
                        <div id="pagProductRowContent" class="custom_pagination pull-right" style="margin-bottom: 0">
                        </div>
                    </div>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" id="saveProducts" class="btn btn-primary">
                    <i class="fa fa-check"> Сохранить</i>
                </button>

                <button type="button" onclick="$('#editModal').modal('toggle');" class="btn btn-default">
                    <i class="fa fa-times"></i>
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
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

<!-- Moment.js JavaScript -->
<spring:url value="/resources/vendor/datetimepicker/js/moment-with-locales.min.js" var="momentjs" />
<script src="${momentjs}"></script>

<!-- DateTimePicker JavaScript -->
<spring:url value="/resources/vendor/datetimepicker/js/bootstrap-datetimepicker.js" var="datetimepickerjs" />
<script src="${datetimepickerjs}"></script>

<script>

    "use strict";

    var selectedOrderId = '${param.id}';

    var orders;
    var currentProducts = null;

    const USERNAME = '${principal.username}';
    const PHOTO = '${principal.photo}';

    var currentEmail = undefined;
    var currentPhone = undefined;
    var currentRow = undefined;

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    $(document).ready(function() {
        getOrders(1);

        if (selectedOrderId != '') {
            $.ajax({
                type : "GET",
                url : "/management/tasks/order/",
                data : { id : selectedOrderId },
                dataType : 'json',
                timeout : 100000,
                success : function(result) {
                    if (result != null && result.id != null) {
                        buildOrder(result);

                    } else {
                        var orderPage = new OrderBuilder(null, '', '');
                        var content = orderPage.buildOrder();
                        $('#orderContent').html(content);
                    }
                    $('.nav-tabs a[href="#order"]').tab('show');
                },
                error : function(e) {
                    console.log("ERROR: ", e);
                }

            });
        }
    });

    function isEmpty(value) {
        return (value == '' || value == null);
    }

    function updateOrderTable() {
        var page = 1;
        getOrders(page);
    }

    $('#count').change(function () {
        updateOrderTable();
    });

    $('#selectedStatus').change(function () {
        updateOrderTable();
    });
    $('#selectedState').change(function () {
        updateOrderTable();
    });

    function getOrders(page) {
        var status = $('#selectedStatus').val();
        var state = $('#selectedState').val();
        var count = $('#count').val();

        $.ajax({
            type : "GET",
            url : "/management/orders/" + USERNAME,
            data : { status : status, state : state, page : page, count : count},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {
                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    orders = result.list;

                    buildOrderTable(page, maxCount, count);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

    function buildOrderTable(page, maxCount, count) {
        $('#historyBlock').hide();

        var tbody = $('#ordersTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < orders.length; i++) {
            var order = orders[i];

            var id = order.id;
            var email = order.email;
            var phone = order.phone;
            var dateReceived = order.dateReceived;
            var state = order.state;
            var totalSum = order.totalSum;

            var row = '<tr id="rowId_' + id + '" onclick="onTableRowClick(' + id + ')" ' +
                    ' ondblclick="getOrderHistory(1, \'' + email + '\', \'' + phone + '\');" style="height: 60px; cursor : pointer">';

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
            row += '<td style="vertical-align: middle;     color: #777777; font-size: 12px;">' + dateReceived + '</td>';
            row += '<td style="vertical-align: middle">' + totalSum + ' руб.</td>';

            row += '</tr>';
            tbody.append(row);
        }

        if (maxCount > count) {
            var pagesCount = parseInt( Math.ceil( maxCount / count ) );

            $('#pagination').css('display', 'block');

            var pag_content = $('#paginationContent');
            pag_content.empty();

            if (page - 2 > 0) {
                pag_content.append('<a class="page" onclick="getOrders(' + 1 + ')" >1</a>');
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
                    pag_content.append('<a class="page" onclick="getOrders(' + i + ')" >' + i + '</a>')
                }
            }

            if (pagesCount - page > 1) {
                if (pagesCount - page > 2) {
                    pag_content.append('<span class="empty" >...</span>');
                }
                pag_content.append('<a class="page" onclick="getOrders(' + pagesCount + ')" >' + pagesCount + '</a>')
            }

        } else {
            $('#pagination').css('display', 'none');
        }
    }

    var DELAY = 320, clicks = 0, timer = null;
    function onTableRowClick(id) {

        clicks++;  //count clicks

        if(clicks === 1) {

            timer = setTimeout(function() {

                showOrder(id);
                selectTableRow('rowId_' + id);
                clicks = 0;             //after action performed, reset counter

            }, DELAY);

        } else {
            clearTimeout(timer);    //prevent single-click action
            selectTableRow('rowId_' + id);
            clicks = 0;             //after action performed, reset counter
        }

    }

    function selectTableRow(rowId) {

        if (currentRow != undefined) {
            $(currentRow).removeClass('table_selected_row');
        }

        currentRow = '#' + rowId;
        $(currentRow).addClass('table_selected_row');
    }

    function updateHistoryTable() {
        if ( (currentEmail != undefined) || (currentPhone != undefined) ) {
            getOrderHistory(1, currentEmail, currentPhone);
        }
    }

    $('#historyCount').change(function () {
        updateHistoryTable();
    });

    $('#historyState').change(function () {
        updateHistoryTable();
    });

    function getOrderHistory(page, email, phone) {
        var state = $('#historyState').val();
        var count = $('#historyCount').val();

        $.ajax({
            type : "GET",
            url : "/management/orders/search/",
            data : { state : state, page : page, count : count, username : null, email : email, phone : phone},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    var historyOrders = result.list;

                    currentEmail = email;
                    currentPhone = phone;

                    buildHistoryTable(page, maxCount, count, historyOrders);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

    function buildHistoryTable(page, maxCount, count, historyOrders) {

        $('#historyBlock').css('display', 'block');
        var tbody = $('#historyTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < historyOrders.length; i++) {
            var order = historyOrders[i];

            var id = order.id;
            var email = order.email;
            var phone = order.phone;
            var dateReceived = order.dateReceived;
            var state = order.state;
            var totalSum = order.totalSum;

            var row = '<tr style="height: 60px">';

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
            row += '<td style="vertical-align: middle;     color: #777777; font-size: 12px;">' + dateReceived + '</td>';
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
                pag_content.append('<a class="page" onclick="getOrderHistory(' + 1 + ', \'' + currentEmail + '\', \'' + currentPhone + '\')" >1</a>');
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
                    pag_content.append('<a class="page" onclick="getOrderHistory(' + i + ', \'' + currentEmail + '\', \'' + currentPhone + '\')" >' + i + '</a>')
                }
            }

            if (pagesCount - page > 1) {
                if (pagesCount - page > 2) {
                    pag_content.append('<span class="empty" >...</span>');
                }
                pag_content.append('<a class="page" onclick="getOrderHistory(' + pagesCount + ', \'' + currentEmail + '\', \'' + currentPhone + '\')" >' + pagesCount + '</a>')
            }

        } else {
            $('#historyPag').css('display', 'none');
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
            row += '<td style="vertical-align: middle">' + sum + ' руб.</td>';

            row += '</tr>';
            tbody.append(row);
        }
    }

    function updateState(id, state) {
        $('#rowId_' + id).find('td:eq(2)').html( progressBarByState(state) );
    }

    function buildOrder(targetOrder) {
        $('#editContent').html('');
        var editTable = buildEditTable(targetOrder);
        $('#editContent').html(editTable);

        $('#orderContent').hide();
        var orderPage = new OrderBuilder(targetOrder, '${noImage}', '${location}');
        var orderPageContent = orderPage.buildOrder();
        $('#orderContent').html(orderPageContent);
        orderPage.restartDatePicker();

        $('#orderContent').show(320);
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

        buildOrder(targetOrder);
        $('.nav-tabs a[href="#order"]').tab('show');
    }

    function buildManagerBlock(username, photo) {
        var imgSrc = (isEmpty(photo)) ? '${noImage}' : ( '${location}' + photo );
        var login = '<span style="margin-left: 3px">' + username + '</span>';
        var result = '<a href="/user/' + username + '"><img src=' + imgSrc + ' style="max-width: 20px; max-height: 20px; border-radius : 2px; margin-top: -3px"></a>' + login;
        return result;
    }

    $('#reasonTemplate').change(function () {

        var value = $(this).val();
        $('#reason').val(value);

    });

    $('#orderTab').click(function (){
        if (isEmpty( $('#orderContent').html() )) {
            var orderPage = new OrderBuilder(null, '', '');
            var content = orderPage.buildOrder();
            $('#orderContent').html(content);
        }

    });

    // confirm rejection
    $('#rejectOrderButton').click( function() {
        var id = $('#targetId').val();
        var commentary = $('#targetCommentary').val();
        var reason = $('#reason').val();

        $.ajax({
            type : "POST",
            url : "/management/orders/reject/",
            data : { id : id, commentary : commentary, reason : reason},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                if (result != null) {
                    $('#reasonModal').modal('toggle'); //hide reasonModal

                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Уведомление';
                    var content = result.message;

                    showMessage(element, bodyHeight, caption, content);

                    if (result.success == true) {

                        var targetOrder = null;
                        for (var i = 0; i < orders.length; i++) {
                            var order = orders[i];
                            if (order.id == id) {
                                order.state = STATE_REJECTED;
                                order.commentary = commentary + '\nОтказано : ' + reason;

                                targetOrder = order;
                                break;
                            }
                        }
                        buildOrder(targetOrder);
                        console.log('=> ' + targetOrder);
                        addOrderToReminders(targetOrder);
                        updateState(targetOrder.id, targetOrder.state);
                    }
                }

            },
            error: function(e) {
                console.log(e);
            }
        });
    });



    function buildEditTable(order) {
        var products = order.products;

        currentProducts = [];
        products.forEach(function (product) {
            currentProducts.push( jQuery.extend(true, {}, product) );
        });

        var table = '<label class="control-label">Список товаров</label>';
        table += '<div class="table-responsive" style="font-size: 13px">';
        table += '<table class="table table-striped table-bordered table-hover" style="margin-bottom: 10px" >';
        table += '<thead>';
        table += '<tr><th style="text-align: center">#</th> <th></th> <th>Название</th> <th>Количество</th> <th>Цена</th> <th>Сумма</th> </tr>';
        table += '</thead>';
        table += '<tbody id="editTable">';

        for (var i = 0; i < products.length; i++) {
            var product = products[i];

            if (product.productId == null) continue;

            var id = product.id;
            var productId = product.productId;
            var name = product.name;
            var price = product.price;
            var count = product.count;
            var sum = (count * price).toFixed(2);

            var row = '<tr id="editTableRow_' + productId + '" style="height: 60px">';

            row += '<td style="vertical-align: middle; text-align: center">' + productId + '</td>';

            var imgSrc = (product.preview == '') ? '${noImage}' : ( '${location}' + product.preview );
            var imgElem = '<a href="/' + product.type + '/' + product.productId + '"><img src=' + imgSrc + ' style="max-width:36px; max-height: 42px"></a>';
            row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

            row += '<td style="vertical-align: middle">' + name + '</td>';
            row += '<td style="vertical-align: middle"><input id="count_' + productId + '" onkeyup="editTableUpdateSum(' + productId + ')" class="form-control input-sm" value="' + count + '"></td>';
            row += '<td style="vertical-align: middle" id="price_' + productId + '">' + price + '</td>';
            row += '<td style="vertical-align: middle" id="sum_' + productId + '">' + sum + '</td>';
            row += '<td style="vertical-align: middle; text-align: center">' +
                    '<i class="fa fa-close bad_color" onclick="deleteEditTableRow(' + productId + ')" style="cursor: pointer"></i>' +
                    '</td>';

            row += '</tr>';

            table += row;
        }

        table += '</tbody></table></div>';

        return table;

    }

    function editTableUpdateSum(id) {
        var price = parseFloat( $('#price_' + id).html() ) ;
        var count = parseInt( $('#count_' + id).val() );
        var sum = (price * count).toFixed(2);

        $('#sum_' + id).html(sum);

        for (var i = 0; i < currentProducts.length; i++) {
            if (currentProducts[i].productId === id) {
                currentProducts[i].count = count;
                break;
            }
        }
    }

    function addToEditTable(id, type, link, name, price) {

        if ( $('#editTableRow_' + id).length == 0) {

            var count = 1;
            var sum = count * price;

            var product = new Item(null, name, count, price, id, type, link);
            currentProducts.push(product);

            var row = '<tr id="editTableRow_' + id + '" style="height: 60px">';

            row += '<td style="vertical-align: middle; text-align: center">' + id + '</td>';

            var imgSrc = (link == '') ? '${noImage}' : ( '${location}' + link );
            var imgElem = '<a href="/' + type + '/' + id + '"><img src=' + imgSrc + ' style="max-width:36px; max-height: 42px"></a>';
            row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

            row += '<td style="vertical-align: middle">' + name + '</td>';
            row += '<td style="vertical-align: middle"><input id="count_' + id + '" class="form-control input-sm" onkeyup="editTableUpdateSum(' + id + ')" value="' + count + '"></td>';
            row += '<td style="vertical-align: middle" id="price_' + id + '">' + price + '</td>';
            row += '<td style="vertical-align: middle" id="sum_' + id + '">' + sum + '</td>';
            row += '<td style="vertical-align: middle; text-align: center">' +
                    '<i class="fa fa-close bad_color" onclick="deleteEditTableRow(' + id + ')" style="cursor: pointer"></i>' +
                    '</td>';

            row += '</tr>';

            $('#editTable').append(row);

        }
    }

    $('#productsName').keyup(function () {

        var input = $(this).val();
        findProductsByName(input, 1);

    });

    $('#saveProducts').click(function () {

        var id = $('#targetId').val();
        var products = [];

        $('#editTable > tr').each( function () {

            var productId = $(this).find('td:eq(0)').html();
            var count = $('#count_' + productId).val();

            var product = new Item(null, null, count, null, productId, null, null);
            products.push(product);
        });

        if (products.length > 0) {
            var order = new Order(id, null, null, null, null, null, null, null, null, null, null, null, products);

            $.ajax({
                type : "POST",
                url : "/management/orders/products/",
                contentType : 'application/json',
                data : JSON.stringify(order),
                dataType : 'json',
                timeout : 100000,
                success : function(result) {

                    if (result != null) {
                        var element = '#message';
                        var bodyHeight = $('html > body').height();
                        var caption = 'Уведомление';
                        var content = result.message;

                        showMessage(element, bodyHeight, caption, content);

                        if (result.success == true) {
                            $('#productMain').empty();

                            var totalSum = 0;

                            currentProducts.forEach(function (product){

                                if (isEmpty(product.productId)) return;

                                var productId = product.productId;
                                var image = product.preview;
                                var name = product.name;
                                var count = product.count;
                                var price = product.price;
                                var type = product.type;

                                var sum = (count * price).toFixed(2);
                                totalSum = ( parseFloat(totalSum) + parseFloat(sum) ).toFixed(2);

                                var product = new Item(null, name, count, price, productId, type, null);

                                var row = '<tr style="height: 60px">';

                                row += '<td style="vertical-align: middle; text-align: center">' + productId + '</td>';

                                var imgSrc = (image == '') ? '${noImage}' : ( '${location}' + image );
                                var imgElem = '<a href="/' + product.type + '/' + product.productId + '"><img src=' + imgSrc + ' style="max-width:36px; max-height: 42px"></a>';
                                row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

                                row += '<td style="vertical-align: middle">' + name + '</td>';
                                row += '<td style="vertical-align: middle">' + count + '</td>';
                                row += '<td style="vertical-align: middle">' + sum + ' руб.</td>';

                                row += '</tr>';

                                $('#productMain').append(row);

                            });

                            var orderId = parseInt($('#targetId').val());
                            for (var i = 0; i < orders.length; i++) {
                                if (orders[i].id === orderId) {

                                    orders[i].products = currentProducts;
                                    orders[i].totalSum = parseFloat(totalSum);
                                    break;
                                }
                            }

                            $('#targetTotalSum').val(totalSum + ' руб.');
                            $('#rowId_' + id).find('td:eq(6)').html( totalSum );

                            $('#editModal').modal('toggle');
                        }

                    }

                },
                error: function(e) {
                    console.log(e);
                }

            });

        } else {
            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Уведомление';
            var content = 'Необходимо указать как минимум 1 товар.';

            showMessage(element, bodyHeight, caption, content);
        }

    });

    function findProductsByName(input, page) {
        $.ajax({
            type : "GET",
            url : "/search/product/",
            data : { name : input, page : page},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {
                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    var products = result.list;


                    var tbody = $('#productTable').find('tbody');
                    tbody.empty();

                    for (var i = 0; i < products.length; i++) {
                        var product = products[i];

                        var id = product.id;
                        var name = product.name;
                        var price = product.price;

                        var row = '<tr onclick="addToEditTable(' + id + ', \'' + product.type + '\', \'' + product.link + '\',\'' + name + '\',' + price + ')"' +
                        ' style="height: 60px; cursor : pointer">';

                        row += '<td class="text-center" style="vertical-align: middle">' + id + '</td>';


                        var imgSrc = (product.link == '') ? '${noImage}' : ( '${location}' + product.link );
                        var imgElem = '<a href="/' + product.type + '/' + product.id + '"><img src=' + imgSrc + ' style="max-width: 2em; max-height: 3em"></a>';
                        row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';



                        row += '<td style="vertical-align: middle">' + name + '</td>';
                        row += '<td style="vertical-align: middle">' + price + ' руб.</td>';

                        row += '</tr>';
                        tbody.append(row);
                    }

                    if (maxCount > count) {
                        var pagesCount = parseInt( Math.ceil( maxCount / count ) );

                        $('#pagProductRow').css('display', 'block');

                        var pag_content = $('#pagProductRowContent');
                        pag_content.empty();

                        if (page - 2 > 0) {
                            pag_content.append('<a class="page" onclick="findProductsByName(\'' + input + '\', ' + 1 + ')" >1</a>');
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
                                pag_content.append('<a class="page" onclick="findProductsByName(\'' + input + '\', ' + i + ')" >' + i + '</a>')
                            }
                        }

                        if (pagesCount - page > 1) {
                            if (pagesCount - page > 2) {
                                pag_content.append('<span class="empty" >...</span>');
                            }
                            pag_content.append('<a class="page" onclick="findProductsByName(\'' + input + '\', ' + pagesCount + ')" >' + pagesCount + '</a>')
                        }

                    } else {
                        $('#pagProductRow').css('display', 'none');
                    }
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });
    }

    function deleteEditTableRow(id) {
        $('#editTableRow_' + id).remove();

        var index = null;

        for (var i = 0; i < currentProducts.length; i++) {
            var product = currentProducts[i];

            if (product.productId === id) {
                index = i;
                break;
            }

        }

        currentProducts.splice(index, 1);
    }

</script>


</body>
</html>
