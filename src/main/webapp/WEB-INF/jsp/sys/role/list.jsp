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
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="roleWin" class="easyui-window" title="角色" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="roleForm" method="post">
			 <input type="hidden" name="id">
	    	<table cellpadding="5">
	    		<tr>
	    			<td>角色名称:</td>
	    			<td><input class="easyui-textbox" type="text" name="roleName" data-options="required:true"></input></td>
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

	 <div id="grantMenuWin" class="easyui-window" title="授权菜单" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="grantMenuForm" method="post">
			 <input type="hidden" name="id">
			 <table cellpadding="5">
				 <tr>
					 <td>角色名称:</td>
					 <td><input class="easyui-textbox" type="text" name="roleName" data-options="required:true"></input></td>
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
	$('#roleWin').window('close');
    $('#grantMenuWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>sys/role/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:false,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'角色ID',width:100},
	    		{field:'roleName',title:'角色名',width:100},
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

function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}
	function toEdit(){
        opt ="update";
		var sel = $('#dg').datagrid('getSelected');   
		if(sel){
			$('#roleForm').form('load',sel);
			$('#roleWin').window('open');
		}
	}
	function toAdd(){
        opt ="add";
		$('#roleForm').form('clear');
		$('#roleWin').window('open');
	}

	function submitForm(){
		 if(opt=="add"){
             addForm();
		 }
        else if(opt=="update"){
             updateForm();
        }
	}

	function addForm(){
		$('#roleForm').form('submit', {
		    url:'<%=path%>sys/role/add',
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
		        	$('#roleWin').window('close');
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}
	function updateForm(){
		$('#roleForm').form('submit', {
		    url:'<%=path%>sys/role/update',
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
		        	$('#roleWin').window('close');
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}

</script>