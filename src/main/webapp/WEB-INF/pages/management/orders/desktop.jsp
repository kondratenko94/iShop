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
                <h1 class="page-header">Рабочий стол</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Стол заказов
                    </div>
                    <div class="panel-body" style="padding-top: 8px">
                        <div class="row">

                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="vertical_align xss_no_r_margin" style="float: left; margin-right: 10px; margin-top: 7px">
                                    <span style="float: left; margin-right: 5px">Статус :</span>
                                    <select id="selectedStatus" class="form-control input-sm" style="width: 145px; float: left">
                                        <option value="" selected="selected">Все</option>
                                        <option value="0">Открыты</option>
                                        <option value="1">Завершены</option>
                                    </select>
                                </div>

                                <div class="vertical_align xss_no_r_margin" style="float: left; margin-right: 10px; margin-top: 7px">
                                    <span style="float: left; margin-right: 5px">Состояние :</span>
                                    <select id="selectedState" class="form-control input-sm" style="width: 145px; float: left">
                                        <option value="" selected="selected">Все</option>
                                        <option value="0">Открытые</option>
                                        <option value="1">Принятые</option>
                                        <option value="2">В процессе</option>
                                        <option value="4">Завершенные</option>
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
                    <button type="button" id="acceptOrder" onclick="acceptOrder()" class="btn btn-primary">
                        <i class="fa fa-check"> Принять заказ</i>
                    </button>

                    <button type="button" onclick="$('#orderModal').modal('toggle');" class="btn btn-default">
                        <i class="fa fa-times"></i>
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

<script>

    "use strict";

    var orders;

    const USERNAME = '${principal.username}';
    const PHOTO = '${principal.photo}';

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    $(document).ready(function() {
        getOrders(1);
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

    $('#selectedState').change(function () {
        updateOrderTable();
    });
    $('#selectedStatus').change(function () {
        updateOrderTable();
    });

    function getOrders(page) {
        var status = $('#selectedStatus').val();
        var state = $('#selectedState').val();
        var count = $('#count').val();

        $.ajax({
            type : "GET",
            url : "/management/orders/",
            data : { status : status, state : state, page : page, count : count},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);

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

            var row = '<tr id="rowId_' + id + '" onclick="showOrder(' + id + ')" style="height: 60px; cursor : pointer">';

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

            if ( targetOrder.state != 0 ) {
                $('#acceptOrder').attr('disabled', 'disabled');
            } else {
                $('#acceptOrder').prop("disabled", false);
            }

            buildProductsTable(targetOrder.products);
            $('#orderModal').modal('toggle');
        }
    }

    function acceptOrder() {

        var orderId = $('#targetId').val();

        $.ajax({
            type : "POST",
            url : "/management/orders/accept",
            data : { orderId : orderId},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);

                if (result != null) {

                    if (result) {

                        $('#orderModal').modal('toggle');

                        for (var i = 0; i < orders.length; i++) {
                            var order = orders[i];
                            if (order.id == orderId) {
                                order.state = 1;
                                addOrderToReminders(order);
                                break;
                            }
                        }

                        var element = '#message';
                        var bodyHeight = $('html > body').height();
                        var caption = 'Уведомление';
                        var content = "Заказ успешно <b>принят</b>";
                        showMessage(element, bodyHeight, caption, content);

                        var row = $('#rowId_' + orderId);

                        var groupTd = row.find('td:eq(1)');
                        groupTd.html( buildManagerBlock(USERNAME, PHOTO) );

                        var statusTd = row.find('td:eq(2)');
                        statusTd.html( progressBarByState(1) );

                    } else {

                        var element = '#message';
                        var bodyHeight = $('html > body').height();
                        var caption = 'Уведомление';
                        var content = "Не удалось принять <b>заказ</b>.";
                        showMessage(element, bodyHeight, caption, content);
                    }

                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }


    function buildManagerBlock(username, photo) {
        var imgSrc = (isEmpty(photo)) ? '${noImage}' : ( '${location}' + photo );
        var login = '<span style="margin-left: 3px">' + username + '</span>';
        var result = '<a href="/user/' + username + '"><img src=' + imgSrc + ' style="max-width: 20px; max-height: 20px; border-radius : 2px; margin-top: -3px"></a>' + login;
        return result;
    }

</script>


</body>
</html>
