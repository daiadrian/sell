<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

	  <script src="${pageContext.request.contextPath}/themes/js/jquery.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/themes/js/bootstrap.min.js" type="text/javascript"></script>
	  <script src="${pageContext.request.contextPath}/themes/js/google-code-prettify/prettify.js"></script>

	  <script src="${pageContext.request.contextPath}/themes/js/bootshop.js"></script>
	  <script src="${pageContext.request.contextPath}/themes/js/jquery.lightbox-0.5.js"></script>
	  <script src="${pageContext.request.contextPath}/other/checkFoodCart.js"  type="text/javascript"></script>

	  <script>

		  function deleteItemInCart(id) {
			  window.location.href = "http://localhost:8082/cart/delete/" + id;
		  };

		  function decrementItemInCart(id) {
			  var thisItem = "thisItemDecInc_"+ id;
			  //1.因为是减少，所以先看当前的数量是否等于1，等于1直接删除，否则直接减1
			  //获取当前的num
			  var thisItemnum = $("#thisItemNum_"+ id +"").val();
			  if(parseInt(thisItemnum) == 1){
				  window.location.href = "http://localhost:8082/cart/delete/" + id;
				  return;
			  }
			  //设置num值
			  var newThisItemNum = eval(thisItemnum) - 1;
			  $("#thisItemNum_"+ id +"").val(newThisItemNum);
			  $("#appendedInputButtons_"+id+"").attr("placeholder",newThisItemNum+"");
			  //设置该商品总价钱; 当前总价加上单价
			  //当前总价
			  var thisItemTotalPrice = $("#thisItemTotalPrice_" + id +"").html();
			  //单前单价
			  var thisItemPrice = $("#thisItemPrice_"+id+"").val();
			  //减少之后总价
			  var newThisItemTotalPrice = eval(thisItemTotalPrice - thisItemPrice);
			  $("#thisItemTotalPrice_" + id +"").html(newThisItemTotalPrice);
			  //设置最终总价
			  //最终总价
			  var hiddenlastTotalPrice = $("#hiddenlastTotalPrice").val();
			  var thisLastTotalPrice = eval(hiddenlastTotalPrice - thisItemPrice);
			  $("#lastTotalPrice").html("￥ "+thisLastTotalPrice);
			  $("#hiddenlastTotalPrice").val(thisLastTotalPrice);

			  $.ajax({
				  url:"http://localhost:8082/cart/update/num/" + id + "/" + newThisItemNum,
				  type:"GET",
				  data:null,
				  success:function () {
					  //alert("减少测试通过了");
				  }
			  });

		  };

		  function incrementItemInCart(id) {
			  var thisItem = "thisItemDecInc_"+ id;
			  //获取当前的num
			  var thisItemnum = $("#thisItemNum_"+ id +"").val();
			  //设置num值
			  var newThisItemNum = parseInt(thisItemnum) + 1;
			  $("#thisItemNum_"+ id +"").val(newThisItemNum);
			  $("#appendedInputButtons_"+id+"").attr("placeholder",newThisItemNum+"");
			  //设置该商品总价钱; 当前总价加上单价
			  //当前总价
			  var thisItemTotalPrice = $("#thisItemTotalPrice_" + id +"").html();
			  //单前单价
			  var thisItemPrice = $("#thisItemPrice_"+id+"").val();
			  //增加之后总价
			  var newThisItemTotalPrice = eval((parseInt(thisItemTotalPrice) + parseInt(thisItemPrice)));
			  $("#thisItemTotalPrice_" + id +"").html(newThisItemTotalPrice);
			  //设置最终总价
			  //最终总价
			  var hiddenlastTotalPrice = $("#hiddenlastTotalPrice").val();
			  var thisLastTotalPrice = eval((parseInt(hiddenlastTotalPrice) + parseInt(thisItemPrice)));
			  $("#lastTotalPrice").html("￥ "+thisLastTotalPrice);
			  $("#hiddenlastTotalPrice").val(thisLastTotalPrice);

			  $.ajax({
				  url:"http://localhost:8082/cart/update/num/" + id + "/" + newThisItemNum,
				  type:"GET",
				  data:null,
				  success:function () {
					  //alert("增加测试通过了");
				  }
			  });
		  };

		  function DineIn() {
              window.location.href = "http://localhost:8082/order/order-cart-dine-in";
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
		<li class="active"> 餐车</li>
    </ul>
	<h3> 您的餐车 <a href="${pageContext.request.contextPath}/search" class="btn btn-large pull-right"><i class="icon-arrow-left"></i> 继续点餐 </a></h3>
	<hr class="soft"/>

	<table class="table table-bordered" id="cartLoginTable">
	</table>
			
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
			  <c:forEach items="${cartList}" var="cart" >
				  <c:if test="${cartList == null}">
					  <tr><td style="text-align:center">您的购物车是空的</td></tr>
				  </c:if>
				  <c:set var="totalPrice"  value="${ totalPrice + (cart.price * cart.num)}"/>
				  <tr>
					  <td>${cart.title }</td>
					  <td>
						  <div class="input-append" id="thisItemDecInc_${cart.id}"><input class="span1" style="max-width:34px" placeholder="${cart.num}" id="appendedInputButtons_${cart.id}" size="16" type="text">
							  <!-- 存储当前的单价 -->
							  <input type="hidden" id="thisItemPrice_${cart.id}" value="${cart.price / 100 }"/>
							  <!-- 存储当前的数量 -->
							  <input type="hidden" id="thisItemNum_${cart.id}" value="${cart.num }"/>
							  <button class="btn" type="button" onclick="decrementItemInCart('${cart.id}')"><i class="icon-minus"></i></button>
							  <button class="btn" type="button" onclick="incrementItemInCart('${cart.id}')"><i class="icon-plus"></i></button>
							  <button class="btn btn-danger" type="button" onclick="deleteItemInCart('${cart.id}')"><i class="icon-remove icon-white"></i></button>
						  </div>
					  </td>
					  <td>${cart.price / 100}</td>
					  <td id="thisItemTotalPrice_${cart.id}">${cart.price / 100 * cart.num}</td>
				  </tr>
			  </c:forEach>

				 <tr>
                  <td colspan="4" style="text-align:right"><strong>总价:	</strong></td>
                  <td class="label label-important" style="display:block"><input type="hidden" value="${totalPrice / 100}" id="hiddenlastTotalPrice"/> <strong id="lastTotalPrice">￥ ${totalPrice / 100} </strong></td>
                </tr>
				</tbody>
            </table>

			<!--  堂食点餐结账  -->
           <table class="table table-bordered">
			<tbody>
				 <tr>
                  <td> 
				<form class="form-horizontal">
				<div class="control-group">
				<label class="control-label"><strong> 堂食点我结账: </strong> </label>
				<div class="controls">
				<button type="button" class="btn" onclick="DineIn()"> 堂食结账 </button>
				</div>
				</div>
				</form>
				</td>
                </tr>
				
			</tbody>
			</table>
			
			<table class="table table-bordered">
			 <tr><th> 外卖信息填写 </th></tr>
			 <tr> 
			 <td>
				<form class="form-horizontal" action="${pageContext.request.contextPath}/order/order-cart-take-out" method="post">
				  <div class="control-group">
					<label class="control-label" for="inputCountry"> 送餐地址 </label>
					<div class="controls">
					  <input type="text" id="inputCountry" placeholder="地址" name="userAddress">
					</div>
				  </div>
				  <div class="control-group">
					<label class="control-label" for="inputPost"> 您的姓名 </label>
					<div class="controls">
					  <input type="text" id="inputName" placeholder="姓名" name="userName">
					</div>
				  </div>
					<div class="control-group">
						<label class="control-label" for="inputPost"> 您的电话 </label>
						<div class="controls">
							<input type="text" id="inputPost" placeholder="电话" name="userPhone">
						</div>
					</div>
				  <div class="control-group">
					<div class="controls">
					  <button type="submit" class="btn"> 外卖结账 </button>
					</div>
				  </div>
				</form>				  
			  </td>
			  </tr>
            </table>		
	<a href="${pageContext.request.contextPath}/search" class="btn btn-large"><i class="icon-arrow-left"></i> 返回点餐列表 </a>

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