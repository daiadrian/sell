package com.dai.service;


import com.dai.pojo.TbUser;
import com.dai.util.E3Result;

public interface RegisterService {

	/**
	 * 根据检查的类型来判断检查内容是否存在
	 * @param checkContent
	 * @param type
	 * @return
	 */
	public E3Result checkInput(String checkContent, Integer type);
	
	/**
	 * 用户注册
	 * @param user
	 * @return
	 */
	public E3Result register(TbUser user);
}
