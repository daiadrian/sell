<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="logoArea" class="navbar">
	<a id="smallScreen" data-target="#topMenu" data-toggle="collapse" class="btn btn-navbar">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</a>
	<div class="navbar-inner">
		<a class="brand" href="${pageContext.request.contextPath}/index"><img src="${pageContext.request.contextPath}/themes/images/logo.png" alt="Bootsshop"/></a>
		<!-- 搜索框 -->
		<form class="form-inline navbar-search" method="post" action="${pageContext.request.contextPath}/search" >
			<input id="srchFld" class="srchTxt" type="text" name="keyword" />
			<button type="submit" id="submitButton" class="btn btn-primary">搜索</button>
		</form>
		<ul id="topMenu" class="nav pull-right">
			<li class=""><a href="${pageContext.request.contextPath}/contact.jsp">联系我们</a></li>
			<li class="">
				<a href="${pageContext.request.contextPath}/search" role="button" style="padding-right:0"><span class="btn btn-large btn-success">查看所有菜品</span></a>
			</li>
		</ul>
	</div>
</div>