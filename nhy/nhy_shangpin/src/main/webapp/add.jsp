<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="myeasyui.jsp"></jsp:include>

</head>
<body>
<script type="text/javascript">
	$(function () {
		$('#cid').combobox({    
		    url:'findAllShopCategory',    
		    valueField:'cid',    
		    textField:'cname'   
		});  
	})
	//增加商品
	function addShop() {
		$.messager.progress();	// 显示进度条
		$('#addForm').form('submit', {
			url: "addShop",
			onSubmit: function(){
				var isValid = $(this).form('validate');
				if (!isValid){
					$.messager.progress('close');	// 如果表单是无效的则隐藏进度条
				}
				return isValid;	// 返回false终止表单提交
			},
			success: function(data){
				if(data=="true"){
				$.messager.progress('close');	// 如果提交成功则隐藏进度条
					//关闭当前的窗口
					$('#add_win').window('close');
					//刷新表格
					$('#dg').datagrid('reload');
					//给提示
					$.messager.show({
						title:'我的消息',
						msg:'商品增加成功',
						timeout:2000,
						showType:'slide'
					});

				}else{
					//给提示
					$.messager.show({
						title:'我的消息',
						msg:'商品增加失败',
						timeout:2000,
						showType:'slide'
					});
				}
			}
		});


	}
</script>




<form id="addForm" method="post" enctype="multipart/form-data">   
    <div>   
        <label for="gname">商品名称</label>   
        <input class="easyui-validatebox" type="text" name="gname" data-options="required:true" />   
    </div>   
    <div>   
        <label for="price">商品价格</label>   
        <input class="easyui-validatebox" type="text" name="price" data-options="required:true" />   
    </div>   
    <div>   
        <label for="shopdesc">商品描述</label>   
        <input class="easyui-validatebox" type="text" name="shopdesc" data-options="required:true" />   
    </div>   
    <div>   
        <label for="cid">商品分类</label>   
        <input id="cid" name="cid">  
    </div>   
    <div>   
        <label for="photo">商品图片</label>   
        <input class="easyui-validatebox" onChange="showImg()" type="file" name="photo" />   
    </div>   
 <!--    <div>   
        <label for="createDate">创建日期</label> 
        <input  id="createDate" name="createDate" type= "text" class= "easyui-datebox" required ="required"> </input>  
    </div>   
    <div>   
        <label for="updateDate">修改日期</label>   
        <input  id="updateDate" name="createDate" type= "text" class= "easyui-datebox" required ="required"> </input>  
    </div>  -->  
    <div>   
        <label for="status">状态</label>   
        <select id="status" class="easyui-combobox" name="status" style="width:200px;">   
    		<option value="0">上架</option>   
    		<option value="1">下架</option>   
		</select>  
    </div>   
    <div>   
        <label for="count">购买的数量</label>   
        <input class="easyui-validatebox" type="text" name="count" data-options="required:true" />   
    </div>   
     <a id="btn" class="easyui-linkbutton" onclick="addShop()" data-options="iconCls:'icon-add'">添加</a>  
</form>
	
  
</body>
</html>