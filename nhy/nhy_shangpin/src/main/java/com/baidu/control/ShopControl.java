package com.baidu.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.dto.Shop;
import com.baidu.mapper.IShopMapper;
import com.baidu.utils.ExcelUtils;
import com.baidu.utils.FileUtils;

@Controller
public class ShopControl {

	@Autowired
	private IShopMapper ism;
	
	@RequestMapping("list")
	@ResponseBody
	public Map<String, Object> findShops(Shop shop){
		//分页计算page页数,row记录数
		shop.setPage((shop.getPage()-1)*shop.getRows());
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", ism.findShopsCount(shop));
		map.put("rows", ism.findShops(shop));
		return map;
	}
	//导出excel
	@RequestMapping("expotShop")
	public void  expotShop(HttpServletResponse response) {
		//查询所有的商品信息
		List<Shop> list = ism.findAllShops();
		//columnNames表头信息
		String[] columnNames = {"商品名称","分类名称","价格","库存","描述"};
		//columns定义表头对应的java对象信息
		String[] columns= {"gname","cname","price","count","shopdesc"};
		
		ExcelUtils.exportExcel(response, list, columnNames, columns, "商品信息", "商品信息汇总");
	}
	
	@RequestMapping("findAllShopCategory")
	@ResponseBody
	public List<Shop> findAllShopCategory(){
		return ism.findAllShopCategory();
	}
	//删除
	@RequestMapping("deleteByIds")
	@ResponseBody
	public boolean deleteByIds(String ids){
		try {
			ism.deleteByIds(ids);
			return true;
		} catch (Exception e) {
			e.getMessage();
			return false;
		}
	}
	
	@RequestMapping("addShop")
	@ResponseBody
	public boolean addShop(Shop shop,HttpServletRequest request){
		try {
			//处理图片上传
			String newFileName = FileUtils.upload(shop.getPhoto(), request);
			shop.setUrl(newFileName);
			ism.addShop(shop);
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}
}
