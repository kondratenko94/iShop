<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<spring:url value="/pictures/no_photo.png" var="noImage"/>
<spring:url value="/images/" var="location" />

<c:set var="typeInt" value="val_int" scope="page"/>
<c:set var="typeDbl" value="val_dbl" scope="page"/>


<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Название</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="name">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="name" class="form-control" autocomplete="off" />
                    <form:errors path="name" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Производитель</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="producer">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="producer" class="form-control" autocomplete="off" />
                    <form:errors path="producer" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Цена</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="price">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="price" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="price" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">
        <div class="col-lg-12 ">
            <div class="container-fluid">
                <div class="row" id="sortable">
                    <c:if test="${!empty product.images}">
                        <c:forEach items="${product.images}" var="image" varStatus="status">

                            <div class="col-lg-5ths col-md-5ths col-sm-5ths col-xs-5ths vertical_align" id="item${status.index}" style="padding: 0 0 0 0">
                                <div class="item_block" style="justify-content: center">

                                    <c:set var="src" value="${noImage}"/>
                                    <c:choose>
                                        <c:when test="${!empty image.link}">
                                            <c:set var="src" value="${location.concat(image.link)}"/>
                                        </c:when>

                                        <c:when test="${!empty image.source}">
                                            <c:set var="src" value="${image.source}"/>
                                        </c:when>
                                    </c:choose>

                                    <div class="vertical_align auto_height">
                                        <img id="imagesList${status.index}" class="img-responsive center-block previewImage"
                                             src="${src}" style="max-width: 100%; max-height: 100%">
                                        <form:hidden path="images[${status.index}].id" id="imgId${status.index}" value="${image.id}"/>
                                        <form:hidden path="images[${status.index}].link" id="link${status.index}"/>
                                        <form:hidden path="images[${status.index}].source" id="source${status.index}"/>
                                        <form:hidden path="images[${status.index}].position" id="position${status.index}"/>
                                    </div>

                                    <div style="margin-top: 0.5em; display: inline-block">

                                        <label class="btn btn-success">
                                            <i class="glyphicon glyphicon-folder-open"></i>
                                            <form:input type="file" class="input_file" path="images[${status.index}].file" id="input_file${status.index}" style="display: none" />
                                        </label>
                                        <label id="reset${status.index}" class="btn btn-danger" for="imagesList${status.index}">
                                            <i class="glyphicon glyphicon-remove"></i>
                                        </label>

                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Дата выхода на рынок</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="year">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="year" cssClass="form-control ${typeInt}" autocomplete="off" />
                    <form:errors path="year" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Тип</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="kind">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="kind" cssClass="form-control" autocomplete="off" />
                    <form:errors path="kind" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Операционная система</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="osVersion">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="osVersion" cssClass="form-control" autocomplete="off" />
                    <form:errors path="osVersion" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Диагональ экрана, "</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="screenDiag">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="screenDiag" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="screenDiag" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Макс. разрешение экрана, точек</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="screenMaxResol">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="screenMaxResol" cssClass="form-control" autocomplete="off" />
                    <form:errors path="screenMaxResol" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Тип матрицы экрана</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="screenMatrix">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="screenMatrix" cssClass="form-control" autocomplete="off" />
                    <form:errors path="screenMatrix" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Серия процессора</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="procSeries">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="procSeries" cssClass="form-control" autocomplete="off" />
                    <form:errors path="procSeries" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Процессор</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="procName">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="procName" cssClass="form-control" autocomplete="off" />
                    <form:errors path="procName" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Количество ядер процессора</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="procCores">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="procCores" cssClass="form-control ${typeInt}" autocomplete="off" />
                    <form:errors path="procCores" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Частота процессора, ГГц</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="procFreq">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="procFreq" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="procFreq" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Turbo-частота процессора, ГГц</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="procFreqTurbo">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="procFreqTurbo" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="procFreqTurbo" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Объем оперативной памяти, Гб</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="ram">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="ram" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="ram" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Тип оперативной памяти</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="ramType">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="ramType" cssClass="form-control" autocomplete="off" />
                    <form:errors path="ramType" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Тип графического адаптера</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="graphAdapterType">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="graphAdapterType" cssClass="form-control" autocomplete="off" />
                    <form:errors path="graphAdapterType" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Графический адаптер</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="graphAdapter">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="graphAdapter" cssClass="form-control" autocomplete="off" />
                    <form:errors path="graphAdapter" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Объем памяти графического адаптера, Гб</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="graphMemory">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="graphMemory" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="graphMemory" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Встроенный графический адаптер</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="secondGraphAdapter">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="secondGraphAdapter" cssClass="form-control" autocomplete="off" />
                    <form:errors path="secondGraphAdapter" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Тип жесткого диска</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="hdiskType">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="hdiskType" cssClass="form-control" autocomplete="off" />
                    <form:errors path="hdiskType" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Объем жесткого диска, Гб</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="hdiskCapacity">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="hdiskCapacity" cssClass="form-control ${typeInt}" autocomplete="off" />
                    <form:errors path="hdiskCapacity" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Емкость аккумулятора, мАч</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="battery">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="battery" cssClass="form-control ${typeInt}" autocomplete="off" />
                    <form:errors path="battery" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Запас энергии аккумулятора, Вт·ч</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="energyReserve">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="energyReserve" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="energyReserve" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Цвет крышки</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="coverColor">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="coverColor" cssClass="form-control" autocomplete="off" />
                    <form:errors path="coverColor" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Материал корпуса</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="bodyMaterial">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="bodyMaterial" cssClass="form-control" autocomplete="off" />
                    <form:errors path="bodyMaterial" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Материал крышки</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="coverMaterial">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="coverMaterial" cssClass="form-control" autocomplete="off" />
                    <form:errors path="coverMaterial" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Ширина, см</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="width">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="width" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="width" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Глубина, см</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="depth">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="depth" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="depth" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Высота, см</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="height">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="height" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="height" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Вес, кг</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="weight">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="weight" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="weight" class="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">В наличии</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <form:select path="inStock" class="form-control" id="inStock">
                <option></option>
                <option value="true" ${product.inStock == true ? 'selected="selected"' : ''}>Да</option>
                <option value="false" ${product.inStock == false ? 'selected="selected"' : ''}>Нет</option>
            </form:select>
        </div>
    </div>
</div>