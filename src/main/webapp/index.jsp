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
    <link id="callCss" rel="stylesheet" href="${pageContext.request.contextPath}/themes/bootshop/bootstrap.min.css" media="screen"/>
    <link href="${pageContext.request.contextPath}/themes/css/base.css" rel="stylesheet" media="screen"/>
	<link href="${pageContext.request.contextPath}/themes/css/bootstrap-responsive.min.css" rel="stylesheet"/>
	<link href="${pageContext.request.contextPath}/themes/css/font-awesome.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/themes/js/google-code-prettify/prettify.css" rel="stylesheet"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/themes/images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${pageContext.request.contextPath}/themes/images/ico/apple-touch-icon-57-precomposed.png">
	<style type="text/css" id="enject"></style>
    <script src="${pageContext.request.contextPath}/themes/js/jquery.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/themes/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/themes/js/google-code-prettify/prettify.js"></script>
    <script src="${pageContext.request.contextPath}/themes/js/bootshop.js"></script>
    <script src="${pageContext.request.contextPath}/themes/js/jquery.lightbox-0.5.js"></script>
  </head>
<body>
<div id="header">
<div class="container">
	<jsp:include page="common/Header.jsp"></jsp:include>
<jsp:include page="common/Navbar.jsp" />
</div>
</div>
<div id="mainBody">
	<div class="container">
	<div class="row">
	<jsp:include page="common/Sidebar.jsp"></jsp:include>
		<div class="span9">
			<div class="well well-small">
			<!-- 推荐菜品 -->
			<h4>推荐菜品 <small class="pull-right">推荐菜品</small></h4>
			<div class="row-fluid">
			<div id="featured" class="carousel slide">
			<div class="carousel-inner">

				<div class="item active">
					<ul class="thumbnails">
				<c:forEach var="cufl" items="${contentUpfristList}" varStatus="vs">
					<li class="span3">
						<div class="thumbnail">
							<i class="tag"></i>
							<a href="${cufl.url }"><img src="${cufl.pic }" alt=""></a>
							<div class="caption">
								<h5>${cufl.title }</h5>
								<h4><a class="btn" href="${cufl.url }">查看详情</a> <span class="pull-right">￥${cufl.price/100 }</span></h4>
							</div>
						</div>
					</li>
				</c:forEach>
					</ul>
				</div>
				<div class="item">
					<ul class="thumbnails">
						<c:forEach var="cusl" items="${contentUpsecondList}" varStatus="vs">
							<li class="span3">
								<div class="thumbnail">
									<i class="tag"></i>
									<a href="${cusl.url }"><img src="${cusl.pic }" alt=""></a>
									<div class="caption">
										<h5>${cusl.title }</h5>
										<h4><a class="btn" href="${cusl.url }">查看详情</a> <span class="pull-right">￥${cusl.price/100 }</span></h4>
									</div>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>

			  </div>
			  <a class="left carousel-control" href="#featured" data-slide="prev">‹</a>
			  <a class="right carousel-control" href="#featured" data-slide="next">›</a>
			  </div>
			  </div>
		</div>
		<div class="copyrights">Collect from <a href="#"  title="仲恺出品">仲恺出品</a></div>
		<!--  最新菜品  -->
		<h4>最新菜品</h4>
			  <ul class="thumbnails">
				  <c:forEach var="cdl" items="${contentDownList}" varStatus="vs">
					  <li class="span3">
						  <div class="thumbnail">
							  <a  href="${cdl.url }"><img src="${cdl.pic }" alt=""/></a>
							  <div class="caption">
								  <h5>${cdl.title }</h5>
								  <p>
										${cdl.subTitle }
								  </p>
								  <h4 style="text-align:center"><a class="btn" href="${cdl.url }"> <i class="icon-zoom-in"></i></a> <a class="btn" href="${cdl.url }" >查看详情</a> <a class="btn btn-primary" href="${cdl.url }">￥${cdl.price/100 }</a></h4>
							  </div>
						  </div>
					  </li>
				  </c:forEach>
			  </ul>

		</div>
		</div>
	</div>
</div>
<!-- Footer ================================================================== -->
	<jsp:include page="common/Footer.jsp" ></jsp:include>
	<!-- Themes switcher section ============================================================================================= -->
	<jsp:include page="common/Pagestyle.jsp" ></jsp:include>
<span id="themesBtn"></span>
</body>
</html>