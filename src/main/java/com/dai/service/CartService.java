package com.dai.service;

import com.dai.pojo.TbItem;
import com.dai.util.E3Result;

import java.util.List;


public interface CartService {

	/**
	 * 根据用户id将菜品信息添加到缓存中
	 * @param itemId
	 * @param userId
	 */
	public E3Result addUserItem2Cart(long itemId, long userId, Integer num);

	public List<TbItem> getCartListInRedis(long userId);
	/**
	 * 合并cookie和缓存中的数据
	 * @param userId
	 * @param cartList
	 * @return
	 */
	public List<TbItem> merge(long userId, List<TbItem> cartList);
	
	/**
	 * 根据itemId删除缓存中的菜品
	 * @param itemId
	 * @return
	 */
	public E3Result deleteItemInRedis(long userId, long itemId);
	
	/**
	 * 修改缓存中的菜品
	 * @param userId
	 * @param itemId
	 * @param num
	 * @return
	 */
	public E3Result updateItemInRedis(long userId, long itemId, Integer num);
	
	/**
	 * 根据用户id清空购物车
	 * @param userId
	 * @return
	 */
	public E3Result clearCartItemInRedis(long userId);
}
