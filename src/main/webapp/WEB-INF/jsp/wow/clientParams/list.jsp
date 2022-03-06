<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%String path = request.getContextPath()+"/"; %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<script type="text/javascript" src="<%=path%>js/fmt_date.js"></script>
 <jsp:include page="../../include.jsp"></jsp:include>
   
 <div class="easyui-layout" >
	 <!-- Begin of toolbar -->
      <div id="tb">
        <div class="wu-toolbar-button" >
        	  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAdd()" plain="true">新增</a>
        	  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toEdit()" plain="true">编辑</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

        </div>

		  <div class="wu-toolbar-search">
			  <form id="form">
				  <table  class="kv-table">

					  <tr>
						  <TD  class="kv-label">
							   版本
						  </TD>
						  <td class="kv-content">
							  <select name="locale" >
								  <option value="" selected>请选择</option>
								  <option value="zhCN" selected>国服</option>
								  <option value="zhTW">台服</option>
								  <option value="enUS">美服</option>
							  </select>
						  </td>
						  <TD  class="kv-label">
							  名称
						  </TD>
						  <td class="kv-content">
							   <input name="title" class="easyui-textbox" >
						  </td>
						  <TD  class="kv-label">
							  键
						  </TD>
						  <td class="kv-content">
							  <input name="key" class="easyui-textbox" >
						  </td>
					  </tr>
					  <tr>
						  <TD  class="kv-label">
							  值
						  </TD>
						  <td class="kv-content">
							  <input name="value" class="easyui-textbox" >
						  </td>
						  <TD  class="kv-label">
							  备注
						  </TD>
						  <td class="kv-content">
							  <input name="remark" class="easyui-textbox" >
						  </td>
						  <TD  class="kv-label">

						  </TD>
						  <td class="kv-content">

						  </td>
					  </tr>

				  </table>
			  </form>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
		  </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="optWin" class="easyui-window" title="客户端系统参数设置" data-options="modal:true" style="width:460px;height:500px;padding:10px;">
		 <form id="optForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
	    	<table cellpadding="5">

				<tr>
					<td>版本:</td>
					<td>
						<select name="locale" >
							<option value="" selected>请选择</option>
							<option value="zhCN" selected>国服</option>
							<option value="zhTW">台服</option>
							<option value="enUS">美服</option>
						</select>
					</td>
				</tr>

	    		<tr>
	    			<td>名称:</td>
	    			<td><input class="easyui-textbox" type="text" name="title" data-options="required:true"></input></td>
	    		</tr>
				<tr>
					<td>键:</td>
					<td><input class="easyui-textbox" type="text" name="key" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>值:</td>
					<td><input  name="value" class="easyui-textbox"  multiline="true" data-options="required:true"  style="width:360px;height: 180px"></input></td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:false"  style="width:360px;height: 100px"></input></td>
				</tr>
			</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">提交</a>
	    </div>
	</div>

	<pre>

	</pre>
</div>

 
<script type="text/javascript">
    var opt = null;
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
	$('#optWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/clientParams/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'id',width:100,hidden:true},
                {field:'locale',title:'版本',width:200},
                {field:'title',title:'名称',width:200},
                {field:'key',title:'键',width:200},
                {field:'value',title:'值',width:200},
                {field:'remark',title:'备注',width:200}
	    ]]
	});  
});

function optClear(){
	$('#optForm').form('clear');
}
function refershDg(){
	$('#dg').datagrid('load');
}
function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}


function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}
	function toEdit(){
        opt ="update";
		var sel = $('#dg').datagrid('getSelected');   
		if(sel){
			$('#optForm').form('load',sel);
			$('#optWin').window('open');
		}
	}
    function toAdd(){
        opt ="add";
        optClear();
        $('#optWin').window('open');
	}

	function submitForm(){
		 if(opt=="add"){
             addForm();
		 }
        else if(opt=="update"){
             updateForm();
        }
	}
    function fmtLocale(value,row,index){
        if(value =="zhCN" ){
            return "国服";
        }
        else if(value =="zhTW" ){
            return "台服";
        }
        else if(value =="enUS" ){
            return "美服";
        }
        return "";
    }
	function addForm(){
		$('#optForm').form('submit', {
		    url:'<%=path%>wow/clientParams/save',
		    onSubmit: function(){
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
		    success:function(data){    
		        var d = eval("("+data+")") ;
		        if("success" == d.msg ){
		        	$.messager.alert('提示','保存成功!');   
		        	refershDg();
		        	$('#userWin').window('close');
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}
	function updateForm(){
		$('#optForm').form('submit', {
		    url:'<%=path%>wow/clientParams/save',
		    onSubmit: function(){
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
		    },    
		    success:function(data){    
		        var d = eval("("+data+")") ;
		        if("success" == d.msg ){
		        	$.messager.alert('提示','保存成功!'); 
		        	refershDg();
		        	$('#optWin').window('close');
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}

</script>