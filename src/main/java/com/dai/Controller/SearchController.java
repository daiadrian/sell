package com.dai.Controller;

import com.dai.common.pojo.SearchResult;
import com.dai.service.SearchService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * 站内搜索的控制器
 * @author adrain
 *
 */
@Controller
public class SearchController {
	
	@Autowired
	private SearchService searchService;
	@Value("${PAGE_ROWS}")
	private String PAGE_ROWS;

	@RequestMapping(value = "/search")
	public String search(
			String keyword,@RequestParam(defaultValue="1") Integer page, Model model) throws Exception {
		//keyword为空查询全部
		SearchResult result = null;
		if (!StringUtils.isNotBlank(keyword)){
			result = searchService.searchALL(page, Integer.parseInt(PAGE_ROWS));
		}else{
			//keyword = new String(keyword.getBytes("iso8859-1"), "utf-8");
			//调用Service查询商品信息
			result = searchService.search(keyword, page, Integer.parseInt(PAGE_ROWS));
		}
		//把结果传递给jsp页面
		model.addAttribute("query", keyword);
		model.addAttribute("totalPages", result.getTotalPages());
		model.addAttribute("recourdCount", result.getRecordCount());
		model.addAttribute("page", page);
		model.addAttribute("itemList", result.getItemList());
		//返回逻辑视图
		return "products";
	}
	
	@RequestMapping(value="/search/searchTitle")
	public String searchTitle(
			String keyword,@RequestParam(defaultValue="1") Integer page, Model model) throws Exception {
		keyword = new String(keyword.getBytes("iso8859-1"), "utf-8");
		//调用Service查询商品信息 
		SearchResult result = searchService.searchTitle(keyword, page, Integer.parseInt(PAGE_ROWS));
		//把结果传递给jsp页面
		model.addAttribute("query", keyword);
		model.addAttribute("totalPages", result.getTotalPages());
		model.addAttribute("recourdCount", result.getRecordCount());
		model.addAttribute("page", page);
		model.addAttribute("itemList", result.getItemList());
		//返回逻辑视图
		return "products";
	}



	
}
