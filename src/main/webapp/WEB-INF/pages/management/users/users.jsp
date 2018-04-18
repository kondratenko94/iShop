<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Персонал</title>

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
                <h1 class="page-header">Персонал</h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        Управление пользователями
                    </div>
                    <div class="panel-body" style="padding-top: 8px">
                        <div class="row">

                            <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                                <div class="vertical_align" style="float: left; margin-right: 10px; margin-top: 7px">
                                    <span style="float: left; margin-right: 5px">Группа :</span>
                                    <select id="group" class="form-control input-sm" style="width: 160px; float: left">
                                        <option value="">Все</option>
                                        <option value="chief">Владельцы</option>
                                        <option value="admin">Администраторы</option>
                                        <option value="moder">Модераторы</option>
                                        <option value="user">Пользователи</option>
                                    </select>
                                </div>

                                <div class="vertical_align" style="float: left; margin-top: 7px">
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

                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                <div class="vertical_align xs_pull_left" style="float:right; margin-top: 7px">
                                    <span style="float: left; margin-right: 5px">Поиск :</span>
                                    <input id="input" class="form-control input-sm" style="float: left; width: 120px"></div>
                            </div>

                        </div>
                        <!-- /.row (nested) -->

                        <div class="row" style="margin-top: 2px">
                            <div class="col-lg-12">
                                <div class="table-responsive" style="margin-top: 7px; font-size: 13px">
                                    <table class="table table-striped table-bordered table-hover" style="margin-bottom: 1em" id="userTable">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th>Логин</th>
                                                <th>Группа</th>
                                                <th>Телефон</th>
                                                <th>E-mail</th>
                                                <th>Фамилия</th>
                                                <th>Имя</th>
                                                <th>Отчество</th>
                                                <th>Адрес</th>
                                                <th>Статус</th>
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
    <div class="modal fade text-left" id="userData" tabindex="-1" role="dialog" aria-labelledby="myUserData" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                    <div>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <i class="fa fa-times" style="font-size: 0.8em"></i>
                        </button>
                    </div>

                    <h4 class="modal-title" id="myUserData">Персональные данные :</h4>
                </div>

                <div class="modal-body center-block" style="width: 100%; padding : 6px 16px">

                    <label class="control-label">Логин</label>
                    <input id="userLogin" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Группа</label>
                    <select id="userGroup" class="form-control space_bottom">
                        <option value="chief">Владельцы</option>
                        <option value="admin">Администраторы</option>
                        <option value="moder">Модераторы</option>
                        <option value="user">Пользователи</option>
                    </select>

                    <label class="control-label">Телефон</label>
                    <input id="userPhone" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">E-mail</label>
                    <input id="userEmail" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Фамилия</label>
                    <input id="userSurname" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Имя</label>
                    <input id="userName" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Отчество</label>
                    <input id="userPatronymic" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Адрес</label>
                    <input id="userAddress" class="form-control space_bottom" disabled="disabled">

                    <label class="control-label">Статус</label>
                    <input id="userStatus" class="form-control space_bottom" disabled="disabled">

                </div>

                <div class="modal-footer">
                    <button type="button" onclick="setRulesToUser()" class="btn btn-primary">
                        <i class="fa fa-check"></i>
                    </button>

                    <button type="button" onclick="$('#userData').find('.close').click();" class="btn btn-default">
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

    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });

    $(document).ready(function() {

        getUsersByInput('', 1);

    });

    function updateUserTable() {
        var input = $('#input').val();
        var page = 1;
        getUsersByInput(input, page);
    }

    $('#input').keyup(function (e) {
        updateUserTable();
    });

    $('#count').change(function () {
        updateUserTable();
    });

    $('#group').change(function () {
        updateUserTable();
    });

    function isEmpty(value) {
        return (value == '' || value == null);
    }

    function getUsersByInput(input, page) {

        var group = $('#group').val();
        var count = $('#count').val();

        $.ajax({
            type : "GET",
            url : "/management/users/search/",
            data : { input : input, group : group, page : page, count : count},
            dataType : 'json',
            timeout : 100000,
            success : function(result) {

                console.log(result);

                if (result != null) {
                    var count = result.count;
                    var maxCount = result.maxCount;
                    var users = result.list;

                    buildTable(input, page, users, maxCount, count);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

    function buildTable(input, page, users, maxCount, count) {
        var tbody = $('#userTable').find('tbody');
        tbody.empty();

        for (var i = 0; i < users.length; i++) {
            var user = users[i];

            var username = user.username;
            var photo = user.photo;
            var phone = isEmpty(user.phone) ? '' : user.phone;
            var email = isEmpty(user.email) ? '' : user.email;
            var group = user.group;
            var status = (user.status == true) ? 'Забанен' : 'Активен';

            var surname = isEmpty(user.surname) ? '' : user.surname;
            var name = isEmpty(user.name) ? '' : user.name;
            var patronymic = isEmpty(user.patronymic) ? '' : user.patronymic;
            var address = isEmpty(user.address) ? '' : user.address;

            var row = '<tr id="rowId_' + username + '" onclick="showUser(\'rowId_' + username + '\')" style="height: 60px; cursor : pointer">';

            var imgSrc = isEmpty(photo) ? '${noImage}' : ( '${location}' + photo );
            var imgElem = '<a target="_blank" href="/user/' + username + '"><img src=' + imgSrc + ' style="max-width: 28px; max-height: 28px; border-radius : 2px"></a>';
            row += '<td class="text-center" style="vertical-align: middle">' + imgElem + '</td>';

            row += '<td style="vertical-align: middle">' + username + '</td>';
            row += '<td style="vertical-align: middle">' + group + '</td>';
            row += '<td style="vertical-align: middle">' + phone + '</td>';
            row += '<td style="vertical-align: middle">' + email + '</td>';

            row += '<td style="vertical-align: middle">' + surname + '</td>';
            row += '<td style="vertical-align: middle">' + name + '</td>';
            row += '<td style="vertical-align: middle">' + patronymic + '</td>';
            row += '<td style="vertical-align: middle">' + address + '</td>';

            var statusColor = (user.status == true) ? 'bad_color' : '';
            row += '<td class="' + statusColor + '" style="vertical-align: middle">' + status + '</td>';

            row += '</tr>';
            tbody.append(row);
        }

        if (maxCount > count) {
            var pagesCount = parseInt( Math.ceil( maxCount / count ) );

            $('#pagination').css('display', 'block');

            var pag_content = $('#paginationContent');
            pag_content.empty();

            if (page - 2 > 0) {
                pag_content.append('<a class="page" onclick="getUsersByInput(\'' + input + '\', ' + 1 + ')" >1</a>');
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
                    pag_content.append('<a class="page" onclick="getUsersByInput(\'' + input + '\', ' + i + ')" >' + i + '</a>')
                }
            }

            if (pagesCount - page > 1) {
                if (pagesCount - page > 2) {
                    pag_content.append('<span class="empty" >...</span>');
                }
                pag_content.append('<a class="page" onclick="getUsersByInput(\'' + input + '\', ' + pagesCount + ')" >' + pagesCount + '</a>')
            }

        } else {
            $('#pagination').css('display', 'none');
        }
    }

    function showUser(rowId) {

        var userRow = $('#' + rowId);

        var i = 0;
        userRow.find('td').each(function () {
            var value = $(this).html();

            if (!isEmpty(value)) {
                if (i == 1) $('#userLogin').val(value);
                else if (i == 2) {

                    $('#userGroup').find("option").each(function (){
                        $(this).attr('selected', false);
                    });

                    var j = 0;
                    var selectedIndex = 0;
                    $("#userGroup").find("option").filter(function() {
                        if (this.text == value) {
                            selectedIndex = j;
                        }
                        j++;
                        return this.text == value;
                    }).attr('selected', true);

                    $('#userGroup').prop('selectedIndex', selectedIndex);
                }
                else if (i == 3) $('#userPhone').val(value);
                else if (i == 4) $('#userEmail').val(value);
                else if (i == 5) $('#userSurname').val(value);
                else if (i == 6) $('#userName').val(value);
                else if (i == 7) $('#userPatronymic').val(value);
                else if (i == 8) $('#userAddress').val(value);
                else if (i == 9) $('#userStatus').val(value);
            }

            i++;
        });

        $('#userData').modal('toggle');
    }


    function setRulesToUser() {
        var username = $('#userLogin').val();
        var role = $('#userGroup').val();

        $.ajax({
            type : "POST",
            url : "/management/users/role",
            data : { username : username, role : role},
            timeout : 100000,
            success : function(result) {

                if (result != null) {

                    if (result == 'Права пользователя успешно <b>изменены</b>.') {
                        var userRow = $('#rowId_' + username);
                        var groupName = $('#userGroup').find(':selected').text();

                        var groupTd = userRow.find('td:eq(2)');
                        groupTd.text(groupName);
                    }

                    var element = '#message';
                    var bodyHeight = $('html > body').height();
                    var caption = 'Уведомление';
                    var content = result;

                    showMessage(element, bodyHeight, caption, content);
                }

            },
            error : function(e) {
                console.log("ERROR: ", e);
            }

        });

    }

</script>


</body>
</html>
