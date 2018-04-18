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
                      Создание товара
                  </div>
                  <div class="panel-body" style="padding: 0">
                      <div class="row">
                          <div class="col-lg-12">

                              <!-- /.panel-heading -->
                              <div class="panel-body">
                                  <!-- Nav tabs -->
                                  <ul class="nav nav-tabs">
                                      <li class="active"><a href="#constructor" data-toggle="tab"><i class="fa fa-wrench fa-fw"></i> Конструктор</a>
                                      </li>
                                      <li><a href="#download" data-toggle="tab"><i class="fa fa-arrow-circle-down fa-fw"></i> Загрузить</a>
                                      </li>

                                  </ul>

                                  <!-- Tab panes -->
                                  <div class="tab-content" style="border-left: 1px solid #ddd;border-right: 1px solid #ddd;border-bottom: 1px solid #ddd; padding-top: 0; margin-top: 0">
                                      <div class="tab-pane fade in active" id="constructor">
                                          <div class="form-group" style="margin-top: 0; margin-bottom: 0; padding: 0.5em 1em">

                                              <form:form method="POST" action="/management/stock/create/${type}" enctype="multipart/form-data" commandName="product">

                                                  <div>
                                                      <div class="row no_lr_margin border_bottom">
                                                          <div class="col-lg-6 col-sm-6 col-xs-12 vertical_align xs_transform_cell">Товар</div>

                                                          <div class="col-lg-6 col-sm-6 col-xs-12 cell">
                                                              <jsp:include page="change_product.jsp" />
                                                          </div>
                                                      </div>
                                                  </div>

                                                  <jsp:include page="constructor/${type}.jsp" />

                                                  <div>
                                                      <div class="row no_lr_margin">
                                                          <div class="col-lg-12 cell">
                                                              <form:button class="btn btn-default pull-right disable_focus">
                                                                  <i class='fa fa-plus'></i> Создать товар
                                                              </form:button>
                                                          </div>
                                                      </div>
                                                  </div>

                                              </form:form>

                                          </div>
                                      </div>
                                      <div class="tab-pane fade" id="download">
                                          <div class="form-group" style="margin-top: 0; margin-bottom: 0.5em; padding: 0.5em 1em">

                                              <div style="margin-top: 5px">
                                                  <div class="row no_lr_margin">
                                                      <div class="col-lg-10 col-sm-9 col-xs-12 vertical_align xs_transform_cell">
                                                          <input class="form-control" type="text" name="link" placeholder="Введите ссылку на товар">
                                                      </div>

                                                      <div class="col-lg-2 col-sm-3 col-xs-12 cell">
                                                          <button type="button" id="ajax_submit" class="btn btn-default disable_focus" style="width: 100%">
                                                              <i class="fa fa-arrow-circle-down"></i> Загрузить
                                                          </button>
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

  //allows to parse data from external link

  $(document).ready(function() {

    $('#ajax_submit').click(function() {

      var url = $('input[name="link"]').val();
      getDataFromUrl(url);
    });
  });

  // change product type
  $('#current_product').change(function () {
      var target = $(this).find(":selected").val();
      location.href = "/management/stock/create/" + target;
  });

  function getDataFromUrl(url){
    $.ajax({
      type : "POST",
      url : "/management/stock/parse_page/",
      data : { url : url, productType : '${type}'},
      dataType : 'json',
      timeout : 100000,
      success : function(result) {
          resetProductForm();
          $('#ajax_submit').html('<i class="fa fa-arrow-circle-down"></i> Загрузить');

          for(var field in result) {

              var value = result[field];

              if (value == null) continue;

              if (field == 'images') {

                  for (var i = 0; i < value.length; i++) {
                      var image = value[i];
                      var link = (image.link != '') ? image.link : '${noImage}';
                      var position = image.position;

                      $('#imagesList' + position).attr("src", link);
                      $('#source' + position).val(image.link); //
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

      },
      error : function(e) {
          console.log("ERROR: ", e);
          $('#ajax_submit').html('<i class="fa fa-arrow-circle-down"></i> Загрузить');
      },
      beforeSend : function(e) {
          $('#ajax_submit').html('<i class="fa fa-spinner fa-spin"></i>');
      }

    });
  }

  // reset fields from form
  function resetProductForm() {
      $('form#product :input').each(function () {
          if ( ($(this).attr('name') != '_csrf') && ($(this).attr('id') != 'current_product') ) {
              $(this).val('');
          }
      });

      $('form#product').find('.has-error').each(function () {
          $(this).removeClass('has-error');
          $(this).find('span[id*=".errors"]').remove();
      });

      $('form#product .previewImage').each(function () {
          $(this).attr('src', '${noImage}');
      });

      $("#sortable").html(sortableCache).sortable("refresh");
      resetFileValidators();
      attachFilesToImages();

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
