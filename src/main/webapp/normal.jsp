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
	<div class="span9" id="mainCol">
    <ul class="breadcrumb">
		<li><a href="${pageContext.request.contextPath}/index.jsp">Home</a> <span class="divider">/</span></li>
		<li class="active">Page Title</li>
    </ul>
	<h3> Title of the page</h3>	
	<hr class="soft"/>
	<h5>Lorem ipsum dolor sit amet</h5><br/>
	<p>
	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum varius dapibus. Sed hendrerit porta felis at sollicitudin. Sed at nunc ac neque semper fermentum. Proin diam sem, semper fermentum eleifend nec, viverra ac est. Sed ultricies, lectus et vehicula imperdiet, felis tortor vehicula turpis, non fermentum enim est et sapien. Nam justo mi, dignissim a euismod ut, pretium sed leo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In viverra porta est, consequat elementum metus tristique a. Mauris tempus tellus a metus dapibus faucibus egestas lectus consectetur. Integer libero dolor, luctus non congue vitae, tempus ut neque. Nunc eleifend lorem quis diam pharetra sagittis. Aliquam ut dolor dui. Fusce dictum facilisis ipsum eu porttitor. In ultricies rhoncus tortor vitae tincidunt.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br/>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br/>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br/>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br/>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
	<h5>Lorem ipsum dolor sit amet</h5><br/>
<p>
Nullam a vulputate leo. Nulla tristique metus eros. Curabitur ultrices commodo mauris, sit amet faucibus lectus fermentum in. Nulla eleifend, augue hendrerit tempus faucibus, diam lacus aliquet urna, eget facilisis turpis risus quis arcu. Cras placerat suscipit sem, ac consequat dui iaculis eu. Cras elit enim, adipiscing lobortis rutrum ac, vehicula nec massa. Praesent pharetra ligula ac erat venenatis feugiat. Quisque id nulla mi. Mauris at orci nec nisi eleifend auctor. Mauris placerat consectetur tincidunt. Nam eu tellus vitae dolor vestibulum commodo. Etiam tristique, urna ac convallis laoreet, enim enim aliquet neque, id cursus risus nulla sed ligula. Nunc quam libero, accumsan vitae consequat at, sollicitudin eget mi. Phasellus in molestie diam. Aliquam enim purus, tempor id sodales non, volutpat eu diam. Donec eu nisl lacinia leo semper lobortis sed sit amet elit.
</p>
<h5>Lorem ipsum dolor sit amet</h5><br/>
<p>
Aliquam interdum, ipsum a posuere dictum, tellus risus blandit dolor, at tristique sapien urna vel purus. Pellentesque in dictum urna. Sed feugiat libero sit amet arcu malesuada eu convallis dui convallis. Donec facilisis massa a ipsum aliquam lobortis. Praesent ac lectus sed leo aliquam egestas. Sed ante neque, volutpat ac tempor et, bibendum at ligula. Nunc porta vestibulum sodales.
	</p>
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