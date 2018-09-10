package com.dai.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.dai.common.jedis.JedisOrderClient;
import com.dai.common.pojo.OrderInfo;
import com.dai.mapper.TbEverydayIncomeMapper;
import com.dai.mapper.TbOrderItemMapper;
import com.dai.mapper.TbOrderMapper;
import com.dai.pojo.TbEverydayIncome;
import com.dai.pojo.TbOrder;
import com.dai.pojo.TbOrderExample;
import com.dai.pojo.TbOrderItem;
import com.dai.service.OrderService;
import com.dai.util.E3Result;
import com.dai.util.IDUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

/**
 * 订单的服务层
 *
 * @author adrain
 */
@Service("orderService")
public class OrderServiceImpl implements OrderService {

    @Autowired
    private JedisOrderClient jedisOrderClient;
    @Value("${ORDER_ID_GEN_KEY}")
    private String ORDER_ID_GEN_KEY;
    @Value("${ORDER_ID_START}")
    private String ORDER_ID_START;
    @Autowired
    private TbOrderMapper tbOrderMapper;
    @Value("${ORDER_DETAIL_ID_GEN_KEY}")
    private String ORDER_DETAIL_ID_GEN_KEY;
    @Autowired
    private TbOrderItemMapper tbOrderItemMapper;
    @Autowired
    private TbEverydayIncomeMapper tbEverydayIncomeMapper;
    @Value("${ORDER_DINE_IN_CODE}")
    private String ORDER_DINE_IN_CODE;
    @Value("${EVERY_DAY_INCOME}")
    private String EVERY_DAY_INCOME;
    @Autowired
    private JmsTemplate jmsTemplate;
    @Resource
    private Destination queueDestination;

    @Override
    public E3Result createOrder(OrderInfo orderInfo) {
        //生成订单号。使用redis的incr生成。
        if (!jedisOrderClient.exists(ORDER_ID_GEN_KEY)) {
            jedisOrderClient.set(ORDER_ID_GEN_KEY, ORDER_ID_START);
        }
        String orderId = jedisOrderClient.incr(ORDER_ID_GEN_KEY).toString();
        //生成Order
        TbOrder order = new TbOrder();
        order.setOrderId(orderId);
        //状态：1、未付款，2、已付款，3、交易完成，4、订单取消
        order.setStatus(1);
        order.setCreateTime(new Date());
        order.setUpdateTime(new Date());
        order.setPayment(orderInfo.getPayment());
        order.setPaymentType(orderInfo.getPaymentType());
        if (orderInfo.getPaymentType() == 2) {
            order.setUserName(orderInfo.getUserName());
            order.setUserId(orderInfo.getUserId());
            order.setUserAddress(orderInfo.getUserAddress());
            order.setUserPhone(orderInfo.getUserPhone());
            order.setPostFee(orderInfo.getPostFee());
        }
        tbOrderMapper.insert(order);
        List<TbOrderItem> orderItems = orderInfo.getOrderItems();
        for (TbOrderItem tbOrderItem : orderItems) {
            //生成明细id
            String odId = jedisOrderClient.incr(ORDER_DETAIL_ID_GEN_KEY).toString();
            tbOrderItem.setId(odId);
            tbOrderItem.setOrderId(orderId);
            tbOrderItemMapper.insert(tbOrderItem);
        }
        //返回E3Result，包含订单号
        return E3Result.ok(orderId);
    }

    @Override
    public String createOrderDineInNum() {
        if (!jedisOrderClient.exists(ORDER_DINE_IN_CODE)) {
            jedisOrderClient.set(ORDER_DINE_IN_CODE, "1");
        }
        return jedisOrderClient.incr(ORDER_DINE_IN_CODE).toString();
    }

    @Override
    public void addEveryDayIncome(String total_amount) {
        if (!jedisOrderClient.exists(EVERY_DAY_INCOME)) {
            jedisOrderClient.set(EVERY_DAY_INCOME, "0");
        }
        jedisOrderClient.incrBy(EVERY_DAY_INCOME, total_amount);
    }

    @Override
    public E3Result addEveryDayIncomeDecord(String total_amount) {
        TbEverydayIncome tbEverydayIncome = new TbEverydayIncome();
        tbEverydayIncome.setId(IDUtils.genItemId());
        tbEverydayIncome.setCreated(new Date());
        tbEverydayIncome.setUpdated(new Date());
        tbEverydayIncome.setMoney(Long.valueOf(total_amount));
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        tbEverydayIncome.setTime(format.format(new Date()));
        tbEverydayIncomeMapper.insert(tbEverydayIncome);
        return E3Result.ok();
    }

    @Override
    public E3Result updateOrderStatus(String out_trade_no, String orderDineInNum) {
        if (StringUtils.isNotBlank(out_trade_no)) {
            TbOrder tbOrder = tbOrderMapper.selectByPrimaryKey(out_trade_no);
            if (null != tbOrder) {
                //状态：1、未付款，2、已付款，3、交易完成，4、订单取消
                tbOrder.setStatus(2);
                tbOrder.setPaymentTime(new Date());
                tbOrder.setUpdateTime(new Date());
                if (StringUtils.isNotBlank(orderDineInNum))
                    tbOrder.setShoppingCode(orderDineInNum);
            }
            tbOrderMapper.updateByPrimaryKeySelective(tbOrder);
        }
        return E3Result.ok();
    }

    /**
     * 发送实时订单号到后台
     *
     * @param out_trade_no
     * @return
     */
    @Override
    public E3Result sendMessageToCanteen(String out_trade_no) {
        jmsTemplate.send(queueDestination, new MessageCreator() {
            @Override
            public Message createMessage(Session session) throws JMSException {
                return session.createTextMessage(out_trade_no);
            }
        });
        return E3Result.ok();
    }


    /**
     * 将过期的订单状态改为取消的
     */
    public void updateAllOrderStatusInEveryDay() {
        TbOrderExample example = new TbOrderExample();
        TbOrderExample.Criteria criteria = example.createCriteria();
        criteria.andStatusEqualTo(1);
        List<TbOrder> tbOrders = tbOrderMapper.selectByExample(example);
        for (TbOrder order : tbOrders) {
            order.setStatus(4);
            order.setUpdateTime(new Date());
            tbOrderMapper.updateByPrimaryKeySelective(order);
        }
    }

    @Override
    public Integer findCurOrderStatus(String id) {
        TbOrder tbOrder = tbOrderMapper.selectByPrimaryKey(id);
        return tbOrder.getPaymentType();
    }


}
