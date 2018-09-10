package com.dai.search.dao;


import com.dai.pojo.TbItem;

@SuppressWarnings("serial")
public class ItemExpand extends TbItem {

	public ItemExpand(TbItem tbItem) {
		this.setId(tbItem.getId());
		this.setTitle(tbItem.getTitle());
		this.setSellPoint(tbItem.getSellPoint());
		this.setPrice(tbItem.getPrice());
		this.setImage(tbItem.getImage());
		this.setCid(tbItem.getCid());
		this.setStatus(tbItem.getStatus());
		this.setCreated(tbItem.getCreated());
		this.setUpdated(tbItem.getUpdated());
	}
	
	public String[] getImages(){
		String image = this.getImage();
		if(image!=null && !"".equals(image)){
			return image.split(",");
		}
		return null;
	}
	
}
