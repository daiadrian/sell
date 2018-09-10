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
          function goPageSearch() {
              var gotopage = document.getElementById("goToPage").value;
              var hiddenTotalPages = $("#hiddenTotalPages").val();
              var hiddenkeyword = $("#hiddenkeyword").val();
              if(gotopage >= 1 && gotopage <= hiddenTotalPages){
                  window.location.href = "http://localhost:8082/search?keyword="+ hiddenkeyword + "&page=" + gotopage;
              }else{
                  $('#myModal').modal('show');
              }
          };

          function add2Cart(id) {
              $.ajax({
                  url:"http://localhost:8082/cart/add/" + id,
                  type:"GET",
                  data:null,
                  success:function(data){
                      if ("success" == data){
                          $("#myModalRemind").html("加入餐车成功！");
                          $('#myModal').modal('show');
                      }else{
                          $("#myModalRemind").html("加入餐车失败，请重试！");
                          $('#myModal').modal('show');
                      }

                  }
              });
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
		<li class="active">${query}</li>
    </ul>
	<h3>搜索 ${query} 结果<small class="pull-right">一共有 ${recordCount} 个符合的菜品信息 </small></h3>
<div id="myTab" class="pull-right">
 <a href="#listView" data-toggle="tab"><span class="btn btn-large"><i class="icon-list"></i></span></a>
 <a href="#blockView" data-toggle="tab"><span class="btn btn-large btn-primary"><i class="icon-th-large"></i></span></a>
</div>
<br class="clr"/>
<div class="tab-content">

	<div class="tab-pane" id="listView">
        <c:forEach  items="${itemList }" var="item">
            <div class="row">
                <div class="span2">
                    <img src="${item.images[0] }" alt=""/>
                </div>
                <div class="span4">
                    <h3>${item.title }</h3>
                    <hr class="soft"/>
                    <h5>${item.category_name} </h5>
                    <p>${item.sell_point }</p>
                    <a class="btn btn-small pull-right" href="${pageContext.request.contextPath}/item/${item.id}">查看详情</a>
                    <br class="clr"/>
                </div>
                <div class="span3 alignR">
                <form class="form-horizontal qtyFrm">
                <h3>  ￥${item.price / 100 }</h3>
                  <a onclick="add2Cart('${item.id}')" class="btn btn-large btn-primary"> 加入餐车 <i class=" icon-shopping-cart"></i></a>
                  <a href="${pageContext.request.contextPath}/item/${item.id}" class="btn btn-large"><i class="icon-zoom-in"></i></a>
                    </form>
                </div>
            </div>
            <hr class="soft"/>
        </c:forEach>

	</div>

    <div class="tab-pane  active" id="blockView">
        <ul class="thumbnails">
            <c:forEach  items="${itemList }" var="blockitem">
                <li class="span3">
                  <div class="thumbnail">
                    <a href="${pageContext.request.contextPath}/item/${item.id}"><img src="${blockitem.images[0] }" alt=""/></a>
                    <div class="caption">
                      <h5>${blockitem.title }</h5>
                      <p>${blockitem.sell_point }</p>
                       <h4 style="text-align:center"><a class="btn" href="${pageContext.request.contextPath}/item/${blockitem.id}"> <i class="icon-zoom-in"></i></a> <a class="btn" onclick="add2Cart('${blockitem.id}')" >加入餐车 <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="${pageContext.request.contextPath}/item/${blockitem.id}">￥${blockitem.price / 100 }</a></h4>
                    </div>
                  </div>
                </li>
            </c:forEach>

          </ul>
    <hr class="soft"/>
    </div>

</div>
	        <div class="pagination">
                <form>
                <ul>
                    <c:if test="${page>1}">
                        <li><a href="${pageContext.request.contextPath}/search?keyword=${query}&page=${page-1}" class="btn">&lsaquo;</a></li>
                    </c:if>
                    <li><input type="text" value="${page}" id="goToPage" size="3"/></li>
                    <li><a class="btn" onclick="goPageSearch()">跳转</a></li>
                    <c:if test="${page<totalPages&&page>=1}">
                        <li><a href="${pageContext.request.contextPath}/search?keyword=${query}&page=${page+1}" class="btn">&rsaquo;</a></li>
                    </c:if>
                    <input type="hidden" value="${totalPages}" id="hiddenTotalPages"/>
                    <input type="hidden" value="${query}" id="hiddenkeyword"/>
                </ul>
                </form>
			</div>
            <small >一共 ${totalPages} 页</small>
			<br class="clr"/>


</div>
</div>
</div>
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