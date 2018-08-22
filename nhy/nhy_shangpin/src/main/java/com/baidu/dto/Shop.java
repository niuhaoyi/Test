package com.baidu.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Shop {

	private Integer gid;
	private String gname;
	private Integer cid;
	private String cname;
	private Double price;
	private Integer count;
	private String shopdesc;
	private String url;
	private String createDate;
	private String updateDate;
	
	private Integer page;
	private Integer rows;
	
	private String bdate;
	private String edate;
	private String keywords;
	
	//商品图片对象
	private MultipartFile photo;
	
	private String status;
}
