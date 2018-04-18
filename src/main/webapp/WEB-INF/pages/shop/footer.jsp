<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>

</head>
<body>

<div class="container">

  <hr style="margin-top: 0">
  <div class="row">
    <div class="col-xs-12">
      <p class="text-muted text-center">© 2018 iShop</p>
    </div>
  </div>
</div>

<script>
    // Spring Security csrf protection (AJAX)
    $(function() {
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(header, token);
        });
    });
</script>

</body>
</html>
