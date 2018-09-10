package com.dai.Controller;

import com.dai.pojo.TbUser;
import com.dai.service.RegisterService;
import com.dai.util.E3Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 用户注册控制器
 * @author adrain
 *
 */
@Controller
public class RegisterController {

	@Autowired
	private RegisterService registerService;
	
	@RequestMapping("/userReg/toRegister")
	public String showRegister() {
		return "register";
	}
	
	/**
	 * 根据类型查询数据库检验注册信息
	 * @param checkContent
	 * @param type
	 * @return
	 */
	@RequestMapping("/userReg/check/{checkContent}/{type}")
	public @ResponseBody E3Result checkInput(@PathVariable String checkContent , @PathVariable Integer type){
		E3Result result = registerService.checkInput(checkContent, type);
		return result;
	}
	
	
	@RequestMapping(value="/userReg/register" , method=RequestMethod.POST)
	@ResponseBody
	public E3Result register(TbUser user) {
		E3Result result = registerService.register(user);
		return result;
	}
	
	
}
