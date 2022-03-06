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
			  <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="toDelete()" plain="true">删除</a>
			 <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toLoad()" plain="true">同步到缓存</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

        </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="userWin" class="easyui-window" title="黑名单" data-options="modal:true" style="width:600px;height:400px;padding:10px;">
		 <form id="userForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" id="delete_flag" >
	    	<table cellpadding="5">
				<TD  class="kv-label">
					分类
				</TD>
				<td class="kv-content">
					<select name="category">
						<option value="">全部</option>
						<option value="ip">ip</option>
						<option value="macid">macid</option>
						<option value="account">account</option>
						<option value="mail">mail</option>
					</select>
				</td>
				<tr>
					<td>名单:</td>
					<td><input  name="listnames" class="easyui-textbox"  multiline="true" data-options="required:true"  style="width:360px;height: 100px"></input></td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:false"  style="width:360px;height: 100px"></input></td>
				</tr>
			</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton"  iconCls="icon-edit" onclick="submitForm()">提交</a>
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
	    url:'<%=path%>wow/clientUserBlacklist/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
		title:"黑名单",
	    queryParams:getQueryParams,
	    pagination:false,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'id',width:100,hidden:true},
                {field:'category',title:'分类',width:100},
                {field:'listnames',title:'名单',width:200},
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
    function toDelete(){
            var sel = $('#dg').datagrid('getSelected');
            if(sel){
                $.messager.confirm('删除提示', "您确认要删除吗", function(r){
                    if (r){
                        doDelete(sel.id);
                    }
                });

            }
    }
    function doDelete(id) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientUserBlacklist/delete?id='+id,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    refershDg();
                    $.messager.alert('提示','删除成功!');
                }else{
                    $.messager.alert('提示','删除失败!');
                }
            }
        });
    }
    function toLoad(){
            $.messager.confirm('加载到缓存提示', "您确认要加载全部到缓存中吗", function(r){
                if (r){
                    doLoad();
                }
            });

    }
    function doLoad() {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientUserBlacklist/load',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    refershDg();
                    $.messager.alert('提示','同步成功!');
                }else{
                    $.messager.alert('提示','同步失败!');
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
         else if(opt=="delete"){
             deleteForm();
         }
	}

	function addForm(){
		$('#userForm').form('submit', {
		    url:'<%=path%>wow/clientUserBlacklist/save',
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
		    url:'<%=path%>wow/clientUserBlacklist/save',
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
		        	$.messager.alert('提示','操作成功!');
		        	refershDg();
		        	$('#userWin').window('close');
		        }else{
		        	$.messager.alert('提示','操作失败!');
		        }
		    }    
		});  
	}

</script>