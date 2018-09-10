package com.dai.Controller;


import java.util.ArrayList;
import java.util.List;

import com.dai.pojo.TbContent;
import com.dai.service.ContentService;
import com.dai.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 前台首页控制器
 * @author adrain
 *
 */
@Controller
public class IndexController {

	@Value(value="${DEFAULT_CATEGORY_ID}")
	private long DEFAULT_CATEGORY_ID;
	
	@Autowired
	private ContentService contentService;
	@Autowired
	private ItemService itemService;
	
	@RequestMapping("/index")
	public String getContentList(Model model){
		List<TbContent> list = contentService.getContentList(DEFAULT_CATEGORY_ID);
		List<TbContent> contentUpfristList = new ArrayList<>();
		List<TbContent> contentUpsecondList = new ArrayList<>();
		List<TbContent> contentDownList = new ArrayList<>();
		for (int i = 0,size = list.size();i < size; i++){
			if (i<4)
				contentUpfristList.add(list.get(i));
			if (i>=4)
				contentUpsecondList.add(list.get(i));
			if (i<6)
				contentDownList.add(list.get(i));
		}
		model.addAttribute("contentUpfristList", contentUpfristList);
		model.addAttribute("contentUpsecondList", contentUpsecondList);
		model.addAttribute("contentDownList", contentDownList);
		return "index";
	}
	
}
