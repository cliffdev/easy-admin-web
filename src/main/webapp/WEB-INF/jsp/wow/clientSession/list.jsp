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
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

        </div>
		  <div class="wu-toolbar-search">
			  <form id="form">
				  <table  class="kv-table">

					  <tr>
						  <TD  class="kv-label">
							  登录名
						  </TD>
						  <td class="kv-content">
							  <input class="easyui-textbox"   name="loginName"  value="" >
						  </td>
						  <TD  class="kv-label">
							  IP
						  </TD>
						  <td class="kv-content">
							  <input class="easyui-textbox"   name="loginIp"  value="" >
						  </td>
					  </tr>

				  </table>
			  </form>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
		  </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>

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
	    url:'<%=path%>wow/clientSession/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'id',width:100,hidden:true},
                {field:'loginName',title:'登录名',width:100},
                {field:'loginIp',title:'登录IP',width:200},
                {field:'loginTime',title:'注册时间',width:200,formatter:fmtDate},
                {field:'lastActiveTime',title:'最后active时间',width:200,formatter:fmtDate},
	    		{field:'token',title:'token',width:200}

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
function fmtState(value,row,index){
        if(value =="0" ){
            return "正常";
        }
        else if(value =="1" ){
            return "禁用";
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
			$('#userForm').form('load',sel);
			$('#userWin').window('open');
		}
	}
    function toRestPassword(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.prompt('重置密码', '您确认要重置:【'+sel.accountname+"】的密码吗", function(r){
                if (r){
                    restPassword(sel.id,r);
                }
            });

        }
    }

    function restPassword(userId,password) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/account/restPassword?id='+userId+"&password="+password,
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
        $('#userWin').form('clear');
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
		    url:'<%=path%>wow/account/add',
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
		        	$.messager.alert('提示','保存失败!，失败原因：'+d.msg);
		        }
		    }    
		});  
	}
	function updateForm(){
		$('#userForm').form('submit', {
		    url:'<%=path%>wow/account/save',
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
    function fmtDate(value,row,index){
        if(value !=null ){
            var date = new Date(value);
            return date.pattern("yyyy-MM-dd HH:mm:ss");
        }
        return "";
    }
</script>