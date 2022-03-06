<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%String path = request.getContextPath()+"/"; %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<script type="text/javascript" src="<%=path%>js/fmt_date.js"></script>
 <jsp:include page="../include.jsp"></jsp:include>
   
 <div class="easyui-layout" >
	 <!-- Begin of toolbar -->
      <div id="tb">
        <div class="wu-toolbar-button" >
        	  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAdd()" plain="true">新增</a>
        	  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toEdit()" plain="true">编辑</a>
        	   <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="toCache()" plain="true">同步到缓存</a>
        	   <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>
        </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="addWin" class="easyui-window" title="参数" data-options="modal:true" style="width:400px;height:300px;padding:10px;">
		 <form id="addForm" method="post">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>参数名:</td>
	    			<td><input class="easyui-textbox" type="text" name="paramName" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>参数值:</td>
	    			<td><input class="easyui-textbox" type="text" name="paramValue" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td><input class="easyui-textbox" type="text" name="remark" data-options="required:true"></input></td>
	    		</tr>
	    	</table>
	    	
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	    </div>
	</div>
	
	<div id="updateWin" class="easyui-window" title="编辑参数" data-options="modal:true" style="width:400px;height:300px;padding:10px;">
		 <form id="updateForm" method="post">
			 <input class="easyui-textbox" type="hidden"  name="id"  ></input>
	    	<table cellpadding="5">
	    		<tr>
	    			<td>参数名:</td>
	    			<td><input class="easyui-textbox" type="text" name="paramName" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>参数值:</td>
	    			<td><input class="easyui-textbox" type="text" name="paramValue" data-options="required:true"></input></td>
	    		</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td><input class="easyui-textbox" type="text" name="remark" data-options="required:true"></input></td>
	    		</tr>
	    	</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateForm()">提交</a>
	    </div>
	</div>
	
	<pre>
	

	</pre>
</div>

 <div style="display: none;">
 		<form action="" id="tmpForm" method="post">
 			<input type="hidden" id="tmpStr" name="id"> 
 		</form>
 </div>
<script type="text/javascript">
$.fn.serializeObject = function()  
{  
   var o = {};  
   var a = this.serializeArray();  
   $.each(a, function() {  
       if (o[this.name]) {  
           if (!o[this.name].push) {  
               o[this.name] = [o[this.name]];  
           }  
           o[this.name].push(this.value || '');  
       } else {  
           o[this.name] = this.value || '';  
       }  
   });  
   return o;  
};
$(document).ready(function(){
	$('#updateWin').window('close');  
	$('#addWin').window('close');  
	
	$('#dg').datagrid({    
	    idField:'id',
	    url:'<%=path%>params/list.json',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:false,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,hidden:true},
	    		{field:'paramName',title:'参数名',width:200},
	    		{field:'paramValue',title:'参数值',width:200},
	    		{field:'remark',title:'备注',width:200}
	    ]]
	});  
});

function optClear(){
	$('#form').form('clear');    
}
function refershDg(){
	$('#dg').datagrid('load');

}
function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}
function fmtDate(value,row,index){
	if(value !=null ){
		var date = new Date(value);
		return date.pattern("yyyy-MM-dd HH:mm:ss");
	}
	return "";
}

function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}
	function fmt_opt(){
		return '<a href="javascript:openDetails()" >查看</a>';
	}
	
	function toEdit(){
		var sel = $('#dg').datagrid('getSelected');   
		if(sel){
			$('#updateForm').form('load',sel);
			$('#updateWin').window('open');  
		}
	}
	function toAdd(){
		$('#updateForm').form('clear');
		$('#addWin').window('open');  
	}
	 
	function submitForm(){
		$('#addForm').form('submit', {    
		    url:'<%=path%>params/save.json',
		    onSubmit: function(){    
		      	return true;  
		    },    
		    success:function(data){    
		        var d = eval("("+data+")") ;
		        if("success" == d.msg ){
		        	$.messager.alert('提示','保存成功!');   
		        	refershDg();
		        	$('#addWin').window('close');  
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}
	
	function toCache(){
		$('#tmpForm').form('submit', {    
		    url:'<%=path%>param/syn.json',    
		    onSubmit: function(){    
		      	return true;  
		    },    
		    success:function(data){    
		        var d = eval("("+data+")") ;
		        if("success" == d.msg ){
		        	$.messager.alert('提示','操作成功!'); 
		        	refershDg();
		        	$('#updateWin').window('close');  
		        }else{
		        	$.messager.alert('提示','操作失败!');    
		        }
		    }    
		});  
	}
	function updateForm(){
		$('#updateForm').form('submit', {    
		    url:'<%=path%>params/save.json',
		    onSubmit: function(){    
		      	return true;  
		    },    
		    success:function(data){    
		        var d = eval("("+data+")") ;
		        if("success" == d.msg ){
		        	$.messager.alert('提示','保存成功!'); 
		        	refershDg();
		        	$('#updateWin').window('close');  
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}
</script>