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
				"2016080900198765",
				"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDZXGN+O/OBS6aAAwsGjiyW7vtuVscSvBVq9EYaF1ULLOGIef9a5me/IbXuTUzRiGtO/kbiSZePzI6ANf6hEe4bfDvUcV5e1+i4AQMFtnOT/TkjP63Fdda4aOz2JpPoon8MQwkY7dAVe8aAX4ySDShzkp9ls3Q9ZR3kczDstBTlSGSVg1HQd96v454B3e3IZgyP85Fez6w6EryxB849ckboDqQBriDyXskCiXtYC4HXVrvgU8ZXpGkkyMHRjGIi48xfAzsEBcCOaX+tUQzpZ0lOr8CQds+4bkSCQRGOD+cBJPd671K5XLoWSZd+qb09PjyO3PGIBLgUiQIykVA4k2bfAgMBAAECggEBAMbHJP3mmbQemO/s2IJwNvr5JtsrZPcPJo8fQZTOzalgrAiBeTOKDkrO63A5JQ1iMrCU/gInxwFs0s0RlAF9QkHEhXqtCt61mU/dLQRmbKBkLYK805AHSgxveHVLpmxTXti53XH82hUrkscHmqhefCXlavw49w7GkGXBqnZt4cYjk/SOWNqeAVFTUC3ScDOAIzos4kPf4CbguX5SKxi8gND7agH7EvKV/fS6oVxTSsRX2bSqW6zpP/bbTS0zAkh5Ef54H/IKGx1T0A5hJP3/IGd0ETeDtnspzIo5zAUVXtBfrXgifURT8eXk/ELr5gD8qCzpJkrfGSW9HdlyHXIVGeECgYEA+2hWozdMTweTPm64rouJDcm9U9wRruLT1m64KYNy5L1J6i6YDMyKP4MzoeiXMGm/yxLf99h3dL8vrCVWAyDevysTNUXVdbiALFbJNJyMNbdRfr9mChK23n+YkJuuOEB5DLxTHW5qSZZJk2vw23dcwCHJb+c6q/Y66DjG2oylHDcCgYEA3VTWTxqDEItk5SThwDUl0aIVjczzxkeZp+SDbGaFDbCxHbegEvHX/G2frw0BUdkmA5pXR+9P5AUemU41F4h3zdfqL5wyZ+8+xcaODLR6hC6W72x/HCfjqw14zM+fsdrPaaXLMhyDGeCdVGI8vCoB4AcSAZkcp8wqZQVvS98FxpkCgYEAoi3zvcR9aHnlhZ/daVPALPHYPZG4oo3Ww/yWtskCRAbL+NLn6VHFWSVlGGw3o9aEEBdz/alZnil7Mly/eLMqnj3GXVZYVmGX5YJyt4rJdBl27AHCbHsYFr5PB/I12DnXHN0b7N9+l0vo2L4IGTuNzK+/B34tviLQa1+8/9084c8CgYBhbcP9BE2njcT3PZoGkx63viLAzfSNVt1j06qqoCJ32UzOKRPU4xLRsqv1UcM/9VfPhDRhnQ3M8Rf8Ijoqxs7+FMqo9JgXunAmfXXwT84Su7ODZ344tbJ5jK+dcNP6Zbih5/Kfd3+ad46qI6haqB81L8eUXoMHtk7/Mzo/6sfPGQKBgQDbuYOKoLLc89C5E9FDIIFNl5RuKH8JRtHEGvYGum7MrNB2I8KijcJFamHVJnZj++WB+4g47vLh2w5XbFvgpXZ+2uXLtHOsoVAEHxdaNdEfBivbaMWmqp8/kh/6V8/7Y2CYmB6t15Ml2rg8O+1SHtxzqclVnzEinl/C2z9fSof8Gw==",
				"json","utf-8",
				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvwMcIZAODquwOD5KC/pGWyeFNTWcVtA6AMYOUZpUGw/U2ZH+unxFkmktyu5E/NxcMyNEq6PCRWZNCERP0OYJZEbMljP43ZjmK8qqMO/LqDtEBHTJox+AjuLX0UJrgUk1cAF75zVvv1DPgaX/XlpmlBasW3CbmCf4fFqb7M3gfuJUtzhdpHXYgdlp3Qf4/ykJgrx5HB63PVXDk9SLjRgucL2Hvq4VSJnfQSriWfQS0wn8bUyZty80ww3DFJqGulHl2uhegoG35QPwIuX/CO4TVr4qFx9Xh8GMP8O1Imfwhu9l6mg87gH7ssnkwzFZFeUI04jCGoSipmgJxI1QQl5SYwIDAQAB",
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
//				"2016080900198765",
//				"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDZXGN+O/OBS6aAAwsGjiyW7vtuVscSvBVq9EYaF1ULLOGIef9a5me/IbXuTUzRiGtO/kbiSZePzI6ANf6hEe4bfDvUcV5e1+i4AQMFtnOT/TkjP63Fdda4aOz2JpPoon8MQwkY7dAVe8aAX4ySDShzkp9ls3Q9ZR3kczDstBTlSGSVg1HQd96v454B3e3IZgyP85Fez6w6EryxB849ckboDqQBriDyXskCiXtYC4HXVrvgU8ZXpGkkyMHRjGIi48xfAzsEBcCOaX+tUQzpZ0lOr8CQds+4bkSCQRGOD+cBJPd671K5XLoWSZd+qb09PjyO3PGIBLgUiQIykVA4k2bfAgMBAAECggEBAMbHJP3mmbQemO/s2IJwNvr5JtsrZPcPJo8fQZTOzalgrAiBeTOKDkrO63A5JQ1iMrCU/gInxwFs0s0RlAF9QkHEhXqtCt61mU/dLQRmbKBkLYK805AHSgxveHVLpmxTXti53XH82hUrkscHmqhefCXlavw49w7GkGXBqnZt4cYjk/SOWNqeAVFTUC3ScDOAIzos4kPf4CbguX5SKxi8gND7agH7EvKV/fS6oVxTSsRX2bSqW6zpP/bbTS0zAkh5Ef54H/IKGx1T0A5hJP3/IGd0ETeDtnspzIo5zAUVXtBfrXgifURT8eXk/ELr5gD8qCzpJkrfGSW9HdlyHXIVGeECgYEA+2hWozdMTweTPm64rouJDcm9U9wRruLT1m64KYNy5L1J6i6YDMyKP4MzoeiXMGm/yxLf99h3dL8vrCVWAyDevysTNUXVdbiALFbJNJyMNbdRfr9mChK23n+YkJuuOEB5DLxTHW5qSZZJk2vw23dcwCHJb+c6q/Y66DjG2oylHDcCgYEA3VTWTxqDEItk5SThwDUl0aIVjczzxkeZp+SDbGaFDbCxHbegEvHX/G2frw0BUdkmA5pXR+9P5AUemU41F4h3zdfqL5wyZ+8+xcaODLR6hC6W72x/HCfjqw14zM+fsdrPaaXLMhyDGeCdVGI8vCoB4AcSAZkcp8wqZQVvS98FxpkCgYEAoi3zvcR9aHnlhZ/daVPALPHYPZG4oo3Ww/yWtskCRAbL+NLn6VHFWSVlGGw3o9aEEBdz/alZnil7Mly/eLMqnj3GXVZYVmGX5YJyt4rJdBl27AHCbHsYFr5PB/I12DnXHN0b7N9+l0vo2L4IGTuNzK+/B34tviLQa1+8/9084c8CgYBhbcP9BE2njcT3PZoGkx63viLAzfSNVt1j06qqoCJ32UzOKRPU4xLRsqv1UcM/9VfPhDRhnQ3M8Rf8Ijoqxs7+FMqo9JgXunAmfXXwT84Su7ODZ344tbJ5jK+dcNP6Zbih5/Kfd3+ad46qI6haqB81L8eUXoMHtk7/Mzo/6sfPGQKBgQDbuYOKoLLc89C5E9FDIIFNl5RuKH8JRtHEGvYGum7MrNB2I8KijcJFamHVJnZj++WB+4g47vLh2w5XbFvgpXZ+2uXLtHOsoVAEHxdaNdEfBivbaMWmqp8/kh/6V8/7Y2CYmB6t15Ml2rg8O+1SHtxzqclVnzEinl/C2z9fSof8Gw==",
//				"json","utf-8",
//				"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvwMcIZAODquwOD5KC/pGWyeFNTWcVtA6AMYOUZpUGw/U2ZH+unxFkmktyu5E/NxcMyNEq6PCRWZNCERP0OYJZEbMljP43ZjmK8qqMO/LqDtEBHTJox+AjuLX0UJrgUk1cAF75zVvv1DPgaX/XlpmlBasW3CbmCf4fFqb7M3gfuJUtzhdpHXYgdlp3Qf4/ykJgrx5HB63PVXDk9SLjRgucL2Hvq4VSJnfQSriWfQS0wn8bUyZty80ww3DFJqGulHl2uhegoG35QPwIuX/CO4TVr4qFx9Xh8GMP8O1Imfwhu9l6mg87gH7ssnkwzFZFeUI04jCGoSipmgJxI1QQl5SYwIDAQAB",
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
