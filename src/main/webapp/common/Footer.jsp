<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  id="footerSection">
	<div class="container">
		<div class="row">
			<div class="span3">
				<h5>账户</h5>
				<a href="${pageContext.request.contextPath}/login.jsp">您的账户</a>
				<a href="${pageContext.request.contextPath}/login.jsp">订单信息</a>
				<a href="${pageContext.request.contextPath}/login.jsp">个人地址</a>
			</div>
			<div class="span3">
				<h5>信息</h5>
				<a href="${pageContext.request.contextPath}/contact.jsp">联系我们</a>
				<a href="#">法律声明</a>
				<a href="#">条款和条件</a>
				<a href="#">常见问题</a>
			</div>
			<div class="span3">
				<h5>最新详情</h5>
				<a href="#">新菜式</a>
				<a href="#">食品供应商</a>
			</div>
			<div id="socialMedia" class="span3 pull-right">
				<h5>社交媒体 </h5>
				<a href="#"><img width="60" height="60" src="${pageContext.request.contextPath}/themes/images/facebook.png" title="facebook" alt="facebook"/></a>
				<a href="#"><img width="60" height="60" src="${pageContext.request.contextPath}/themes/images/twitter.png" title="twitter" alt="twitter"/></a>
				<a href="#"><img width="60" height="60" src="${pageContext.request.contextPath}/themes/images/youtube.png" title="youtube" alt="youtube"/></a>
			</div>
		</div>
		<p class="pull-right">&copy; 仲恺出品</p>
	</div><!-- Container End -->
</div>