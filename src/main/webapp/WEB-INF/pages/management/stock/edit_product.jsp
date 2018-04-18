<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>iShop</title>

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

</head>
<body>

<div id="wrapper">

    <jsp:include page="../menu.jsp" />

    <div id="page-wrapper">

        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Управление товарами</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Изменение товара
                    </div>
                    <div class="panel-body" style="padding: 0">
                        <div class="row">
                            <div class="col-lg-12">

                                <!-- /.panel-heading -->
                                <div class="panel-body">
                                    <!-- Nav tabs -->
                                    <ul class="nav nav-tabs">
                                        <li ${auto_show == true ? 'class="active"' : ''}><a href="#constructor" data-toggle="tab"><i class="fa fa-wrench fa-fw"></i> Конструктор</a>
                                        </li>
                                        <li ${auto_show == false ? 'class="active"' : ''}><a href="#select" data-toggle="tab"><i class="fa fa-search fa-fw"></i> Подобрать</a>
                                        </li>

                                    </ul>

                                    <!-- Tab panes -->
                                    <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0">
                                        <div class="tab-pane fade ${auto_show == true ? 'in active' : ''}" id="constructor">
                                            <div class="form-group" style="margin-top: 0; margin-bottom: 0; padding: 0.5em 1em">

                                                <form:form method="POST" action="/management/stock/update/${type}" enctype="multipart/form-data" commandName="product" id="productForm">

                                                    <form:hidden path="id" id="id"/>
                                                    <table class="table t_constructor" style="width: 100%; margin-bottom: 0">
                                                        <tbody>

                                                        <jsp:include page="constructor/${type}.jsp" />

                                                        <tr>
                                                            <td colspan="2" style="padding-top: 0">

                                                                <button type="button" class="btn btn-default pull-right disable_focus" style="margin-left: 8px; margin-top: 8px"
                                                                        data-toggle="modal" data-target="#modalConfirmDel">
                                                                    <i class='fa fa-remove'></i> Удалить товар
                                                                </button>

                                                                <form:button type="submit" class="btn btn-default pull-right disable_focus" style="margin-top: 8px">
                                                                    <i class='fa fa-plus'></i> Сохранить
                                                                </form:button>
                                                            </td>
                                                        </tr>

                                                        </tbody>
                                                    </table>
                                                </form:form>

                                            </div>
                                        </div>
                                        <div class="tab-pane fade ${auto_show == false ? 'in active' : ''}" id="select">
                                            <div class="form-group" style="margin-top: 0; margin-bottom: 0.5em; padding: 0.5em 1em">

                                                <div class="row">
                                                    <div class="col-lg-6 col-md-6" style="margin-top: 1em">
                                                        <input id="search_name" class="form-control" type="text" name="link" placeholder="Введите название товара">
                                                    </div>
                                                    <div class="col-lg-6 col-md-6" style="margin-top: 1em">
                                                        <jsp:include page="change_product.jsp" />
                                                    </div>
                                                </div>

                                                <div class="table-responsive" style="margin-top: 1em">
                                                    <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="productTable">
                                                        <thead>
                                                        <tr>
                                                            <th style="text-align: center">#</th>
                                                            <th></th>
                                                            <th>Название</th>
                                                            <th>Цена</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>

                                                        </tbody>
                                                    </table>
                                                </div>
                                                <!-- /.table-responsive -->

                                                <div id="pagination_row" class="row" style="display: none">
                                                    <div class="col-lg-12">
                                                        <div id="pagination_content" class="custom_pagination pull-right" style="margin-bottom: 0">
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
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

    <!-- Modal confirm edit -->
    <div class="modal fade" id="modalConfirmDel" tabindex="-1" role="dialog" aria-labelledby="modalLabelConfirmEdit" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div id="" class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-times" style="font-size: 0.8em"></i>
                    </button>

                    <h4 class="modal-title" id="modalLabelConfirmDel">Подтверждение действия :</h4>
                </div>

                <div class="modal-body">
                    Вы действительно хотите удалить товар ?
                </div>

                <div class="modal-footer">
                    <button id="delConfirmBtn" class="btn btn-primary">
                        <i class="fa fa-check"></i>
                    </button>

                    <button onclick="$('#modalConfirmDel').find('.close').click();" class="btn btn-default">
                        <i class="fa fa-times"></i>
                    </button>
                </div>

            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal confirm edit-->


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

<!-- jQuery UI JavaScript -->
<spring:url value="/resources/vendor/jquery/jquery-ui_min.js" var="ui" />
<script src="${ui}"></script>

<!-- JSON objects JavaScript -->
<spring:url value="/resources/js/model.js" var="model" />
<script src="${model}"></script>

<!-- Upload File Validator -->
<!-- We have to define method resetPreviewByValidator(element) -->
<spring:url value="/resources/js/upl_file_validator.js" var="file_validator" />
<script src="${file_validator}"></script>

<!-- Input validation -->
<spring:url value="/resources/js/input_validator.js" var="input_validator" />
<script src="${input_validator}"></script>

<script>

    "use strict";

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    $(document).ready(function() {
        // autoshow message
        var auto_show = '${success}';

        if (auto_show == 'true') {
            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Уведомление';
            var content = 'Товар успешно <b>сохранен</b>.';

            showMessage(element, bodyHeight, caption, content);
        }
    });

    $("#productForm").submit(function(e){
        var id = $('#id').val();
        if (isEmpty(id)) {
            showMSG('Ошибка', 'Вы не выбрали <b>товар</b>.');
            e.preventDefault();
        }

    });

    // change product type
    $('#current_product').change(function () {
        var target = $(this).find(":selected").val();
        location.href = "/management/stock/edit/" + target;
    });

    //delete selected product
    $('#delConfirmBtn').click(function () {

        var id = $('#id').val();

        if (id != '') {

            $.ajax({
                type : "POST",
                url : "/management/stock/remove/",
                data : { id : id},
                timeout : 100000,
                success : function(result) {
                    if (result == true) {

                        $('#modalConfirmDel').find('.close').click();
                        resetProductForm();

                        $('#productRowId' + id).remove();

                        var element = '#message';
                        var bodyHeight = $('html > body').height();
                        var caption = 'Уведомление';
                        var content = 'Товар успешно <b>удален</b>.';

                        showMessage(element, bodyHeight, caption, content);
                    }
                },
                error : function(e) {
                    console.log("ERROR: ", e);
                }

            });
        } else {
            $('#modalConfirmDel').find('.close').click();

            var element = '#message';
            var bodyHeight = $('html > body').height();
            var caption = 'Ошибка';
            var content = 'Вы не выбрали <b>товар</b>.';

            showMessage(element, bodyHeight, caption, content);
        }

    });

    // reset fields from form
    function resetProductForm() {
        $('form#productForm :input').each(function () {
            if ($(this).attr('name') != '_csrf') {
                $(this).val('');
            }
        });

        $('form#productForm').find('.has-error').each(function () {
            $(this).removeClass('has-error');
            $(this).find('span[id*=".errors"]').remove();
        });

        $("#sortable").html(sortableCache).sortable("refresh");

        $('form#productForm .previewImage').each(function () {
            $(this).attr('src', '${noImage}');

            var linkElement = $(this).attr('id').replace('imagesList', 'link');
            var imgIdElement = $(this).attr('id').replace('imagesList', 'imgId');

            $('#' + linkElement).val('');
            $('#' + imgIdElement).val('');
        });

        attachFilesToImages();
    }

    $('#search_name').keyup(function () {

        var input = $(this).val();
        var type = $('#current_product').val();

        if (input != '') getProductsByName(input, type, 1);

    });

    function getProductsByName(input, type, page) {

        $.ajax({
            type : "GET",
            url : "/management/stock/search/",
            data : { name : input, type : type, page : page},
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

                        var row = '<tr id="productRowId' + id + '" onclick="fillData(' + id +', \'' + type + '\')" style="height: 60px; cursor : pointer">';

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

                        $('#pagination_row').css('display', 'block');

                        var pag_content = $('#pagination_content');
                        pag_content.empty();

                        if (page - 2 > 0) {
                            pag_content.append('<a class="page" onclick="getProductsByName(\'' + input + '\', \'' + type + '\', ' + 1 + ')" >1</a>');
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
                                pag_content.append('<a class="page" onclick="getProductsByName(\'' + input + '\',\'' + type + '\',' + i + ')" >' + i + '</a>')
                            }
                        }

                        if (pagesCount - page > 1) {
                            if (pagesCount - page > 2) {
                                pag_content.append('<span class="empty" >...</span>');
                            }
                            pag_content.append('<a class="page" onclick="getProductsByName(\'' + input + '\', \'' + type + '\', ' + pagesCount + ')" >' + pagesCount + '</a>')
                        }

                    } else {
                        $('#pagination_row').css('display', 'none');
                    }


                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

    function isEmpty(value) {
        return ( (value == '') || (value == undefined) || (value == null) );
    }

    function fillData(id, type) {

        $.ajax({
            type : "GET",
            url : "/management/stock/",
            data : { id : id },
            dataType : 'json',
            timeout : 100000,
            success : function(result) {
                if (result != null) {
                    resetProductForm();

                    for(var field in result) {

                        var value = result[field];

                        if (value == null) continue;

                        if (field == 'images') {

                            for (var i = 0; i < value.length; i++) {
                                var image = value[i];
                                var link = (!isEmpty(image.link)) ? ('${location}' + image.link) : '${noImage}';
                                var position = image.position;

                                $('#imagesList' + position).attr("src", link);
                                $('#link' + position).val(image.link);
                                $('#imgId' + position).val(image.id);
                                $('#imgType' + position).val(image.productType);
                                $('#position' + position).val(image.position);

                                var file = $('#input_file' + i);
                                file.wrap('<form>').closest('form').get(0).reset();
                                file.unwrap();

                            }

                            continue;
                        }

                        var element = $('#' + field);
                        if (element.is('input')) element.val(value);
                        else {
                            if (value == true) element.val('true');
                            else element.val('false');
                        }

                        $('.nav-tabs a[href="#constructor"]').tab('show');
                    }

                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }
        });
    }

    //this function allows to sort uploaded images
    $('#sortable').sortable({
        axis : 'x',
        cursor: "move",
        revert : '65',
        tolerance: "pointer",
        helper : "clone",
        update : function(event, ui){

            var productOrder = $(this).sortable('toArray');

            for (var i = 0; i < productOrder.length; i++) {
                var pos = productOrder[i].replace('item', '');
                $('#position' + pos).val(i);
            }

        }
    }).disableSelection();
    var sortableCache = $("#sortable").html();

    // this method allows to preview uploaded images from file-manager
    function readURL(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {

                //delete sources link
                var source = '#' + $(input).attr('id').replace('input_file', 'source');
                $(source).val('');

                var img = '#' + $(input).attr('id').replace('input_file', 'imagesList');
                $(img).attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    function attachFilesToImages() {
        $("input:file").change(function(){
            readURL(this);
        });

        $("label[for^='imagesList']").on("click", function(e){
            var removeImg = $('#' + $(this).attr('for'));
            removeImg.attr('src', '${noImage}');

            var source = $('#' + $(this).attr('for').replace('imagesList', 'source'));
            source.val('');

            var link = $('#' + $(this).attr('for').replace('imagesList', 'link'));
            link.val('');

            var removeFile = $('#' + $(this).attr('for').replace('imagesList', 'input_file'));
            removeFile.wrap('<form>').closest('form').get(0).reset();
            removeFile.unwrap();
        });
    }

    attachFilesToImages();

    function resetPreviewByValidator(elementId) {
        var resetElement = '#' + elementId.replace('input_file', 'reset');
        $(resetElement).click();
    }

</script>


</body>
</html>
