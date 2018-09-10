package com.dai.service;

import com.dai.common.pojo.EasyUITreeNode;

import java.util.List;


/**
 * 菜品类目服务的接口
 * @author adrain
 *
 */
public interface ItemCatService {

	public List<EasyUITreeNode> getItemCatList(long parentId);
	
}
