package com.dai.service.Impl;

import java.util.Date;
import java.util.List;

import com.dai.mapper.TbUserMapper;
import com.dai.pojo.TbUser;
import com.dai.pojo.TbUserExample;
import com.dai.service.RegisterService;
import com.dai.util.E3Result;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

@Service("registerService")
public class RegisterServiceImpl implements RegisterService {

	@Autowired
	private TbUserMapper tbUserMapper;
	
	@Override
	public E3Result checkInput(String checkContent, Integer type) {
		//根据类型来选择判断的依据 ： 判断用户名
		//返回true即可以注册，返回false则数据库中存在
		TbUserExample example = new TbUserExample();
		TbUserExample.Criteria criteria = example.createCriteria();
		//包装类型不能直接比较
		if(type.intValue() == 1){
			//判断用户名
			criteria.andUsernameEqualTo(checkContent);
		}else{
			return E3Result.build(400, "错误验证");
		}
		List<TbUser> userList = tbUserMapper.selectByExample(example);
		//判断列表是否为空
		if(userList !=null && userList.size()>0){
			return E3Result.ok(false);
		}
		return E3Result.ok(true);
	}

	@Override
	public E3Result register(TbUser user) {
		//添加之前需要对数据再一次进行效验
		if(StringUtils.isBlank(user.getUsername()))
			return E3Result.build(400, "用户名不能为空");
		
		if(StringUtils.isBlank(user.getPassword()))
			return E3Result.build(400, "密码不能为空");

		if(!(Boolean)checkInput(user.getUsername(), 1).getData())
			return E3Result.build(400, "用户名已经存在");

		//对密码进行MD5加密
		String md5Password = DigestUtils.md5DigestAsHex(user.getPassword().getBytes());
		user.setPassword(md5Password);
		user.setCreated(new Date());
		user.setUpdated(new Date());
		tbUserMapper.insert(user);
		return E3Result.ok();
	}

	
	
}
