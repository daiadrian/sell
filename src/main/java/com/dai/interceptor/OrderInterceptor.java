package com.dai.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dai.pojo.TbItem;
import com.dai.pojo.TbUser;
import com.dai.service.CartService;
import com.dai.service.LoginService;
import com.dai.util.CookieUtils;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 在跳转结算详情页对购物车进行操作的拦截器
 * @author adrain
 *
 */
public class OrderInterceptor implements HandlerInterceptor {

	@Autowired
	private LoginService loginService;

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// 先对用户是否登录进行判断
		//从cookie中获取用户的token
		String token = CookieUtils.getCookieValue(request, "SELL_USER_TOKEN", true);
		String redirect = "/cart/cart";
		//根据token获取用户
		if(StringUtils.isBlank(token)){
			//获取不到用户则跳转登录页面
			response.sendRedirect("http://localhost:8082/user/toLogin?redirect="
					+ redirect);
			return false;
		}
		TbUser user = (TbUser) loginService.getUserByToken(token).getData();
		if(user==null){
			response.sendRedirect("http://localhost:8082/user/toLogin?redirect="
					+ redirect);
			return false;
		}
		request.setAttribute("user", user);
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
