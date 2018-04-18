<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Mobile</title>

    <spring:url value="/pictures/no_photo.png" var="noImage"/>

    <spring:url value="/images/" var="location" />
</head>

<body>

    <table class="table product" style="width: 100%; margin-bottom: 1em; margin-top: 0.4em">
        <tbody>

            <c:if test="${!empty product.year || !empty product.platform || !empty product.osVersion}">
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

                <c:if test="${!empty product.platform}">
                    <tr>
                        <td>Платформа</td>
                        <td>${product.platform}</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.osVersion}">
                    <tr>
                        <td>Версия ОС</td>
                        <td>${product.osVersion}</td>
                    </tr>
                </c:if>

            </c:if>

            <c:if test="${!empty product.screenTech || !empty product.screenDiag || !empty product.screenResol}">
                <tr class="caption">
                    <td colspan="2">
                        Экран
                    </td>
                </tr>


                <c:if test="${!empty product.screenTech}">
                    <tr>
                        <td>Технология экрана</td>
                        <td>${product.screenTech}</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.screenDiag}">
                    <tr>
                        <td>Диагональ экрана</td>
                        <td>${product.screenDiag}"</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.screenResol}">
                    <tr>
                        <td>Разрешение экрана </td>
                        <td>${product.screenResol}</td>
                    </tr>
                </c:if>

            </c:if>

            <c:if test="${!empty product.procFreq || !empty product.procCores || !empty product.procName
                            || !empty product.accelerator}">

                <tr class="caption">
                    <td colspan="2">
                        Процессор
                    </td>
                </tr>

                <c:if test="${!empty product.procFreq}">
                    <tr>
                        <td>Частота процессора</td>
                        <td>${product.procFreq} МГц</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.procCores}">
                    <tr>
                        <td>Количество ядер процессора</td>
                        <td>${product.procCores}</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.procName}">
                    <tr>
                        <td>Процессор</td>
                        <td>${product.procName}</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.accelerator}">
                    <tr>
                        <td>Графический процессор</td>
                        <td>${product.accelerator}</td>
                    </tr>
                </c:if>

            </c:if>

            <c:if test="${!empty product.ram || !empty product.memory || !empty product.supportSd}">
                <tr class="caption">
                    <td colspan="2">
                        Память
                    </td>
                </tr>

                <c:if test="${!empty product.ram}">
                    <tr>
                        <td>Объем оперативной памяти</td>
                        <td><fmt:formatNumber pattern="#.##" value="${product.ram / 1000}" /> Гб</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.memory}">
                    <tr>
                        <td>Объем внутренней памяти</td>
                        <td><fmt:formatNumber pattern="#.##" value="${product.memory / 1000}" /> Гб</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.supportSd}">
                    <tr>
                        <td>Поддержка карт памяти</td>
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
                    </tr>
                </c:if>

            </c:if>

            <c:if test="${!empty product.camera || !empty product.frontCamera || !empty product.video
                            || !empty product.flash || !empty product.autoFocus}">

                <tr class="caption">
                    <td colspan="2">
                        Камера
                    </td>
                </tr>

                <c:if test="${!empty product.camera}">
                    <tr>
                        <td>Разрешение основной камеры</td>
                        <td>${product.camera} Мп</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.frontCamera}">
                    <tr>
                        <td>Разрешение фронтальной камеры</td>
                        <td>${product.frontCamera} Мп</td>
                    </tr>
                </c:if>

                <c:if test="${!empty product.video}">
                    <tr>
                        <td>Запись видео</td>
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
                    </tr>
                </c:if>

                <c:if test="${!empty product.flash}">
                    <tr>
                        <td>Вспышка</td>
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
                    </tr>
                </c:if>

                <c:if test="${!empty product.autoFocus}">
                    <tr>
                        <td>Автофокус</td>
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
                    </tr>
                </c:if>

            </c:if>

            <c:if test="${!empty product.width || !empty product.thickness || !empty product.height
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

                <c:if test="${!empty product.thickness}">
                    <tr>
                        <td>Толщина</td>
                        <td>${product.thickness} см</td>
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
                        <td>Вес, г</td>
                        <td>${product.weight}</td>
                    </tr>
                </c:if>

            </c:if>

            <c:if test="${!empty product.battery}">
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

            </c:if>

        </tbody>
    </table>

</body>

</html>