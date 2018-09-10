package com.dai.Controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dai.common.pojo.OrderInfo;
import com.dai.pojo.TbItem;
import com.dai.pojo.TbUser;
import com.dai.service.CartService;
import com.dai.service.LoginService;
import com.dai.service.OrderService;
import com.dai.util.CookieUtils;
import com.dai.util.E3Result;
import com.dai.util.JsonUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * 结算详情控制器
 *
 * @author adrain
 */
@Controller
public class OrderController {

    @Autowired
    private CartService cartService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private LoginService loginService;
    @Value("${CART_COOKIE_NAME}")
    private String CART_COOKIE_NAME;

    //堂食跳转菜品详情页面
    @RequestMapping("/order/order-cart-dine-in")
    public String showDineInOrderCart(HttpServletRequest request) {
        TbUser user = (TbUser) request.getAttribute("user");
        List<TbItem> cartList = new ArrayList<>();
        if (user != null) {
            cartList = cartService.getCartListInRedis(user.getId());
        } else {
            String cartListStr = CookieUtils.getCookieValue(request, CART_COOKIE_NAME, true);
            if (StringUtils.isNotBlank(cartListStr)) {
                cartList = JsonUtils.jsonToList(cartListStr, TbItem.class);
            }
        }
        request.setAttribute("cartList", cartList);
        request.setAttribute("paymentType", 1);
        request.setAttribute("postFee", 0);
        return "order_details";
    }

    //外卖跳转菜品详情页面
    @RequestMapping("/order/order-cart-take-out")
    public String showTakeOutOrderCart(@RequestParam("userAddress") String userAddress, @RequestParam("userName") String userName,
                                       @RequestParam("userPhone") String userPhone, HttpServletRequest request, HttpServletResponse response) {
        TbUser user = (TbUser) request.getAttribute("user");
        List<TbItem> cartList = cartService.getCartListInRedis(user.getId());
        request.setAttribute("cartList", cartList);
        request.setAttribute("paymentType", 2);
        request.setAttribute("postFee", 4);
        request.setAttribute("userAddress", userAddress);
        request.setAttribute("userName", userName);
        request.setAttribute("userPhone", userPhone);
        return "order_details";
    }

    @RequestMapping(value = "/order/create", method = RequestMethod.POST)
    public String createOrder(OrderInfo orderInfo, HttpServletRequest request, HttpServletResponse response) {
        TbUser user = (TbUser) request.getAttribute("user");
        if (user != null)
            orderInfo.setUserId(user.getId());

        E3Result result = orderService.createOrder(orderInfo);
        if (result.getStatus() == 200) {
            if (user != null)
                cartService.clearCartItemInRedis(user.getId());
            CookieUtils.deleteCookie(request, response, CART_COOKIE_NAME);
        }
        //把订单号传递给页面
        String orderId = result.getData().toString();
        request.setAttribute("orderId", orderId);
        request.setAttribute("title", "您的订单");
        request.setAttribute("payment", orderInfo.getPayment());
        return "forward:/alipay";
    }

    @RequestMapping(value = "/order/affirm-cart")
    public String orderSuccess(HttpServletRequest request, HttpServletResponse response) {
        //获取当前用户信息
        String token = CookieUtils.getCookieValue(request, "SELL_USER_TOKEN");
        if (StringUtils.isNotBlank(token)) {
            loginService.logout(token);
            CookieUtils.deleteCookie(request, response, "SELL_USER_TOKEN");
        }
        return "index";
    }

    @RequestMapping(value = "/order/sucess")
    public String affirmUserOut(HttpServletRequest request, @RequestParam("out_trade_no") String out_trade_no,
                                @RequestParam("total_amount") String total_amount) {
        String orderDineInNum = null;
        if (orderService.findCurOrderStatus(out_trade_no) == 2) {
            request.setAttribute("existUser", "yes");
            request.setAttribute("code", out_trade_no);
        } else {
            orderDineInNum = orderService.createOrderDineInNum();
            request.setAttribute("code", orderDineInNum);
        }
        orderService.addEveryDayIncome(total_amount);
        orderService.updateOrderStatus(out_trade_no, orderDineInNum);
        orderService.sendMessageToCanteen(out_trade_no);
        return "order_success";
    }


}
