package com.dai.Controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;

/**
 * 支付宝支付控制器
 * @author adrain
 *
 */
@Controller
public class AlipayController {

	@RequestMapping("/alipay")
	public void getContentList(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String orderId = request.getAttribute("orderId").toString();
		String title = request.getAttribute("title").toString();
		String payment = request.getAttribute("payment").toString();
		AlipayClient alipayClient = new
				DefaultAlipayClient("https://openapi.alipaydev.com/gateway.do",
				"app_id",
				"应用私钥",
				"json","utf-8",
				"支付宝公钥",
				"RSA2" );

		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();//创建API对应的request
		alipayRequest.setReturnUrl("http://localhost:8082/order/sucess");
		//付款id
		String out_trade_no = orderId;
		//付款金额
		String total_amount = payment;
		total_amount= URLDecoder.decode(total_amount,"UTF-8");//转码
		//商品名称
		String subject = title;
		subject=URLDecoder.decode(subject,"UTF-8");

		String timeout_express = "10m";
		timeout_express = URLDecoder.decode(timeout_express,"UTF-8");
		alipayRequest.setBizContent("{" +
						"    \"out_trade_no\":\""+ out_trade_no +"\"," +
						//product_code这个写死FAST_INSTANT_TRADE_PAY
						"    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
						"    \"total_amount\":"+ total_amount +"," +
						"    \"subject\":\""+ subject +"\"," +
						"    \"timeout_express\":\""+ timeout_express +"\""
				+"}");//填充业务参数
		String form="";
		try {
			form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
		} catch (AlipayApiException e) {
			e.printStackTrace();
		}
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().println(form);//直接将完整的表单html输出到页面
		response.getWriter().close();
	}



//	@RequestMapping("/ailpay")
//	public void getContentList(HttpServletRequest request, HttpServletResponse response)
//			throws IOException {
//		AlipayClient alipayClient = new
//				DefaultAlipayClient("https://openapi.alipaydev.com/gateway.do",
//				"app_id",
//				"应用私钥",
//				"json","utf-8",
//				"支付宝公钥",
//				"RSA2" );
//
//		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();//创建API对应的request
//		alipayRequest.setReturnUrl("http://localhost:8082/success");
//		//支付宝回调的post的响应
//		//alipayRequest.setNotifyUrl("http://localhost:8100/notify_url");//在公共参数中设置回跳和通知地址
//
//		//付款id
//		String out_trade_no = "";
//		//付款金额
//		String total_amount = "";
//		total_amount= URLDecoder.decode(total_amount,"UTF-8");//转码
//		//商品名称
//		String subject = "";
//		subject=URLDecoder.decode(subject,"UTF-8");
//		//商品描述
//		String body= "";
//		body=URLDecoder.decode(body,"UTF-8");
//		//订单中商品的列表信息
//		/*
//		订单包含的商品列表信息，Json格式：
//		{&quot;show_url&quot;:&quot;https://或http://打头的商品的展示地址&quot;} ，
//		在支付时，可点击商品名称跳转到该地址
//		例如:{&quot;show_url&quot;:&quot;https://www.alipay.com&quot;}
//		 */
//		String goods_detail = "";
//		goods_detail=URLDecoder.decode(goods_detail,"UTF-8");
//
//		/*
//		该笔订单允许的最晚付款时间，逾期将关闭交易。
//		取值范围：1m～15d。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。
//		该参数数值不接受小数点， 如 1.5h，可转换为 90m。
//		 */
//		String timeout_express = "10m";
//		timeout_express = URLDecoder.decode(timeout_express,"UTF-8");
//		alipayRequest.setBizContent("{" +
//				"    \"out_trade_no\":\""+ out_trade_no +"\"," +
//				//product_code这个写死FAST_INSTANT_TRADE_PAY
//				"    \"product_code\":\"FAST_INSTANT_TRADE_PAY\"," +
//				"    \"total_amount\":"+ total_amount +"," +
//				"    \"subject\":\""+ subject +"\"," +
//				"    \"body\":\""+ body +"\"," +
//				"    \"timeout_express\":\""+ timeout_express +"\""
//				/*公用回传参数，如果请求时传递了该参数，则返回给商户时会回传该参数。
//				支付宝只会在异步通知时将该参数原样返回。本参数必须进行UrlEncode之后才可以发送给支付宝
//				即传此参数需要传NotifyUrl进行异步的返回
//				"    \"passback_params\":\"merchantBizType%3d3C%26merchantBizNo%3d2016010101111\"," +
//				这个是业务扩展的参数
//				sys_service_provider_id   系统商编号，该参数作为系统商返佣数据提取的依据，请填写系统商签约协议的PID
//				hb_fq_num   花呗分期数（目前仅支持3、6、12）
//				hb_fq_seller_percent   卖家承担收费比例，商家承担手续费传入100，用户承担手续费传入0，仅支持传入100、0两种，其他比例暂不支持
//				"    \"extend_params\":{" +
//				"    \"sys_service_provider_id\":\"2088511833207846\"" +
//				"    }"+
//				"  }"
//				*/
//				);//填充业务参数
//		String form="";
//		try {
//			form = alipayClient.pageExecute(alipayRequest).getBody(); //调用SDK生成表单
//		} catch (AlipayApiException e) {
//			e.printStackTrace();
//		}
//		response.setContentType("text/html;charset=utf-8");
//		response.getWriter().println(form);//直接将完整的表单html输出到页面
//		response.getWriter().close();
//	}
	
}
