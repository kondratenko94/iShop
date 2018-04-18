<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Notebook</title>

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />
</head>

<body>

<table class="table product" style="width: 100%; margin-bottom: 1em; margin-top: 0.4em">
    <tbody>

        <c:if test="${!empty product.year || !empty product.kind || !empty product.osVersion}">

            <tr class="caption">
                <td colspan="2" >
                    Основные характеристики
                </td>
            </tr>

            <c:if test="${!empty product.year}">
                <tr>
                    <td>Дата выхода на рынок</td>
                    <td>${product.year} год</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.kind}">
                <tr>
                    <td>Тип</td>
                    <td>${product.kind}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.osVersion}">
                <tr>
                    <td>Операционная система</td>
                    <td>${product.osVersion}</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.screenDiag || !empty product.screenMaxResol || !empty product.screenMatrix}">

            <tr class="caption">
                <td colspan="2">
                    Экран
                </td>
            </tr>

            <c:if test="${!empty product.screenDiag}">
                <tr>
                    <td>Диагональ экрана</td>
                    <td>${product.screenDiag}"</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.screenMaxResol}">
                <tr>
                    <td>Макс. разрешение экрана, точек</td>
                    <td>${product.screenMaxResol}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.screenMatrix}">
                <tr>
                    <td>Тип матрицы экрана</td>
                    <td>${product.screenMatrix}</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.procSeries || !empty product.procName || !empty product.procCores
                        || !empty product.procFreq || !empty product.procFreqTurbo}">

            <tr class="caption">
                <td colspan="2">
                    Процессор
                </td>
            </tr>

            <c:if test="${!empty product.procSeries}">
                <tr>
                    <td>Серия процессора</td>
                    <td>${product.procSeries}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.procName}">
                <tr>
                    <td>Процессор</td>
                    <td>${product.procName}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.procCores}">
                <tr>
                    <td>Количество ядер процессора</td>
                    <td>${product.procCores}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.procFreq}">
                <tr>
                    <td>Частота процессора</td>
                    <td>${product.procFreq} ГГц</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.procFreqTurbo}">
                <tr>
                    <td>Turbo-частота процессора</td>
                    <td>${product.procFreqTurbo} ГГц</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.ram || !empty product.ramType}">
            <tr class="caption">
                <td colspan="2">
                    Память
                </td>
            </tr>

            <c:if test="${!empty product.ram}">
                <tr>
                    <td>Объем оперативной памяти</td>
                    <td><fmt:formatNumber value="${product.ram}" minFractionDigits="0" /> Гб</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.ramType}">
                <tr>
                    <td>Тип оперативной памяти</td>
                    <td>${product.ramType}</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.graphAdapterType || !empty product.graphAdapter || !empty product.secondGraphAdapter
                        || !empty product.graphMemory}">

            <tr class="caption">
                <td colspan="2">
                    Видео
                </td>
            </tr>

            <c:if test="${!empty product.graphAdapterType}">
                <tr>
                    <td>Тип графического адаптера</td>
                    <td>${product.graphAdapterType}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.graphAdapter}">
                <tr>
                    <td>Графический адаптер</td>
                    <td>${product.graphAdapter}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.secondGraphAdapter}">
                <tr>
                    <td>Встроенный графический адаптер</td>
                    <td>${product.secondGraphAdapter}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.graphMemory}">
                <tr>
                    <td>Объем памяти графического адаптера</td>
                    <td><fmt:formatNumber value="${product.graphMemory}" minFractionDigits="0"/> Гб</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.hdiskType || !empty product.hdiskCapacity}">

            <tr class="caption">
                <td colspan="2">
                    Хранение/запись информации
                </td>
            </tr>

            <c:if test="${!empty product.hdiskType}">
                <tr>
                    <td>Тип жесткого диска</td>
                    <td>${product.hdiskType}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.hdiskCapacity}">
                <tr>
                    <td>Объем жесткого диска</td>
                    <td>${product.hdiskCapacity} Гб</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.coverColor || !empty product.bodyMaterial || !empty product.coverMaterial}">

            <tr class="caption">
                <td colspan="2">
                    Конструкция
                </td>
            </tr>

            <c:if test="${!empty product.coverColor}">
                <tr>
                    <td>Цвет крышки</td>
                    <td>${product.coverColor}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.bodyMaterial}">
                <tr>
                    <td>Материал корпуса</td>
                    <td>${product.bodyMaterial}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.coverMaterial}">
                <tr>
                    <td>Материал крышки</td>
                    <td>${product.coverMaterial}</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${!empty product.width || !empty product.depth || !empty product.height
                        || !empty product.weight}">

            <tr class="caption">
                <td colspan="2">
                    Размеры и вес
                </td>
            </tr>

            <c:if test="${!empty product.width}">
                <tr>
                    <td>Ширина</td>
                    <td>${product.width} см</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.depth}">
                <tr>
                    <td>Глубина</td>
                    <td>${product.depth} см</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.height}">
                <tr>
                    <td>Высота</td>
                    <td>${product.height} см</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.weight}">
                <tr>
                    <td>Вес</td>
                    <td>${product.weight} кг</td>
                </tr>
            </c:if>


        </c:if>

        <c:if test="${!empty product.battery || !empty product.energyReserve}">
            <tr class="caption">
                <td colspan="2">
                    Аккумулятор
                </td>
            </tr>

            <c:if test="${!empty product.battery}">
                <tr>
                    <td>Емкость аккумулятора, мАч</td>
                    <td>${product.battery}</td>
                </tr>
            </c:if>

            <c:if test="${!empty product.energyReserve}">
                <tr>
                    <td>Запас энергии аккумулятора, Вт·ч</td>
                    <td><fmt:formatNumber value="${product.energyReserve}" minFractionDigits="0" /></td>
                </tr>
            </c:if>

        </c:if>

    </tbody>
</table>

</body>

</html>