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
                  <input  name="groupBy" id="downloadGroupBy" value="" type="hidden">
                  <table  class="kv-table">

                      <tr>
                          <td>阵营:</td>
                          <td>
                              <SELECT NAME="groupName">
                                  <option VALUE="" selected>全部</option>
                                  <option VALUE="联盟">联盟</option>
                                  <option VALUE="部落">部落</option>
                              </SELECT>
                          </td>

                          <td>登录名:</td>
                          <td>
                              <input class="easyui-textbox"   name="loginName"  value="" >
                          </td>
                          <td>队长:</td>
                          <td>
                              <input class="easyui-textbox"   name="teamLeader"  value="" >
                          </td>
                          <td>队员:</td>
                          <td>
                              <input class="easyui-textbox"   name="members"  value="" >
                          </td>
                      </tr>

                      <tr>
                          <td>服务器:</td>
                          <td>
                              <input class="easyui-textbox"   name="loginRealm"  value="" >
                          </td>
                          <td>角色:</td>
                          <td>
                              <input class="easyui-textbox"   name="loginChar"  value="" >
                          </td>
                          <td>脚本名称:</td>
                          <td>
                              <input class="easyui-textbox"   name="scriptName"  value="" >
                          </td>
                          <td>子脚本名称:</td>
                          <td>
                              <input class="easyui-textbox"   name="subScriptName"  value="" >
                          </td>
                      </tr>
                      <tr>
                          <TD  class="kv-label">
                              创建时间
                          </TD>
                          <td class="kv-content" colspan="3">
                              <input class="easyui-datetimebox"  style="width: 160px;"  name="createStartTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="createEndTime"  value="">
                          </td>
                          <td> </td>
                          <td>
                          </td>
                          <td> </td>
                          <td>
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
    $('#createCardNoWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/clientTeamInfo/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
        title:"组队管理列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,checkbox:false,hidden:true},
                {field:'groupName',title:'阵营',width:100},
                {field:'loginName',title:'登录名',width:120},
                {field:'teamLeader',title:'队长',width:120},
                {field:'members',title:'队员',width:260},
                {field:'scriptName',title:'脚本名称',width:120},
                {field:'subScriptName',title:'子脚本名称',width:120},
                {field:'loginRealm',title:'服务器',width:120},
                {field:'loginChar',title:'角色',width:100},
                {field:'action',title:'action',width:80},
                {field:'createTime',title:'创建时间',width:200,formatter:fmtDate}
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

    function fmtDate(value,row,index){
        if(value !=null ){
            var date = new Date(value);
            return date.pattern("yyyy-MM-dd HH:mm:ss");
        }
        return "";
    }


</script>