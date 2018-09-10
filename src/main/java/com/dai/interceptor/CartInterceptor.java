package com.dai.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dai.pojo.TbItem;
import com.dai.pojo.TbUser;
import com.dai.service.CartService;
import com.dai.service.LoginService;
import com.dai.util.CookieUtils;
import com.dai.util.E3Result;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * 餐车车拦截器
 * @author adrain
 *
 */
public class CartInterceptor implements HandlerInterceptor {

	@Autowired
	private LoginService loginService;
	@Autowired
	private CartService cartService;
	@Value("${CART_COOKIE_NAME}")
	private String CART_COOKIE_NAME;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		//从cookie中取出用户的token
		String token = CookieUtils.getCookieValue(request, "SELL_USER_TOKEN");
		if(StringUtils.isNotBlank(token)){
			TbUser user = (TbUser) loginService.getUserByToken(token).getData();
			//判断用户是否登录
			if(user!=null){
				//登录就将用户的信息放到request中
				request.setAttribute("user", user);
				//先判断cookie是否有购物车数据，合并再取出
				String cartCookie = CookieUtils.getCookieValue(request, CART_COOKIE_NAME, true);
				if(StringUtils.isNotBlank(cartCookie)){
					cartService.merge(user.getId(), JsonUtils.jsonToList(cartCookie, TbItem.class));
				}
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 在handler执行完成，返回ModelAndView之前调用

	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 在返回ModelAndView之后调用

	}

}
