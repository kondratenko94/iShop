<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Сравнения мобильных телефонов</title>

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />

    <c:set value="-" var="minus" />

</head>

<body>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Основные характеристики
        </td>
    </tr>

    <tr>
        <td>Дата выхода на рынок</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.year}">
                    <td>${product.year} год</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Цена</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.price}">
                    <td><fmt:formatNumber pattern="#" minFractionDigits="2" value="${product.price}" /> Br</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Платформа</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.platform}">
                    <td>${product.platform}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Версия ОС</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.osVersion}">
                    <td>${product.osVersion}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Экран
        </td>
    </tr>

    <tr>
        <td>Технология экрана</td>
        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.screenTech}">
                    <td>${product.screenTech}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Диагональ экрана</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.screenDiag}">
                    <td>${product.screenDiag}"</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Разрешение экрана </td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.screenResol}">
                    <td>${product.screenResol}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Процессор
        </td>
    </tr>

    <tr>
        <td>Частота процессора</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.procFreq}">
                    <td>${product.procFreq} МГц</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Количество ядер процессора</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.procCores}">
                    <td>${product.procCores}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Процессор</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.procName}">
                    <td>${product.procName}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Графический процессор</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.accelerator}">
                    <td>${product.accelerator}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Память
        </td>
    </tr>

    <tr>
        <td>Объем оперативной памяти</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.ram}">
                    <td><fmt:formatNumber pattern="#.##" value="${product.ram / 1000}" /> Гб</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Объем внутренней памяти</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.memory}">
                    <td><fmt:formatNumber pattern="#.##" value="${product.memory / 1000}" /> Гб</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Поддержка карт памяти</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.supportSd}">
                    <td>
                        <c:choose>
                            <c:when test="${product.supportSd}">
                                <i class="fa fa-check green"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-times gray"></i>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>


        </c:forEach>

    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Камера
        </td>
    </tr>

    <tr>
        <td>Разрешение основной камеры</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.camera}">
                    <td>${product.camera} Мп</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Разрешение фронтальной камеры</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.frontCamera}">
                    <td>${product.frontCamera} Мп</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Запись видео</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.video}">
                    <td>
                        <c:choose>
                            <c:when test="${product.video}">
                                <i class="fa fa-check green"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-times gray"></i>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Вспышка</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.flash}">
                    <td>
                        <c:choose>
                            <c:when test="${product.flash}">
                                <i class="fa fa-check green"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-times gray"></i>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Автофокус</td>
        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.autoFocus}">
                    <td>
                        <c:choose>
                            <c:when test="${product.autoFocus}">
                                <i class="fa fa-check green"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-times gray"></i>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Размеры и вес
        </td>
    </tr>

    <tr>
        <td>Ширина</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.width}">
                    <td>${product.width} см</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Толщина</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.thickness}">
                    <td>${product.thickness} см</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Высота</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.height}">
                    <td>${product.height} см</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr>
        <td>Вес, г</td>
        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.weight}">
                    <td>${product.weight}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Аккумулятор
        </td>
    </tr>

    <tr>
        <td>Емкость аккумулятора, мАч</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.battery}">
                    <td>${product.battery}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>


</body>

</html>