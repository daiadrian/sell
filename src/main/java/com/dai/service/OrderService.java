package com.dai.service;


import com.dai.common.pojo.OrderInfo;
import com.dai.util.E3Result;

public interface OrderService {

    /**
     * 生成订单
     *
     * @param orderInfo
     * @return
     */
    public E3Result createOrder(OrderInfo orderInfo);

    /**
     * 生成堂食流水订单号
     *
     * @return
     */
    public String createOrderDineInNum();

    /**
     * 每日收入
     *
     * @return
     */
    public void addEveryDayIncome(String total_amount);

    /**
     * 添加每日收入记录
     *
     * @return
     */
    public E3Result addEveryDayIncomeDecord(String total_amount);

    /**
     * 更新订单
     *
     * @return
     */
    public E3Result updateOrderStatus(String out_trade_no, String orderDineInNum);

    /**
     * 发送实时订单信息
     *
     * @return
     */
    public E3Result sendMessageToCanteen(String out_trade_no);


    /**
     * 将过期的订单状态改为取消的
     */
    public void updateAllOrderStatusInEveryDay();

    /**
     * 将过期的订单状态改为取消的
     */
    public Integer findCurOrderStatus(String id);

}
