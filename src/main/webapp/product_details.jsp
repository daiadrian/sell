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

	  <script>
		  function addThisItem2Cart(id) {
              var ItemDetailsId = $("#ItemDetailsId").val();
              if(undefined == ItemDetailsId || 0 == parseInt(ItemDetailsId) || "" == ItemDetailsId)
                  ItemDetailsId = 1;

			  var num = parseInt(ItemDetailsId);
			  $.ajax({
				  url:"http://localhost:8082/cart/add/"+id,
				  type:"POST",
				  data:{"num":num},
				  success:function(data){
					  if ("success" == data){
						  $("#myModalRemind").html("加入餐车成功！");
						  $('#myModal').modal('show');
					  }else{
						  $("#myModalRemind").html("加入餐车失败，请重试！");
						  $('#myModal').modal('show');
					  }
				  },
				  error:function () {
					  alert("error");
				  }
			  });
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
    <li class="active">菜品详情</li>
    </ul>	
	<div class="row">

			<c:forEach items="${item.images }" var="image" varStatus="vs">
			<c:if test="${vs.count ==1}" >
			<div id="gallery" class="span3">
            <%--<a href="${pageContext.request.contextPath}/themes/images/products/large/f1.jpg" title="Fujifilm FinePix S2950 Digital Camera">
				<img src="${pageContext.request.contextPath}/themes/images/products/large/3.jpg" style="width:100%" alt="Fujifilm FinePix S2950 Digital Camera"/>
            </a>--%>
			<a href="${image }" title="${item.title }">
				<img src="${image }" style="width:100%" alt="${item.title }"/>
			</a>
			<div id="differentview" class="moreOptopm carousel slide">
                <div class="carousel-inner">
                  <div class="item active">
			</c:if>
					  <c:if test="${vs.count <=3}" >
						  <a href="${image }"> <img style="width:29%" src="${image }" alt="${item.title }"/></a>
					  </c:if>
				  </c:forEach>
                   <%--<a href="${pageContext.request.contextPath}/themes/images/products/large/f1.jpg"> <img style="width:29%" src="${pageContext.request.contextPath}/themes/images/products/large/f1.jpg" alt=""/></a>
                   <a href="${pageContext.request.contextPath}/themes/images/products/large/f2.jpg"> <img style="width:29%" src="${pageContext.request.contextPath}/themes/images/products/large/f2.jpg" alt=""/></a>
                   <a href="${pageContext.request.contextPath}/themes/images/products/large/f3.jpg" > <img style="width:29%" src="${pageContext.request.contextPath}/themes/images/products/large/f3.jpg" alt=""/></a>
                  --%>
				  </div>
                  <div class="item">
				  <c:forEach items="${item.images }" var="image" varStatus="vs">
					  <c:if test="${vs.count > 3}" >
						  <a href="${image }"> <img style="width:29%" src="${image }" alt="${item.title }"/></a>
					  </c:if>
				  </c:forEach>
                   <%--<a href="${pageContext.request.contextPath}/themes/images/products/large/f3.jpg" > <img style="width:29%" src="${pageContext.request.contextPath}/themes/images/products/large/f3.jpg" alt=""/></a>
                   <a href="${pageContext.request.contextPath}/themes/images/products/large/f1.jpg"> <img style="width:29%" src="${pageContext.request.contextPath}/themes/images/products/large/f1.jpg" alt=""/></a>
                   <a href="${pageContext.request.contextPath}/themes/images/products/large/f2.jpg"> <img style="width:29%" src="${pageContext.request.contextPath}/themes/images/products/large/f2.jpg" alt=""/></a>
                  --%>
				  </div>
                </div>
              <!--  
			  <a class="left carousel-control" href="#myCarousel" data-slide="prev">‹</a>
              <a class="right carousel-control" href="#myCarousel" data-slide="next">›</a> 
			  -->
              </div>
			  
			 <div class="btn-toolbar">
			  <div class="btn-group">
				<span class="btn"><i class="icon-envelope"></i></span>
				<span class="btn" ><i class="icon-print"></i></span>
				<span class="btn" ><i class="icon-zoom-in"></i></span>
				<span class="btn" ><i class="icon-star"></i></span>
				<span class="btn" ><i class=" icon-thumbs-up"></i></span>
				<span class="btn" ><i class="icon-thumbs-down"></i></span>
			  </div>
			</div>
			</div>



			<div class="span6">
				<h3>${item.title }  </h3>
				<hr class="soft"/>
				<form class="form-horizontal qtyFrm">
				  <div class="control-group">
					<label class="control-label"><span>￥:<fmt:formatNumber groupingUsed="false" maxFractionDigits="2" minFractionDigits="2" value="${item.price / 100 }"/></span></label>
					<div class="controls">
					<input type="number" class="span1" placeholder="Qty." id="ItemDetailsId"/>
					  <a onclick="addThisItem2Cart('${item.id}')" class="btn btn-large btn-primary pull-right" > 加入餐车 <i class=" icon-shopping-cart"></i></a>
					</div>
				  </div>
				</form>
				
				<hr class="soft clr"/>
				<p>
					${item.sellPoint }
				</p>
				<a class="btn btn-small pull-right" href="#detail">More Details</a>
				<br class="clr"/>
			<a href="#" name="detail"></a>
			<hr class="soft"/>
			</div>

			
			<div class="span9">
            <!--<ul id="productDetail" class="nav nav-tabs">
              <li class="active"><a href="#home" data-toggle="tab">Product Details</a></li>
              <li><a href="#profile" data-toggle="tab">Related Products</a></li>
            </ul>-->
            <div id="myTabContent" class="tab-content">
				<hr class="soft"/>
				<h4>详情:</h4>
              <div class="tab-pane fade active in" id="home">
				  ${itemDesc.itemDesc }
			  </div>
            </div>
          </div>

	</div>

</div>
</div> </div>
</div>
<jsp:include page="common/Model.jsp"></jsp:include>
<!-- MainBody End ============================= -->
<!-- Footer ================================================================== -->
<!-- Footer ================================================================== -->

<jsp:include page="common/Footer.jsp" ></jsp:include>

	<!-- Themes switcher section ============================================================================================= -->

<jsp:include page="common/Pagestyle.jsp" ></jsp:include>

<span id="themesBtn"></span>
</body>
</html>