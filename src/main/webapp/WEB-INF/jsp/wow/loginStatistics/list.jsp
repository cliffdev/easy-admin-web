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
                              账号
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="accountName"  value="" >
                          </td>

                          <td>登录日期:</td>
                          <td class="kv-content">
                              <input class="easyui-datebox"   name="loginDate"  value="" >
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
	    url:'<%=path%>wow/loginStatistics/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,hidden:true},
                {field:'accountName',title:'账号',width:100},
                {field:'loginDate',title:'日期',width:200},
                {field:'number',title:'登录次数',width:200}

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
            return date.pattern("yyyy-MM-dd HH:mm:ss");
        }
        return "";
    }
</script>