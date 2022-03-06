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
			  <c:if test="${sessionScope.loginName=='admin' or  sessionScope.loginName=='superAdmin' }">
				  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toResetExpire()" plain="true">重置过期时间</a>
			  </c:if>
			  <c:if test="${sessionScope.loginUser.roleId != 5 }">
				  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toDeleteSubAccount()" plain="true">删除服务</a>
			  </c:if>

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
							 服务
						  </TD>
						  <td class="kv-content">
							  <input class="easyui-textbox"   name="loginSubAccount"  value="" >
						  </td>
						  <TD  class="kv-label">
							  版本类型
						  </TD>
						  <td class="kv-content">
							  <input class="easyui-textbox"   name="productName"  value="" >
						  </td>

					  </tr>

					  <tr>
						  <TD  class="kv-label">
							  开通时间
						  </TD>
						  <td class="kv-content" colspan="3">
							  <input class="easyui-datetimebox"  style="width: 160px;"  name="openStartTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="openEndTime"  value="">
						  </td>

						  <TD  class="kv-label">
							  过期时间
						  </TD>
						  <td class="kv-content" colspan="3">
							  <input class="easyui-datetimebox"  style="width: 160px;"  name="expireStartTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="expireEndTime"  value="">
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
    $('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/clientAccount/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
		title:"已开通服务查询列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'id',width:100,hidden:true},
                {field:'loginName',title:'登录名',width:100},
                {field:'productId',title:'productId',width:100,hidden:true},
                {field:'loginSubAccount',title:'服务',width:100},
			    {field:'productName',title:'版本类型',width:100},
                {field:'createTime',title:'开通时间',width:200},
                {field:'expireTime',title:'过期时间',width:200},
            	{field:'expired',title:'状态',width:200,formatter:fmtExpired},
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

function toResetExpire(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.prompt('重置过期时间', '您确认要重置:【'+sel.loginName+"_"+sel.loginSubAccount+"】的过期时间吗(时间格式: 2020-01-01 19:10:10)", function(r){
                if (r){
                    doResdetExpire(sel.id,r);
                }
            });
        }
}
function doResdetExpire(id,expireTime) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientAccount/restExpireTime?id='+id+"&expireTime="+expireTime,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','重置成功!');
                    refershDg();
                }else{
                    $.messager.alert('提示','重置失败!');
                }
            }
        });
}
    function toDeleteSubAccount(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.confirm('删除服务', '您确认要删除:【'+sel.loginName+"_"+sel.loginSubAccount+"】服务吗？", function(r){
                if (r){
                    doDeleteSubAccount(sel.id,sel.loginName,sel.loginSubAccount);
                }
            });
        }
    }
    function doDeleteSubAccount(id,userLoginName,loginSubAccount) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientAccount/delete?id='+id+"&userLoginName="+userLoginName+"&loginSubAccount="+loginSubAccount,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','删除成功!');
                    refershDg();
                }else{
                    $.messager.alert('提示','删除失败!');
                }
            }
        });
    }


function refershDgProductList(){
        $('#dgProductList').datagrid('load');
}

function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}
function fmtExpired(value,row,index){
        if(!value ){
            return "正常";
        }
        else{
            return "没有可剩余时间";
        }
}


function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}



    function fmtDate(value,row,index){
        if(value !=null ){
            var date = new Date(value);
            return date.pattern("yyyy-MM-dd HH:mm:ss");
        }
        return "";
    }


</script>