<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="sidebar" class="span3">
	<!-- 侧边的购物车  -->
	<div class="well well-small"><a id="myCart" href="${pageContext.request.contextPath}/cart/cart"><img src="${pageContext.request.contextPath}/themes/images/ico-cart.png" alt="cart"> 点我查看餐车  <span class="badge badge-warning pull-right">餐车</span></a></div>
	<!-- 侧边菜品栏  -->
	<ul id="sideManu" class="nav nav-tabs nav-stacked">
		<li class="subMenu open"><a>粤式风味</a>
			<ul>
				<li><a class="active" href="${pageContext.request.contextPath}"><i class="icon-chevron-right"></i>焗龙虾 </a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>烧腊</a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>老火靓汤</a></li>
			</ul>
		</li>
		<li class="subMenu"><a> 潮汕风味 </a>
			<ul style="display:none">
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>牛肉丸</a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>沙茶类</a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>卤味</a></li>
			</ul>
		</li>
		<li class="subMenu"><a> 西式餐饮 </a>
			<ul style="display:none">
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>牛扒</a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>意粉</a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>炸鸡</a></li>
			</ul>
		</li>
		<li class="subMenu"><a> 东北美食 </a>
			<ul style="display:none">
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>凉粉</a></li>
				<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="><i class="icon-chevron-right"></i>小吃</a></li>
			</ul>
		</li>
		<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="> 白饭 </a></li>
		<li><a href="${pageContext.request.contextPath}/search/searchTitle?keyword="> 饮料 </a></li>
	</ul>
	<br/>
	<%--<div class="thumbnail">
		<img src="${pageContext.request.contextPath}/themes/images/products/panasonic.jpg" alt="Bootshop panasonoc New camera"/>
		<div class="caption">
			<h5>Panasonic</h5>
			<h4 style="text-align:center"><a class="btn" href="http://jd.com"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">我是广告</a> <a class="btn btn-primary" href="#">$888.00</a></h4>
		</div>
	</div><br/>
	<div class="thumbnail">
		<img src="${pageContext.request.contextPath}/themes/images/products/kindle.png" title="Bootshop New Kindel" alt="Bootshop Kindel">
		<div class="caption">
			<h5>Kindle</h5>
			<h4 style="text-align:center"><a class="btn" href=http://jd.com""> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">我是广告</a> <a class="btn btn-primary" href="#">$888.00</a></h4>
		</div>
	</div><br/>--%>
</div>