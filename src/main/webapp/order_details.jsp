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

	  <script type="text/javascript">
		  function order_alipay() {
			  
		  }
		  
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
		<li class="active">订单详情</li>
    </ul>
	<h3> 您的订单详情</h3>
	<hr class="soft"/>
	<div class="row">
		<div class="span9" style="min-height:900px">
			<div class="well">
			<form action="${pageContext.request.contextPath}/order/create" method="post">
			<h5>请确认订单</h5><br/>
				<table class="table table-bordered">
					<thead>
					<tr>
						<th>菜品</th>
						<th>数量</th>
						<th>价格</th>
						<th>总价</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach items="${cartList}" var="cart" varStatus="vs">
						<c:set var="totalPrice"  value="${ totalPrice + (cart.price * cart.num)}"/>
						<tr>
							<td>${cart.title }</td>
							<td>${cart.num }</td>
							<td>${cart.price / 100}</td>
							<td>${cart.price / 100 * cart.num}</td>
							<input type="hidden" name="orderItems[${vs.index}].itemId" value="${cart.id}"/>
							<input type="hidden" name="orderItems[${vs.index}].num" value="${cart.num }"/>
							<input type="hidden" name="orderItems[${vs.index}].price" value="${cart.price}"/>
							<input type="hidden" name="orderItems[${vs.index}].totalFee" value="${cart.price * cart.num}"/>
							<input type="hidden" name="orderItems[${vs.index}].title" value="${cart.title}"/>
							<input type="hidden" name="orderItems[${vs.index}].picPath" value="${cart.image}"/>
						</tr>
					</c:forEach>
					<c:if test="${paymentType == 2}" >
						<tr>
							<td colspan="3" style="text-align:right"><strong>配送费:	</strong></td>
							<td class="label label-important" style="display:block"> <strong>￥ ${postFee} </strong></td>
						</tr>
					</c:if>
					<tr>
						<td colspan="3" style="text-align:right"><strong>总价:	</strong></td>
						<td class="label label-important" style="display:block"> <strong>￥ ${totalPrice/100 + postFee } </strong></td>
						<input type="hidden" name="payment" value="${totalPrice/100 + postFee}"/>
						<input type="hidden" name="paymentType" value="${paymentType}"/>
						<input type="hidden" name="postFee" value="${postFee}"/>
					</tr>
					</tbody>
				</table>

				<c:if test="${paymentType == 2}">
					<table class="table table-bordered">
						<tr><th> 您的外卖信息 </th></tr>
						<tr>
							<td><strong>送餐地址： </strong></td>
							<td><strong> ${userAddress} </strong></td>
						</tr>
						<tr>
							<td><strong>您的姓名： </strong></td>
							<td><strong> ${userName} </strong></td>
						</tr>
						<tr>
							<td><strong>您的电话： </strong></td>
							<td><strong> ${userPhone} </strong></td>
						</tr>
						<input type="hidden" name="userPhone" value="${userPhone}"/>
						<input type="hidden" name="userName" value="${userName}"/>
						<input type="hidden" name="userAddress" value="${userAddress}"/>
					</table>
				</c:if>

				<div class="controls">
					<button type="submit" class="btn block">支付</button>
				</div>
				</form>
		</div>
		</div>
	</div>

</div>
</div>
</div>
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