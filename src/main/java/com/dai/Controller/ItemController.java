package com.dai.Controller;

import com.dai.pojo.TbItem;
import com.dai.pojo.TbItemDesc;
import com.dai.search.dao.ItemExpand;
import com.dai.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 菜品详情控制器
 * @author adrain
 *
 */
@Controller
public class ItemController {

	@Autowired
	private ItemService itemService;
	
	@RequestMapping(value = "/item/{itemId}")
	public String showItemInfo(@PathVariable("itemId") long itemId , Model model) throws Exception{
		TbItem item = itemService.getTbItemByItemId(itemId);
		TbItemDesc itemDesc = itemService.getItemDescById(itemId);
		ItemExpand itemExpand = new ItemExpand(item);
		model.addAttribute("item", itemExpand);
		model.addAttribute("itemDesc", itemDesc);
		return "product_details";
	}
	
}
