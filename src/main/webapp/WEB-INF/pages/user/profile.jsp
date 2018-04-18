<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Профиль</title>

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
                <li class="active">Профиль пользователя</li>
            </ol>
        </div>
    </div>
</div>



<div class="container">

    <div class="row">
        <div class="col-lg-12">

            <div class="panel-body" style="padding: 0">

                <!-- Nav tabs -->
                <ul class="nav nav-tabs">
                    <li class="active"><a><i class="glyphicon glyphicon-user"></i> Профиль</a>
                    </li>
                    <li><a href="/profile/favourite"><i class="glyphicon glyphicon-heart"></i> Избранное</a>
                    </li>
                    <li><a href="/profile/reviews"><i class="glyphicon glyphicon-edit"></i> Отзывы</a>
                    </li>
                    <li><a href="/profile/settings"><i class="fa fa-wrench"></i> Настройки</a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0;">
                    <div class="tab-pane fade in active" style="padding: 16px 14px">

                        <div class="row">

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

                                <label class="btn btn-primary" style="margin-top: 1em" data-toggle="modal" data-target="#modalAvatar">
                                    <i class="glyphicon glyphicon-folder-open" style="margin-right: 5px"></i> Изменить аватар
                                </label>

                                <form method="post" action="/profile/photo" enctype="multipart/form-data">
                                    <!-- Modal -->
                                    <div class="modal fade text-left" id="modalAvatar" tabindex="-1" role="dialog" aria-labelledby="myModalAvatar" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                                                    <div>
                                                        <button type="button" class="close space_left" data-dismiss="modal" aria-hidden="true">
                                                            <i class="fa fa-times" style="font-size: 0.8em"></i>
                                                        </button>
                                                    </div>

                                                    <h4 class="modal-title" id="myModalAvatar">Установить аватар :</h4>
                                                </div>

                                                <div class="modal-body center-block" style="width: 100%; padding : 0">

                                                    <div class="vertical_align" style="position: relative; margin-top: .5em; height: 15em; width: 100%">

                                                        <c:choose>
                                                            <c:when test="${!empty user.photo}">
                                                                <img id="photoPreview" class="img-responsive center-block" src="${location}${user.photo}" style="border-radius: 5px; max-width: 100%; max-height: 100%">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img id="photoPreview" class="img-responsive center-block" src="${noImage}" style="border-radius: 5px; max-width: 100%; max-height: 100%">
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </div>

                                                    <div class="text-center" style="margin-bottom: .6em; margin-top: .5em">
                                                        <label class="btn btn-default">
                                                            <i class="glyphicon glyphicon-folder-open"></i>
                                                            <input type="file" class="input_file" name="file" id="input_file" style="display: none" />
                                                        </label>
                                                        <label id="reset" class="btn btn-default" for="photoPreview">
                                                            <i class="glyphicon glyphicon-remove"></i>
                                                        </label>
                                                    </div>

                                                    <sec:csrfInput/>
                                                </div>

                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fa fa-check"></i>
                                                    </button>

                                                    <button type="button" onclick="$('#modalAvatar').find('.close').click();" class="btn btn-default">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->
                                </form>


                            </div>

                            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
                                <b style="font-size: 20px; padding-left: 3px">${user.username}</b>
                                <i class="fa fa-id-card-o pull-right" style="cursor: pointer; margin-top: 6px" data-toggle="modal" data-target="#modalData"></i>

                                <form:form method="post" action="/profile/" commandName="updateUser">
                                    <!-- Modal -->
                                    <div class="modal fade text-left" id="modalData" tabindex="-1" role="dialog" aria-labelledby="myModalData" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <div class="modal-header alert-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px">

                                                    <div>
                                                        <button type="button" class="close space_left" data-dismiss="modal" aria-hidden="true">
                                                            <i class="fa fa-times" style="font-size: 0.8em"></i>
                                                        </button>
                                                    </div>

                                                    <h4 class="modal-title" id="myModalData">Персональные данные :</h4>
                                                </div>

                                                <div class="modal-body center-block" style="width: 100%; padding : 6px 16px">

                                                    <form:hidden path="username" />

                                                    <spring:bind path="surname">
                                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                                            <label class="control-label">Фамилия</label>
                                                            <form:input path="surname" type="text" class="form-control" autocomplete="off"
                                                                        id="surname" placeholder="Фамилия"/>
                                                            <form:errors path="surname" class="control-label" />
                                                        </div>
                                                    </spring:bind>

                                                    <spring:bind path="name">
                                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                                            <label class="control-label">Имя</label>
                                                            <form:input path="name" type="text" class="form-control" autocomplete="off"
                                                                        id="name" placeholder="Имя"/>
                                                            <form:errors path="name" class="control-label" />
                                                        </div>
                                                    </spring:bind>

                                                    <spring:bind path="patronymic">
                                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                                            <label class="control-label">Отчество</label>
                                                            <form:input path="patronymic" type="text" class="form-control" autocomplete="off"
                                                                        id="patronymic" placeholder="Отчество"/>
                                                            <form:errors path="patronymic" class="control-label" />
                                                        </div>
                                                    </spring:bind>

                                                    <spring:bind path="phone">
                                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                                            <label class="control-label">Телефон</label>
                                                            <form:input path="phone" type="text" class="form-control" autocomplete="off"
                                                                        id="phone" placeholder="Номер телефона"/>
                                                            <form:errors path="phone" class="control-label" />
                                                        </div>
                                                    </spring:bind>

                                                    <spring:bind path="address">
                                                        <div class="form-group ${status.error ? 'has-error' : ''}">
                                                            <label class="control-label">Адрес</label>
                                                            <form:input path="address" type="text" class="form-control" autocomplete="off"
                                                                        id="address" placeholder="Адрес"/>
                                                            <form:errors path="address" class="control-label" />
                                                        </div>
                                                    </spring:bind>

                                                </div>

                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fa fa-check"></i>
                                                    </button>

                                                    <button type="button" onclick="$('#modalData').find('.close').click();" class="btn btn-default">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <!-- /.modal-content -->
                                        </div>
                                        <!-- /.modal-dialog -->
                                    </div>
                                    <!-- /.modal -->
                                </form:form>

                                <table class="table">
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

                                    <c:if test="${!empty user.email}">
                                        <tr>
                                            <td>E-mail :</td>
                                            <td>${user.email}</td>
                                        </tr>
                                    </c:if>

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

                                    <c:if test="${!empty user.surname}">
                                        <tr>
                                            <td>Фамилия :</td>
                                            <td>${user.surname}</td>
                                        </tr>
                                    </c:if>

                                    <c:if test="${!empty user.name}">
                                        <tr>
                                            <td>Имя :</td>
                                            <td>${user.name}</td>
                                        </tr>
                                    </c:if>

                                    <c:if test="${!empty user.patronymic}">
                                        <tr>
                                            <td>Отчество :</td>
                                            <td>${user.patronymic}</td>
                                        </tr>
                                    </c:if>

                                    <c:if test="${!empty user.phone}">
                                        <tr>
                                            <td>Телефон :</td>
                                            <td>${user.phone}</td>
                                        </tr>
                                    </c:if>

                                    <c:if test="${!empty user.address}">
                                        <tr>
                                            <td>Адрес :</td>
                                            <td>${user.address}</td>
                                        </tr>
                                    </c:if>

                                    </tbody>
                                </table>

                            </div>

                        </div>

                    </div>
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.col-lg-12 -->
    </div>

</div>


<div id="footer"> <jsp:include page="../shop/footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

<!-- Upload File Validator -->
<!-- We have to define method resetPreviewByValidator(element) -->
<spring:url value="/resources/js/upl_file_validator.js" var="file_validator" />
<script src="${file_validator}"></script>

<script>

    "use strict";

    $(document).ready( function () {

        var showDataModal = '${autoShowModal}';
        if (showDataModal) {
            $('#modalData').modal('toggle');
        }
    });

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


    // this method allows to preview uploaded images from file-manager
    function readURL(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                var img = '#' + $(input).attr('id').replace('input_file', 'imagesList');
                $('#photoPreview').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("input:file").change(function(){
        readURL(this);
    });

    // reset file and img-src
    $("label[for^='photoPreview']").on("click", function(e){
        document.getElementById("input_file").value = "";
        $('#photoPreview').attr('src', '${noImage}');
    });

    function resetPreviewByValidator(elementId) {
        $('#photoPreview').attr('src', '${noImage}');
    }

</script>

</body>
</html>