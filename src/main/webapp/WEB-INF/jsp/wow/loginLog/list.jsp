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
                              服务
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="loginSubAccount"  value="" >
                          </td>
                          <TD  class="kv-label">
                              登录IP
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="loginIp"  value="" >
                          </td>
                      </tr>
                      <tr>
                          <TD  class="kv-label">
                              登录时间
                          </TD>
                          <td class="kv-content" colspan="3">
                              <input class="easyui-datetimebox"  style="width: 160px;"  name="startTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="endTime"  value="">
                          </td>
                          <td class="kv-content">
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
	    url:'<%=path%>wow/loginLog/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
        title:"登录日志列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,hidden:true},
                {field:'loginName',title:'登录名',width:100},
                {field:'loginSubAccount',title:'服务',width:100},
                {field:'loginIp',title:'登录IP',width:200},
                {field:'loginTime',title:'登录时间',width:200,formatter:fmtDate},
	    		{field:'platform',title:'终端',width:200},
				{field:'loginResult',title:'登录结果',width:200}

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


    function fmtDate(value,row,index){
        if(value !=null ){
            var date = new Date(value);
            return date.pattern("yyyy-MM-dd hh:mm:ss");
        }
        return "";
    }
</script>