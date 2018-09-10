package com.dai.service;


import com.dai.pojo.TbUser;
import com.dai.util.E3Result;

public interface LoginService {

	public E3Result login(TbUser user);
	
	/**
	 * 从cookie中获取token并从redis中获取用户数据
	 * @param token
	 * @return
	 */
	public E3Result getUserByToken(String token);
	
	public void logout(String token);
}
