<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%String path = request.getContextPath()+"/"; %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 

 <jsp:include page="../../include.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>js/fmt_date.js"></script>
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
							  发布状态
						  </TD>
						  <td class="kv-content">
							  <select name="releaseStatus" >
								  <option value="" selected>请选择</option>
								  <option value="1" selected>已发布</option>
								  <option value="2">暂存</option>
							  </select>
						  </td>

						  <td>版本分类:</td>
						  <td>
							  <select name="versionType" >
								  <option value="" selected>请选择</option>
								  <option value="1" selected>对外版本</option>
								  <option value="2">对内版本</option>
							  </select>
						  </td>
					  </tr>

				  </table>
			  </form>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
		  </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="optWin" class="easyui-window" title="版本信息" data-options="modal:true" style="width:600px;height:600px;padding:10px;">
		 <form id="optForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
	    	<table cellpadding="5">
	    		<tr>
	    			<td>appId:</td>
	    			<td><input class="easyui-textbox" type="text" name="appId" data-options="required:true"></input></td>
	    		</tr>
				<tr>
					<td>版本号:</td>
					<td><input class="easyui-textbox" type="text" name="versionNo" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>显示版本名称:</td>
					<td><input class="easyui-textbox" type="text" name="versionName" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>版本分类:</td>
					<td>
						<select name="versionType" >
							<option value="1" selected>对外版本</option>
							<option value="0">对内版本</option>
						</select>
					</td>
				</tr>
				</tr>
				<tr>
					<td>更新说明 </td>
					<td><input class="easyui-textbox" type="text" multiline="true"  name="description" data-options="required:true"    style="width:360px;height: 200px"></input></td>
				</tr>
				<tr>
					<td>备注 </td>
					<td><input class="easyui-textbox" type="text" multiline="true"  name="remark" data-options="required:true"  style="width:360px;height: 100px" ></input></td>
				</tr>
				<tr>
					<td>发布状态:</td>
					<td>
						<select name="releaseStatus">
							<option value="1" selected>已发布</option>
							<option value="0">暂存</option>
						</select>
					</td>
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
	    url:'<%=path%>wow/clientVersion/list',
	    loadMsg:'正在加载数据，请稍后...',
        title:"客户端版本列表",
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,hidden:true},
                {field:'appId',title:'appId',width:100},
                {field:'versionNo',title:'版本号',width:200},
			    {field:'versionName',title:'显示版本名称',width:200},
			    {field:'versionType',title:'版本分类',width:100,formatter:fmtVersionType},
                {field:'releaseStatus',title:'发布状态',width:200,formatter:fmtReleaseStatus},
                {field:'releaseTime',title:'发布时间',width:200,formatter:fmtDate},
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
function fmtReleaseStatus(value,row,index){
        if(value =="1" ){
            return "已发布";
        }
        else if(value =="2" ){
            return "暂存";
        }
        return "";
}
function fmtVersionType(value,row,index){
        if(value =="2" ){
            return "对内版本";
        }
        else if(value =="1" ){
            return "对外版本";
        }
        return "";
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
        $('#optWin').form('clear');
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

	function addForm(){
		$('#optForm').form('submit', {
		    url:'<%=path%>wow/clientVersion/add',
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
		        	$.messager.alert('提示','保存失败!，失败原因：'+d.msg);
		        }
		    }    
		});  
	}
	function updateForm(){
		$('#optForm').form('submit', {
		    url:'<%=path%>wow/clientVersion/save',
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
    function fmtDate(value,row,index){
        if(value !=null ){
            var date = new Date(value);
            return date.pattern("yyyy-MM-dd HH:mm:ss");
        }
        return "";
    }

</script>