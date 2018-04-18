<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Сравнения ноутбуков</title>

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
        <td>Тип</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.kind}">
                    <td>${product.kind}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
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
        <td>Операционная система</td>

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
        <td>Макс. разрешение экрана, точек</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.screenMaxResol}">
                    <td>${product.screenMaxResol}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Тип матрицы экрана</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.screenMatrix}">
                    <td>${product.screenMatrix}</td>
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
        <td>Серия процессора</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.procSeries}">
                    <td>${product.procSeries}</td>
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
        <td>Частота процессора</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.procFreq}">
                    <td>${product.procFreq} ГГц</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Turbo-частота процессора</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.procFreqTurbo}">
                    <td>${product.procFreqTurbo} ГГц</td>
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
                    <td><fmt:formatNumber value="${product.ram}" minFractionDigits="0" /> Гб</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Тип оперативной памяти</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.ramType}">
                    <td>${product.ramType}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>

    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Видео
        </td>
    </tr>

    <tr>
        <td>Тип графического адаптера</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.graphAdapterType}">
                    <td>${product.graphAdapterType}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Графический адаптер</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.graphAdapter}">
                    <td>${product.graphAdapter}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Встроенный графический адаптер</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.secondGraphAdapter}">
                    <td>${product.secondGraphAdapter}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>
    <tr>
        <td>Объем памяти графического адаптера</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.graphMemory}">
                    <td><fmt:formatNumber value="${product.graphMemory}" minFractionDigits="0" /> Гб</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Хранение/запись информации
        </td>
    </tr>

    <tr>
        <td>Тип жесткого диска</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.hdiskType}">
                    <td>${product.hdiskType}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>
    <tr>
        <td>Объем жесткого диска</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.hdiskCapacity}">
                    <td>${product.hdiskCapacity} Гб</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr class="caption">
        <td colspan="${products.size() + 1}" >
            Конструкция
        </td>
    </tr>

    <tr>
        <td>Цвет крышки</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.coverColor}">
                    <td>${product.coverColor}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Материал корпуса</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.bodyMaterial}">
                    <td>${product.bodyMaterial}</td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

    <tr>
        <td>Материал крышки</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.coverMaterial}">
                    <td>${product.coverMaterial}</td>
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
        <td>Глубина</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.depth}">
                    <td>${product.depth} см</td>
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
        <td>Вес</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.weight}">
                    <td>${product.weight} кг</td>
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

    <tr>
        <td>Запас энергии аккумулятора, Вт·ч</td>

        <c:forEach items="${products}" var="product">

            <c:choose>
                <c:when test="${!empty product.energyReserve}">
                    <td><fmt:formatNumber value="${product.energyReserve}" minFractionDigits="0" /></td>
                </c:when>

                <c:otherwise>
                    <td>${minus}</td>
                </c:otherwise>
            </c:choose>

        </c:forEach>
    </tr>

</body>

</html>