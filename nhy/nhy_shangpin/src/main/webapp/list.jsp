<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="myeasyui.jsp"></jsp:include>
<script type="text/javascript">
function myformatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
function myparser(s){
	if (!s) return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var d = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
}
	$(function () {
		

		$('#dg').datagrid({    
		    url:'http://127.0.0.1:8080/list',    
		    columns:[[    
		        {field:'gid',title:'ID',width:100,checkbox:true},    
		        {field:'url',title:'图片',width:100,
		        	formatter: function(value,row,index){
						return "<img width='30px' height='30px' src='/files/"+row.url+"' />"
					}

		        },    
		        {field:'gname',title:'商品名称',width:100},    
		        {field:'cname',title:'商品分类',width:100},    
		        {field:'shopdesc',title:'描述',width:100},    
		        {field:'price',title:'单价',width:100},    
		        {field:'createDate',title:'创建日期',width:100},    
		        {field:'updateDate',title:'更改日期',width:100}    
		    ]],
		    toolbar: '#tb',
		    pagination:true,
		    pageSize:4,
		    pageList:[2,4,6,8,10,20,30]
		});  
	})

	var searchShop = function () {
		//增加查询的参数
		var bdate = $('#bdate').datebox('getValue');
		var edate = $('#edate').datebox('getValue');
		var keywords = $("#keywords").val();
		 $('#dg').datagrid('load', {    
		    bdate: bdate,    
		    edate: edate,   
		    keywords: keywords   
		}); 
	}
	
	function expotShop() {
		location.href="expotShop";
	}
	//增加商品
	function toAddShop() {
		$('#add_win').window({    
		    width:600,    
		    height:400,    
		    modal:true,
		    title:"增加商品",
		    href:"add.jsp"
		    
		});  
	}
	//批量删除
	function deleteAll() {
		var rows = $('#dg').datagrid('getSelections');
		var ids="";
		$(rows).each(function () {
			ids+=","+this.gid;
		});
		$.post('deleteByIds',{ids:ids.substring(1)},function(data){
			if(data){
				$.messager.show({
					title:'我的消息',
					msg:'删除完成',
					timeout:2000,
					showType:'slide'
				});
				//刷新表格
				$('#dg').datagrid('reload');
			}
			
		},"json")
	}
	function fanxuan() {
		var rows = $('#dg').datagrid('getSelections');
		
		$('#dg').datagrid('selectAll');
		
		for (var i = 0; i < rows.length; i++) {
			var index = $('#dg').datagrid('getRowIndex',rows[i]);
			$('#dg').datagrid('unselectRow',index);
		}
	}
</script>
</head>
<body>
<table id="dg"></table>
<div id="tb">
	<div>
	日期范围
	<input  id="bdate"  type= "text" name="bdate" class= "easyui-datebox" data-options="formatter:myformatter,parser:myparser"> </input> -- 
	<input  id="edate"  type= "text" name="edate" class= "easyui-datebox" data-options="formatter:myformatter,parser:myparser"> </input>  
	<input class="easyui-textbox" name="keywords" id="keywords" prompt="商品名称 ，商品描述" style="width:150px"> 
		<a class="easyui-linkbutton" onclick="searchShop()" data-options="iconCls:'icon-search',plain:true">查询</a>
	</div>
	<div>
		<a id="btn"  onclick="deleteAll() "class="easyui-linkbutton" data-options="iconCls:'icon-remove'">批量删除</a>  
		<a id="btn"  onclick="toAddShop() " class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加商品</a>  
		<a id="btn"  onclick="expotShop() " class="easyui-linkbutton" data-options="iconCls:'icon-print'">导出examl</a>  
		<a id="btn"  onclick="fanxuan() " class="easyui-linkbutton" data-options="iconCls:'icon-print'">反选</a>  
	</div>
</div>

<div id="add_win"></div> 
  
</body>
</html>