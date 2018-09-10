package com.dai.service.Impl;

import com.dai.common.pojo.EasyUITreeNode;
import com.dai.mapper.TbItemCatMapper;
import com.dai.pojo.TbItemCat;
import com.dai.pojo.TbItemCatExample;
import com.dai.service.ItemCatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;


/**
 * 菜品类目的服务
 * @author adrain
 *
 */
@Service("itemCatService")
public class ItemCatServiceImpl implements ItemCatService {

	@Autowired
	private TbItemCatMapper itemCatMapper;
	
	@Override
	public List<EasyUITreeNode> getItemCatList(long parentId) {
		//创建example
		TbItemCatExample example = new TbItemCatExample();
		//创建添加条件的criteria
		TbItemCatExample.Criteria criteria = example.createCriteria();
		//添加条件
		criteria.andParentIdEqualTo(parentId);
		//根据父节点查询类目列表
		List<TbItemCat> list = itemCatMapper.selectByExample(example);
		//将列表转换成EasyUITreeNode
		List<EasyUITreeNode> nodeList = new ArrayList<EasyUITreeNode>();
		for (TbItemCat itemCat : list) {
			EasyUITreeNode node = new EasyUITreeNode();
			node.setId(itemCat.getId());
			node.setText(itemCat.getName());
			node.setState(itemCat.getIsParent()?"closed":"open");
			//将节点添加到nodeList中
			nodeList.add(node);
		}
		return nodeList;
	}
	
	

}
