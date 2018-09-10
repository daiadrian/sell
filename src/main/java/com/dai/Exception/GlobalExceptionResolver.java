package com.dai.Exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class GlobalExceptionResolver implements HandlerExceptionResolver {

	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionResolver.class);
	
	@Override
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		//打印错误信息到日志文件
		logger.debug("系统出错了。。", ex);
		logger.debug("系统出错了。。", ex);
		logger.error("系统出错了。。", ex);
		//返回错误页面给用户
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("error/exception");
		
		return modelAndView;
	}

}
