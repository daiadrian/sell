<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="welcomeLine" class="row">
	<div class="span6" id="myloginbar"><strong>
		<a href="${pageContext.request.contextPath}/user/toLogin">请先进行登录</a>
	</strong></div>
	<div class="span6">
		<div class="pull-right">
			<a href="${pageContext.request.contextPath}/cart/cart"><span class="btn btn-mini btn-primary"><i class="icon-shopping-cart icon-white"></i> 查看当前餐车 </span> </a>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/other/jquery.alerts.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/other/jquery.cookie.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/other/checkCookie.js"></script>
