<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>出错啦！！！</title>
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

  </head>
<body>
<div id="header">
	<div class="container">

		<jsp:include page="../common/Header.jsp"></jsp:include>

<!-- Navbar ================================================== -->

		<jsp:include page="../common/Navbar.jsp" />

</div>
</div>
<!-- Header End====================================================================== -->
<div id="mainBody">
	<div class="container">
	<div class="row">
<!-- Sidebar ================================================== -->

		<jsp:include page="../common/Sidebar.jsp"></jsp:include>

<!-- Sidebar end=============================================== -->
	<div class="span9">
    <ul class="breadcrumb">
		<li><a href="${pageContext.request.contextPath}/index">Home</a> <span class="divider">/</span></li>
		<li class="active">error</li>
    </ul>
	<h3> 出错了啦！</h3>
	<hr class="soft"/>
	
	<div class="row">
		<img src="${pageContext.request.contextPath}/error/error1.jpg" />
	</div>	
	
</div>
</div></div>
</div>
<!-- MainBody End ============================= -->
<!-- Footer ================================================================== -->
<!-- Footer ================================================================== -->

<jsp:include page="../common/Footer.jsp" ></jsp:include>

	<!-- Themes switcher section ============================================================================================= -->

<jsp:include page="../common/Pagestyle.jsp" ></jsp:include>

<span id="themesBtn"></span>
</body>
</html>