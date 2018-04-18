<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
    <title>iShop</title>

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

<div id="header"> <jsp:include page="header.jsp" /> </div>


<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <ol class="breadcrumb">
                <li><i class="fa fa-home"></i></li>
                <li class="active">Главная страница</li>
            </ol>
        </div>
    </div>
</div>

<div class="container" style="margin-bottom: 10px">
    <div class="row">
        <div class="col-lg-12">
            <h2 class="page-header" style="margin-top: 0">Предлагаемые товары</h2>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="margin-bottom: 5px">
            <a href="/mobile/" class="disable_color">
                <div class="panel panel-default text-center">
                    <div class="panel-heading vertical_align" style="height: 250px; justify-content: center">
                        <img src="/pictures/mob.jpg" style="max-width: 80%; max-height: 100%;">
                    </div>
                    <div class="panel-body">
                        <h4>Мобильные телефоны</h4>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" style="margin-bottom: 5px">
            <a href="/notebook/" class="disable_color">
                <div class="panel panel-default text-center">
                    <div class="panel-heading vertical_align" style="height: 250px; justify-content: center">
                        <img src="/pictures/notebooks.png" style="max-width: 80%; max-height: 100%">
                    </div>
                    <div class="panel-body">
                        <h4>Ноутбуки</h4>
                    </div>
                </div>
            </a>
        </div>
    </div>

</div>


<div id="footer"> <jsp:include page="footer.jsp" /> </div>

<!-- Bootstrap Core JavaScript -->
<spring:url value="/resources/vendor/bootstrap/js/bootstrap.min.js" var="bootstrapjs" />
<script src="${bootstrapjs}"></script>

</body>
</html>