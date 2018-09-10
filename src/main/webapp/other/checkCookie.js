$(function(){
	var _ticket = $.cookie("SELL_USER_TOKEN");
	if (!_ticket) {
		return;
	}
	$.ajax({
		url: "http://localhost:8082/user/token/" + _ticket ,
		data: null,
		dataType: "json",
		type: "GET",
		success: function(data){
			if (data.status == 200) {
				var username = data.data.username;
				var html = "欢迎! <strong>" + username + "</strong>,<a href=\"http://localhost:8082/user/logout\">[退出]</a>";
				$("#myloginbar").html(html);
			}
		}
	});
});

