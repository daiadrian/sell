package com.dai.common.quartz;

import com.dai.common.jedis.JedisOrderClient;
import com.dai.service.OrderService;
import com.dai.util.E3Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Created by DaiHao on 2018-04-19.
 */
@Component
public class SellQuartz {

    @Value("${ORDER_DINE_IN_CODE}")
    private String ORDER_DINE_IN_CODE;
    @Autowired
    private JedisOrderClient jedisOrderClient;
    @Value("${EVERY_DAY_INCOME}")
    private String EVERY_DAY_INCOME;
    @Autowired
    private OrderService orderService;

    //每天凌晨2点触发
    @Scheduled(cron = "0 0 2 * * ? ")
    public void clearShoppingCode(){
        jedisOrderClient.set(ORDER_DINE_IN_CODE, "1");
        String total = jedisOrderClient.get(EVERY_DAY_INCOME);
        E3Result result = orderService.addEveryDayIncomeDecord(total);
        if (200 == result.getStatus())
            jedisOrderClient.set(EVERY_DAY_INCOME, "0");
    }

}
