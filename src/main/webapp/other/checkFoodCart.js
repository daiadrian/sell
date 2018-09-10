function checkFoodCartUser(){
	var _ticket = $.cookie("SELL_USER_TOKEN");
	if (!_ticket) {
		return;
	}
	$.ajax({
		url: "http://localhost:8082/user/token/" + _ticket,
		data: null,
		dataType: "json",
		type: "GET",
		success: function(data){
			if (data.status == 200) {
				var username = data.data.username;
				var html = '<tr><th> 登录  </th></tr><tr><td> <form class="form-horizontal" id="cartFromLogin"> <div class="control-group"> <label class="control-label" for="inputUsername">用户名</label> <div class="controls"> <input type="text" id="inputUsername" placeholder="Username"> <span id="my_inputcartname"></span> </div> </div> <div class="control-group"> <label class="control-label" for="inputPassword1">密码</label> <div class="controls"> <input type="password" id="inputPassword1" placeholder="Password"> <span id="my_inputcartpwd"></span> </div> </div> <div class="control-group"> <div class="controls"> <button class="btn" onclick="CartLOGIN.login()">登录</button> 或者 <a href="${pageContext.request.contextPath}/userReg/toRegister" class="btn">立即注册!</a> </div> </div> <div class="control-group"> <div class="controls"> <a href="${pageContext.request.contextPath}/forgetpass.jsp" style="text-decoration:underline">Forgot password ?</a> </div> </div> </form> </td> </tr>';
				$("#cartLoginTable").html(html);
			}
		}
	});
};

var cartredirectUrl = "http://localhost:8082/cart/cart";
var CartLOGIN = {
    checkInput:function() {
        if ($("#inputUsername").val() == "") {
            $("#my_inputcartname").html("<font color='red'>用户名不能为空</font>");
            flag = false;
        }
        if ($("#inputPassword1").val() == "") {
            $("#my_inputcartpwd").html("<font color='red'>密码不能为空</font>");
            flag = false;
        }
        return true;
    },
    doLogin:function() {
        $.post("http://localhost:8082/user/login", $("#cartFromLogin").serialize(),function(data){
            if (data.status == 200) {
                jAlert('登录成功！',"提示", function(){
                    if (redirectUrl == "") {
                        location.href = "http://localhost:8082/index";
                    } else {
                        location.href = cartredirectUrl;
                    }
                });

            } else {
                jAlert("登录失败，原因是：" + data.msg,"失败");
            }
        });
    },
    login:function() {
        if (this.checkInput()) {
            this.doLogin();
        }
    }

};

