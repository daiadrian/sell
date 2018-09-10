package com.dai.service.Impl;

import java.util.ArrayList;
import java.util.List;

import com.dai.common.jedis.JedisCartClient;
import com.dai.common.jedis.JedisClient;
import com.dai.mapper.TbItemMapper;
import com.dai.pojo.TbItem;
import com.dai.service.CartService;
import com.dai.util.E3Result;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * 购物车的服务层
 * @author adrain
 *
 */
@Service("cartService")
public class CartServiceImpl implements CartService {

	@Autowired
	private JedisCartClient jedisCartClient;
	@Value("${CART_REDIS_PRE}")
	private String CART_REDIS_PRE;
	@Autowired
	private TbItemMapper tbItemMapper;
	
	@Override
	public E3Result addUserItem2Cart(long itemId, long userId, Integer num) {
		//先查询缓存是否存在该用户的购物车
		Boolean exists = jedisCartClient.exists(CART_REDIS_PRE+":"+userId);
		if(exists){
			//如果存在，则对itemId相应的item是否存在进行判断
			String jsonItem = jedisCartClient.hget(CART_REDIS_PRE+":"+userId, itemId+"");
			if(StringUtils.isNotBlank(jsonItem)){
				//如果有对应的item则添加num
				TbItem item = JsonUtils.jsonToPojo(jsonItem, TbItem.class);
				item.setNum(num.intValue());
				//添加到缓存中
				jedisCartClient.hset(CART_REDIS_PRE+":"+userId, itemId+"", JsonUtils.objectToJson(item));
				return E3Result.ok();
			}
		}
		//如果不存在，则添加新的购物车缓存
		//如果不存在，根据商品id取商品信息
		TbItem item = tbItemMapper.selectByPrimaryKey(itemId);
		item.setNum(num.intValue());
		//取一张图片
		String image = item.getImage();
		if (StringUtils.isNotBlank(image)) {
			item.setImage(image.split(",")[0]);
		}
		//添加到缓存中
		jedisCartClient.hset(CART_REDIS_PRE+":"+userId, itemId+"", JsonUtils.objectToJson(item));
		return E3Result.ok();
	}

	@Override
	public List<TbItem> merge(long userId, List<TbItem> cartList) {
		if (cartList!=null && cartList.size()>0) {
			//将cookie的内容添加到缓存中
			for (TbItem item : cartList) {
				addUserItem2Cart(item.getId(), userId, item.getNum());
			}
		}
		//从缓存取出数据
		List<TbItem> itemList = getCartListInRedis(userId);
		return itemList;
	}

	@Override
	public List<TbItem> getCartListInRedis(long userId) {
		// 从缓存中取出数据
		List<String> jsonValue = jedisCartClient.hvals(CART_REDIS_PRE+":"+userId);
		List<TbItem> itemList = new ArrayList<TbItem>();
		//判断数据是否为空
		if(jsonValue!=null && jsonValue.size()>0){
			//将缓存数据写入list
			for(String str : jsonValue){
				TbItem item = JsonUtils.jsonToPojo(str, TbItem.class);
				itemList.add(item);
			}
		}
		return itemList;
	}

	@Override
	public E3Result deleteItemInRedis(long userId , long itemId) {
		jedisCartClient.hdel(CART_REDIS_PRE+":"+userId, itemId + "");
		return E3Result.ok();
	}

	@Override
	public E3Result updateItemInRedis(long userId, long itemId, Integer num) {
		// 从缓存中查到数据
		String jsonItem = jedisCartClient.hget(CART_REDIS_PRE+":"+userId, itemId + "");
		TbItem item = JsonUtils.jsonToPojo(jsonItem, TbItem.class);
		//修改商品的num
		item.setNum(num.intValue());
		jedisCartClient.hset(CART_REDIS_PRE+":"+userId, itemId + "",JsonUtils.objectToJson(item));
		return E3Result.ok();
	}

	@Override
	public E3Result clearCartItemInRedis(long userId) {
		jedisCartClient.del(CART_REDIS_PRE+":"+userId);
		return E3Result.ok();
	}

}
