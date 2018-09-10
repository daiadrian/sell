package com.dai.Controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dai.pojo.TbUser;
import com.dai.service.LoginService;
import com.dai.util.CookieUtils;
import com.dai.util.E3Result;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

/**
 * 用户登录的Controller
 * @author adrain
 *
 */
@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;
	
	@RequestMapping("/user/toLogin")
	public String showLogin(String redirect,Model model) {
		model.addAttribute("redirect", redirect);
		return "login";
	}
	
	@RequestMapping(value="/user/login" , method=RequestMethod.POST)
	@ResponseBody
	public E3Result login(TbUser user , HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
		E3Result result = loginService.login(user);
		String token = (String) result.getData();
		//添加到cookie中
		CookieUtils.setCookie(request, response, "SELL_USER_TOKEN", token);
		return result;
	}

	@RequestMapping(value="/user/token/{token}" , method=RequestMethod.GET)
	@ResponseBody
	public String getUserByToken(@PathVariable String token){
		E3Result result = loginService.getUserByToken(token);
		return JsonUtils.objectToJson(result);
	}
	
	@RequestMapping("/user/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response){
		String token = CookieUtils.getCookieValue(request, "SELL_USER_TOKEN");
		loginService.logout(token);
		CookieUtils.deleteCookie(request, response, "SELL_USER_TOKEN");
		return "login";
	}
	
}
