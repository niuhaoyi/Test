package com.baidu.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.baidu.dto.Shop;

@Mapper
public interface IShopMapper {
	public List<Shop> findShops(Shop shop);
	
	public List<Shop> findShopsCount(Shop shop);

	public List<Shop> findAllShops();
	
	public List<Shop> findAllShopCategory();

	public void addShop(Shop shop);

	public void deleteByIds(String ids);
}
