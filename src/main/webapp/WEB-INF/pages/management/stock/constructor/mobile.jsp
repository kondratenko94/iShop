<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Цена</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="price">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="price" cssClass="form-control ${typeDbl}" autocomplete="off" />
                    <form:errors path="price" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Бренд</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="brand">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="brand" cssClass="form-control" />
                    <form:errors path="brand" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-12">
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
                                            <form:input type="file" class="input_file" path="images[${status.index}].file"
                                                        id="input_file${status.index}"
                                                        style="display: none" />
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
                    <form:input path="year" cssClass="form-control ${typeInt}" />
                    <form:errors path="year" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Технология экрана</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="screenTech">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="screenTech" cssClass="form-control" />
                    <form:errors path="screenTech" cssClass="control-label" />
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
                    <form:input path="screenDiag" cssClass="form-control ${typeDbl}" />
                    <form:errors path="screenDiag" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>


<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Разрешение экрана</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="screenResol">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="screenResol" cssClass="form-control" />
                    <form:errors path="screenResol" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Платформа</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="platform">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="platform" cssClass="form-control" />
                    <form:errors path="platform" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Версия ОС</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="osVersion">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="osVersion" cssClass="form-control" />
                    <form:errors path="osVersion" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Частота процессора, МГц</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="procFreq">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="procFreq" cssClass="form-control ${typeInt}" />
                    <form:errors path="procFreq" cssClass="control-label" />
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
                    <form:input path="procCores" cssClass="form-control ${typeInt}" />
                    <form:errors path="procCores" cssClass="control-label" />
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
                    <form:input path="procName" cssClass="form-control" />
                    <form:errors path="procName" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Графический процессор</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="accelerator">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="accelerator" cssClass="form-control" />
                    <form:errors path="accelerator" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Объем оперативной памяти, Мб</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="ram">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="ram" cssClass="form-control ${typeInt}" />
                    <form:errors path="ram" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Объем внутренней памяти, Мб</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="memory">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="memory" cssClass="form-control ${typeInt}" />
                    <form:errors path="memory" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Поддержка карт памяти</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <form:select path="supportSd" class="form-control" id="supportSd">
                <option></option>
                <option value="true" ${product.supportSd == true ? 'selected="selected"' : ''}>Да</option>
                <option value="false" ${product.supportSd == false ? 'selected="selected"' : ''}>Нет</option>
            </form:select>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Разрешение основной камеры, Мп</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="camera">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="camera" cssClass="form-control ${typeDbl}" />
                    <form:errors path="camera" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Разрешение фронтальной камеры, Мп</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="frontCamera">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="frontCamera" cssClass="form-control ${typeDbl}" />
                    <form:errors path="frontCamera" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Запись видео</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <form:select path="video" class="form-control" id="video">
                <option></option>
                <option value="true" ${product.video == true ? 'selected="selected"' : ''}>Да</option>
                <option value="false" ${product.video == false ? 'selected="selected"' : ''}>Нет</option>
            </form:select>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Вспышка</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <form:select path="flash" class="form-control" id="flash">
                <option></option>
                <option value="true" ${product.flash == true ? 'selected="selected"' : ''}>Да</option>
                <option value="false" ${product.flash == false ? 'selected="selected"' : ''}>Нет</option>
            </form:select>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Автофокус</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <form:select path="autoFocus" class="form-control" id="autoFocus">
                <option></option>
                <option value="true" ${product.autoFocus == true ? 'selected="selected"' : ''}>Да</option>
                <option value="false" ${product.autoFocus == false ? 'selected="selected"' : ''}>Нет</option>
            </form:select>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Емкость аккумулятора, мАч</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="battery">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="battery" cssClass="form-control ${typeInt}" />
                    <form:errors path="battery" cssClass="control-label" />
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
                    <form:input path="width" cssClass="form-control ${typeDbl}" />
                    <form:errors path="width" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Толщина, см</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="thickness">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="thickness" cssClass="form-control ${typeDbl}" />
                    <form:errors path="thickness" cssClass="control-label" />
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
                    <form:input path="height" cssClass="form-control ${typeDbl}" />
                    <form:errors path="height" cssClass="control-label" />
                </div>
            </spring:bind>
        </div>
    </div>
</div>

<div>
    <div class="row no_lr_margin border_bottom">

        <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Вес, г</div>

        <div class="col-lg-6 col-sm-6 col-xs-12 cell">
            <spring:bind path="weight">
                <div class="${status.error ? 'has-error' : ''}">
                    <form:input path="weight" cssClass="form-control ${typeDbl}" />
                    <form:errors path="weight" cssClass="control-label" />
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


