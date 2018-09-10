var navbarredirectUrl = "${redirect}";
var NavbarLOGIN = {
    checkInput:function() {
        if ($("#inputName").val() == "") {
            $("#my_navbarname").html("<font color='red'>用户名不能为空</font>");
            flag = false;
        }
        if ($("#inputPassword").val() == "") {
            $("#my_navbarpwd").html("<font color='red'>密码不能为空</font>");
            flag = false;
        }
        return true;
    },
    doLogin:function() {
        $.post("http://localhost:8082/user/login", $("#NavbarLogin").serialize(),function(data){
            if (data.status == 200) {
                jAlert('登录成功！',"提示", function(){
                    if (redirectUrl == "") {
                        location.href = "http://localhost:8082/index";
                    } else {
                        location.href = navbarredirectUrl;
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
