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
	  <script src="${pageContext.request.contextPath}/other/jquery.alerts.js"></script>

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
		<li><a href="${pageContext.request.contextPath}/index">主页</a> <span class="divider">/</span></li>
		<li class="active">注册中心</li>
    </ul>
	<h3> 注册新用户 </h3>
	<div class="well">
	<form class="form-horizontal" id="regForm_mod" method="post">
		<h4>填写主要信息</h4>
		<div class="control-group">
			<label class="control-label" for="inputFname1">手机号 <sup>*</sup></label>
			<div class="controls">
			  <input type="text" id="inputFname1" placeholder="Username" name="username">
				<span id="my_inputFname1"></span>
			</div>
		 </div>
	<div class="control-group">
		<label class="control-label" for="inputPassword1">密码 <sup>*</sup></label>
		<div class="controls">
		  <input type="password" id="inputPassword1" placeholder="Password" name="password">
			<span id="my_inputPassword1"></span>
		</div>
	  </div>
	<div class="control-group">
		<label class="control-label" for="input_email">Email </label>
		<div class="controls">
			<input type="text" id="input_email" placeholder="Email 非必填" name="email">
			<span id="my_inputemail"></span>
		</div>
	</div>

	<div class="control-group">
			<div class="controls">
				<input type="hidden" name="email_create" value="1">
				<input type="hidden" name="is_new_customer" value="1">
				<a class="btn btn-large btn-success" onclick="REGISTER.reg()">注册</a>
			</div>
		</div>		
	</form>
</div>

</div>
</div>
</div>
</div>
<script type="text/javascript">
	var loginFlag = false;
	var REGISTER={
		param:{
			surl:"http://localhost:8082"
		},
		inputcheck:function(){
			var flag = true;
			//不能为空检查
			if ($("#inputFname1").val() == "") {
				$("#my_inputFname1").html("<font color='red'>手机号不能为空</font>");
				flag = false;
			}
			if ($("#inputPassword1").val() == "") {
				$("#my_inputPassword1").html("<font color='red'>密码不能为空</font>");
				flag = false;
			}
			return flag;
		},
		beforeSubmit:function() {
			//检查用户是否已经被占用
			$.ajax({
				url : REGISTER.param.surl + "/userReg/check/"+escape($("#inputFname1").val())+"/1?r=" + Math.random(),
				dataType: "json",
				type: "GET",
				success : function(data) {
					if (!data.data) {
						$("#my_inputFname1").html("<font color='red'>手机号已经存在</font>");
				}
			});

		},
		doSubmit:function() {
			$.post("http://localhost:8082/userReg/register",$("#regForm_mod").serialize(), function(data){
				if(data.status == 200){
					loginFlag = true;
					REGISTER.login();
				} else {
					jAlert("注册失败！","提示");
				}
			});
		},
		login:function() {
			if (loginFlag) {
				location.href = "http://localhost:8082/user/toLogin"
			}
			return false;
		},
		reg:function() {
			if (this.inputcheck()) {
				this.beforeSubmit();
			}
		}
	};
</script>
<!-- MainBody End ============================= -->
<!-- Footer ================================================================== -->
<!-- Footer ================================================================== -->

<jsp:include page="common/Footer.jsp" ></jsp:include>


	<!-- Themes switcher section ============================================================================================= -->

<jsp:include page="common/Pagestyle.jsp" ></jsp:include>

<span id="themesBtn"></span>
</body>
</html>