package com.dai.service.Impl;

import java.util.List;
import java.util.UUID;

import com.dai.common.jedis.JedisClientPool;
import com.dai.common.jedis.JedisUserClient;
import com.dai.mapper.TbUserMapper;
import com.dai.pojo.TbUser;
import com.dai.pojo.TbUserExample;
import com.dai.service.LoginService;
import com.dai.util.CookieUtils;
import com.dai.util.E3Result;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;


@Service("loginService")
public class LoginServiceImpl implements LoginService {

	@Autowired
	private TbUserMapper tbUserMapper;
	@Autowired
	private JedisUserClient jedisUserClient;
	//用户存到redis中的前缀
	@Value("${USER_INFO}")
	private String USER_INFO;
	//用户过期时间
	@Value("${USER_EXPIRE_TIME}")
	private Integer USER_EXPIRE_TIME;
	
	@Override
	public E3Result login(TbUser user) {
		TbUserExample example = new TbUserExample();
		TbUserExample.Criteria criteria = example.createCriteria();
		criteria.andUsernameEqualTo(user.getUsername());
		List<TbUser> usernameList = tbUserMapper.selectByExample(example);
		if(!(usernameList !=null || usernameList.size()>0)){
			TbUser tbUser = usernameList.get(0);
			if(tbUser.getPassword().equals(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()))){
				//将用户信息写到缓存中,用户的密码需要进行置空
				tbUser.setPassword(null);
				//token用UUID来生成
				String token = UUID.randomUUID().toString();
				//需要将用户的信息变成json的字符串
				jedisUserClient.set(USER_INFO + ":" + token, JsonUtils.objectToJson(tbUser));
				return E3Result.ok(token);
			}
		}
		//再对密码进行判断
		TbUser tbUser = usernameList.get(0);
		if(tbUser.getPassword().equals(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()))){
			//将用户信息写到缓存中,用户的密码需要进行置空
			tbUser.setPassword(null);
			//token用UUID来生成
			String token = UUID.randomUUID().toString();
			//需要将用户的信息变成json的字符串
			jedisUserClient.set(USER_INFO + ":" + token, JsonUtils.objectToJson(tbUser));
			//设置过期时间
			jedisUserClient.expire(USER_INFO + ":" + token, USER_EXPIRE_TIME);
			return E3Result.ok(token);
		}
		return E3Result.build(400, "用户名或者密码错误");
	}

	@Override
	public E3Result getUserByToken(String token) {
		if(StringUtils.isNotBlank(token)){
			//从缓存中取到json后再转换成为user对象
			String jsonUser = jedisUserClient.get(USER_INFO + ":" + token);
			if(StringUtils.isNotBlank(jsonUser)){
				//再次设置过期时间
				jedisUserClient.expire(USER_INFO + ":" + token, USER_EXPIRE_TIME);
				TbUser user = JsonUtils.jsonToPojo(jsonUser, TbUser.class);
				return E3Result.ok(user);
			}
		}
		return E3Result.build(400, "登录过期，请重新登录");
	}

	@Override
	public void logout(String token) {
		//删除redis中token的缓存
		String jsonUser = jedisUserClient.get(USER_INFO + ":" + token);
		if(StringUtils.isNotBlank(jsonUser))
			jedisUserClient.expire(USER_INFO + ":" + token, 0);
	}

}
