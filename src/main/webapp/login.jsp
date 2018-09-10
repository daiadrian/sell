<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>在线点餐系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

<!-- Bootstrap style --> 
    <link id="callCss" rel="stylesheet" href="${pageContext.request.contextPath}/themes/bootshop/bootstrap.min.css" media="screen"/>
    <link href="${pageContext.request.contextPath}/themes/css/base.css" rel="stylesheet" media="screen"/>
<!-- Bootstrap style responsive -->	
	<link href="${pageContext.request.contextPath}/themes/css/bootstrap-responsive.min.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/themes/css/font-awesome.css" rel="stylesheet" type="text/css">
<!-- Google-code-prettify -->	
	<link href="${pageContext.request.contextPath}/themes/js/google-code-prettify/prettify.css" rel="stylesheet"/>
<!-- fav and touch icons -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/themes/images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-57-precomposed.png">
	<style type="text/css" id="enject"></style>

	  <!-- Placed at the end of the document so the pages load faster ============================================= -->
	  <script src="${pageContext.request.contextPath}/themes/js/jquery.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/themes/js/bootstrap.min.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/themes/js/google-code-prettify/prettify.js"></script>

	  <script src="${pageContext.request.contextPath}/themes/js/bootshop.js"></script>
	  <script src="${pageContext.request.contextPath}/themes/js/jquery.lightbox-0.5.js"></script>

	  <script src="${pageContext.request.contextPath}/other/jquery.alerts.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/other/jquery.cookie.js" type="text/javascript"></script>
	  <script type="text/javascript">
		  var redirectUrl = "${redirect}";
          var MYLOGIN = {
			  checkInput: function () {
				  if ($("#inputFname1").val() == "") {
					  $("#my_inputFname1").html("<font color='red'>手机号不能为空</font>");
					  return false;
				  }
				  if ($("#inputPassword1").val() == "") {
					  $("#my_inputPassword1").html("<font color='red'>密码不能为空</font>");
					  return false;
				  }
				  return true;
			  },
			  doLogin: function () {
				  $.ajax({
					  url: "http://localhost:8082/user/login",
					  type: "POST",
					  data: $("#myformlogin").serialize(),
					  dataType:"json",
					  async:false,
					  success: function(data){
						  if (data.status == 200) {
							  if (redirectUrl == "" || redirectUrl==undefined) {
								  window.location.href = "http://localhost:8082/index";
								  window.event.returnValue=false;
							  } else {
								  window.location.href = redirectUrl;
								  window.event.returnValue=false;
							  }
						  }
					  },
					  error:function () {
						  alert("错误");
					  }
				  });
			  },
			  login: function () {
				  if (this.checkInput()) {
					  this.doLogin();
				  }
			  }
		  };
	  </script>
  </head>
<body>
<div id="header">
	<div class="container">
		<jsp:include page="common/Header.jsp"></jsp:include>
<!-- Navbar ================================================== -->
		<jsp:include page="common/Navbar.jsp" />
</div>
</div>
<!-- Header End====================================================================== -->
<div id="mainBody">
	<div class="container">
	<div class="row">
<!-- Sidebar ================================================== -->
		<jsp:include page="common/Sidebar.jsp"></jsp:include>
<!-- Sidebar end=============================================== -->
	<div class="span9">
    <ul class="breadcrumb">
		<li><a href="${pageContext.request.contextPath}/index">Home</a> <span class="divider">/</span></li>
		<li class="active">Login</li>
    </ul>
	<h3> Login</h3>	
	<hr class="soft"/>
	
	<div class="row">
		<div class="span4" style="text-align: center">
			<div class="well">
			<h5>欢迎登录</h5>
			<form method="post" id="myformlogin">
			  <div class="control-group">
				<label class="control-label" for="inputEmail1">手机号</label>
				<div class="controls">
				  <input class="span3"  type="text" id="inputEmail1" placeholder="Username" name="username">
					<span id="my_inputFname1"></span>
				</div>
			  </div>
			  <div class="control-group">
				<label class="control-label" for="inputPassword1">密码</label>
				<div class="controls">
				  <input type="password" class="span3"  id="inputPassword1" placeholder="Password" name="password">
					<span id="my_inputPassword1"></span>
				</div>
			  </div>
			  <div class="control-group">
				<div class="controls">
				  <button class="btn" onclick="MYLOGIN.login()" id="login_sub">登录</button><button class="btn"><a href="${pageContext.request.contextPath}/userReg/toRegister">注册</a></button> <br>
					<a href="${pageContext.request.contextPath}/forgetpass.jsp">忘记密码</a>
				</div>
			  </div>
			</form>
		</div>
		</div>
	</div>	
	
</div>
</div></div>
</div>
<!-- MainBody End ============================= -->
<!-- Footer ================================================================== -->
<!-- Footer ================================================================== -->
<jsp:include page="common/Footer.jsp" ></jsp:include>
	<!-- Themes switcher section ============================================================================================= -->
<jsp:include page="common/Pagestyle.jsp" ></jsp:include>

<span id="themesBtn"></span>
</body>
</html>