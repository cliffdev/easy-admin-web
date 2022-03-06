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


	<div id="userWin" class="easyui-window" title="通知" data-options="modal:true" style="width:550px;height:600px;padding:10px;">
		 <form id="userForm" method="post"   enctype="multipart/form-data">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
			 <input type="hidden" name="attachList" >
	    	<table cellpadding="5">
				<tr>
					<td>分类:</td>
					<td>
						<select name="catalog">
							<option value="1" selected>客户端公告</option>
							<option value="2">网页公告</option>
						</select>
					</td>
				</tr>
	    		<tr>
	    			<td>标题:</td>
	    			<td><input class="easyui-textbox" type="text" name="title" data-options="required:true" style="width: 400px"></input></td>
	    		</tr>
				<tr>
					<td>适合版本:</td>
					<td><input class="easyui-textbox" type="text" name="targetAppVersion" data-options="required:true" maxlength="500" style="width: 400px"></input></td>
				</tr>
				<tr>
					<td>内容:</td>
					<td><input  name="content" class="easyui-textbox"  multiline="true" data-options="required:true"  style="width:400px;height: 300px"></input></td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:true" maxlength="500" style="width:400px;height: 50px"></input></td>
				</tr>
				<tr>
					<td>发布状态:</td>
					<td>
						<select name="status">
							<option value="1">草稿</option>
							<option value="2">发布</option>
						</select>
					</td>
				</tr>

				<tr>
					<td>附件:</td>
					<td>

						<input name="file" type="file"> <br>
						<input name="file" type="file"> <br>
						<input name="file" type="file"> <br>
						<input name="file" type="file"> <br>
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
	$('#userWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>sys/notice/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'通知ID',width:100,hidden:true},
                {field:'catalog',title:'分类',width:200,formatter:fmtCatalog},
                {field:'title',title:'标题',width:200},
                {field:'targetAppVersion',title:'适用版本',width:100},
                {field:'status',title:'状态',width:100,formatter:fmtStatus},
            	{field:'createTime',title:'createTime',width:200,hidden:true},
            	{field:'updateTime',title:'updateTime',width:200,hidden:true},
                {field:'deleteFlag',title:'deleteFlag',width:200,hidden:true},
                {field:'content',title:'content',width:200,hidden:true},
                {field:'remark',title:'备注',width:300}

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
        $('#userForm').form('clear');
        var sel = $('#dg').datagrid('getSelected');
		if(sel){
			$('#userForm').form('load',sel);
			$('#userWin').window('open');
		}
	}

    function toAdd(){
        opt ="add";
        $('#userForm').form('clear');
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
    function  fmtStatus(value, row, index){
        if("1" ==value ){
            return "草稿";
        }
        else if("2" == value){
            return "发布";
        }
        return "";
    }
    function  fmtCatalog(value, row, index){
        if("1" ==value ){
            return "客户端公告";
        }
        else if("2" == value){
            return "网页公告";
        }
        return "";
    }
	function addForm(){
		$('#userForm').form('submit', {
		    url:'<%=path%>sys/notice/add',
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
		    url:'<%=path%>sys/notice/save',
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