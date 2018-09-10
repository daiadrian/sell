package com.dai.Controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dai.pojo.TbItem;
import com.dai.pojo.TbUser;
import com.dai.service.CartService;
import com.dai.service.ItemService;
import com.dai.util.CookieUtils;
import com.dai.util.E3Result;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 购物车控制器
 * @author adrain
 *
 */
@Controller
public class CartController {

	@Autowired
	private ItemService itemService;
	@Autowired
	private CartService cartService;
	@Value("${CART_COOKIE_MAXAGE}")
	private Integer CART_COOKIE_MAXAGE;
	@Value("${CART_COOKIE_NAME}")
	private String CART_COOKIE_NAME;
	
	/**
	 * 添加到购物车
	 * @param itemId
	 * @param num
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/cart/add/{itemId}")
	@ResponseBody
	public String addItem2Cart(@PathVariable Long itemId ,
			@RequestParam(value="num" , defaultValue="1") Integer num , 
			HttpServletRequest request , HttpServletResponse response){
		//先进行是否当前有用户的判断
		TbUser tbUser = (TbUser) request.getAttribute("user");
		//先从cookie中获取到商品的列表
		List<TbItem> cartList = getCartList(request);
		//如果用户存在，则将购物车内容插入到缓存中
		if(tbUser!=null){
			cartService.addUserItem2Cart(itemId, tbUser.getId(), num);
			return "success";
		}
		//标志，标示是否在cookie中包含该商品，默认没有
		boolean flag = false;
		//判断是否cookie中是否已经包含该商品
		for(TbItem tbItem : cartList){
			if(itemId.longValue() == tbItem.getId()){
				//如果有则数量加上num
				tbItem.setNum(tbItem.getNum() + num);
				flag = true;
				break;
			}
		}
		//如果没有该商品，则根据id获取商品
		if(!flag){
			TbItem item = itemService.getTbItemByItemId(itemId);
			//添加商品数量
			item.setNum(num);
			//对商品中的image进行处理，只显示一张
			if(StringUtils.isNotBlank(item.getImage())){
				String[] imageList = item.getImage().split(",");
				item.setImage(imageList[0]);
			}
			//添加到list中
			cartList.add(item);
		}
		//再将最后的数据添加到cookie中,需要设置编码
		CookieUtils.setCookie(request, response, CART_COOKIE_NAME,
				JsonUtils.objectToJson(cartList), CART_COOKIE_MAXAGE, true);
		return "success";
	}
	
	/**
	 * 从cookie中获取商品的列表
	 * @param request
	 * @return
	 */
	public List<TbItem> getCartList(HttpServletRequest request){
		//获取到列表的json串
		String cartList = CookieUtils.getCookieValue(request, CART_COOKIE_NAME, true);
		if(StringUtils.isNotBlank(cartList)){
			//如果有数据则返回
			return JsonUtils.jsonToList(cartList, TbItem.class);
		}
		//无数据则返回一个新的list
		return new ArrayList<TbItem>();
	}
	
	/**
	 * 展示购物车页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/cart/cart")
	public String showCartList(HttpServletRequest request){
		//先从cookie中获取到购物车的数据
		List<TbItem> cartList = getCartList(request);
		//判断用户是否存在
		TbUser user = (TbUser) request.getAttribute("user");
		if(user!=null){
			cartList = cartService.merge(user.getId(), cartList);
		}
		//将数据放入model中
		request.setAttribute("cartList", cartList);
		return "product_summary";
	}
	
	/**
	 * 删除商品
	 * @param itemId
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/cart/delete/{itemId}")
	public String deleteItemInCartByItemId(@PathVariable Long itemId , 
			HttpServletRequest request , HttpServletResponse response){
		//判断用户是否存在
		TbUser user = (TbUser) request.getAttribute("user");
		if(user!=null){
			cartService.deleteItemInRedis(user.getId(), itemId);
		}
		//先从cookie中获取到商品列表
		List<TbItem> cartList = getCartList(request);
		for(TbItem tbItem : cartList){
			if(tbItem.getId() == itemId.longValue()){
				cartList.remove(tbItem);
				break;
			}
		}
		//再将最后的数据添加到cookie中,需要设置编码
		CookieUtils.setCookie(request, response, CART_COOKIE_NAME, 
				JsonUtils.objectToJson(cartList), CART_COOKIE_MAXAGE, true);
		return "redirect:/cart/cart";
	}
	
	/**
	 * 修改商品的数量从而局部刷新购物车数据
	 * @param itemId
	 * @param num
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/cart/update/num/{itemId}/{num}")
	@ResponseBody
	public E3Result updateItemNumInCart(@PathVariable Long itemId , @PathVariable Integer num ,
										HttpServletRequest request , HttpServletResponse response){
		//判断用户是否存在
		TbUser user = (TbUser) request.getAttribute("user");
		if(user!=null){
			return cartService.updateItemInRedis(user.getId(), itemId, num);
		}
		//从cookie中获取商品列表
		List<TbItem> cartList = getCartList(request);
		for(TbItem tbItem : cartList){
			if(tbItem.getId() == itemId.longValue()){
				tbItem.setNum(num);
				break;
			}
		}
		//再将最后的数据添加到cookie中,需要设置编码
		CookieUtils.setCookie(request, response, CART_COOKIE_NAME, 
				JsonUtils.objectToJson(cartList), CART_COOKIE_MAXAGE, true);
		return E3Result.ok();
	}
	
	
}
