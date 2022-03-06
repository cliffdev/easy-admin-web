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
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="toRestPassword()" plain="true">重置密码</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

        </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="userWin" class="easyui-window" title="用户" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="userForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
	    	<table cellpadding="5">
	    		<tr>
	    			<td>用户名:</td>
	    			<td><input class="easyui-textbox" type="text" name="userName" data-options="required:true"></input></td>
	    		</tr>
				<tr>
					<td>登录名:</td>
					<td><input class="easyui-textbox" type="text" name="loginName" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>角色ID:</td>
					<td>

						<select id="roleId"  class="easyui-combogrid" name="roleId" style="width:100px;"
								data-options="
								panelWidth:450,
								idField:'id',
								textField:'id',
								 url:'<%=path%>sys/role/list',
								 loadFilter: function(data){
									if (data.rows){
										return data.rows;
									} else {
										return data;
									}
								 },
								  columns:[[
									{field:'id',title:'角色ID',width:100},
									{field:'roleName',title:'角色名',width:100},
									{field:'remark',title:'备注',width:200}
								]]
							"></select>
					</td>
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
	$('#userWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>sys/user/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:false,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'用户ID',width:100},
                {field:'userName',title:'用户名',width:100},
                {field:'loginName',title:'登录名',width:100},
                {field:'roleId',title:'角色ID',width:100},
            	{field:'createTime',title:'createTime',width:200,hidden:true},
            	{field:'updateTime',title:'updateTime',width:200,hidden:true},
                {field:'deleteFlag',title:'deleteFlag',width:200,hidden:true},
	    		{field:'remark',title:'备注',width:200}

	    ]]
	});  
});

function optClear(){
	$('#userForm').form('clear');
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
			$('#userForm').form('load',sel);
			$('#userWin').window('open');
		}
	}
    function toRestPassword(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.prompt('重置密码', '您确认要重置:【'+sel.userName+"】的密码吗", function(r){
                if (r){
                    restPassword(sel.id,r);
                }
            });

        }
    }


    function restPassword(userId,password) {
        $.ajax({
            type: "POST",
            url: '<%=path%>sys/user/restPassword?id='+userId+"&password="+password,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','重置成功!');
                }else{
                    $.messager.alert('提示','重置失败!');
                }
            }
        });
    }

    function toAdd(){
        opt ="add";
		optClear();
        $('#userWin').window('open');
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
		$('#userForm').form('submit', {
		    url:'<%=path%>sys/user/save',
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
		$('#userForm').form('submit', {
		    url:'<%=path%>sys/user/save',
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

</script>