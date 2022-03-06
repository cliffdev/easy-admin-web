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
        <c:if test="${sessionScope.loginName=='admin' or  sessionScope.loginName=='superAdmin' }">
                      <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="toDeleteOnlineAccount()" plain="true">T下线</a>
                    <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="toSendScriptCmd()" plain="true">发送收集脚本命令</a>
        </c:if>
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
                              APP版本
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="appVersion"  value="" >
                          </td>
                          <TD  class="kv-label">
                              ip地址
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="ipAddress"  value="" >
                          </td>
                      </tr>
                      <tr>
                          <TD  class="kv-label">
                              服务器
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="loginRealm"  value="" >
                          </td>
                          <TD  class="kv-label">
                              游戏账号
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="accountName"  value="" >
                          </td>
                          <TD  class="kv-label">
                              角色
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="loginChar"  value="" >
                          </td>
                          <TD  class="kv-label">
                             子账号
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="loginBnAccount"  value="" >
                          </td>

                      </tr>
                  </table>
              </form>
              <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
          </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


     <div id="createApiDescWin" class="easyui-window" title="接口信息" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
         <form id="createApiDescForm" method="post">
             <input type="hidden" name="id" value="">
             <table cellpadding="5">
                 <tr>
                     <td>名称:</td>
                     <td><input class="easyui-textbox" type="text" name="interfaceName" data-options="required:true"></input></td>
                 </tr>
                 <tr>
                     <td>参数:</td>
                     <td><input class="easyui-textbox" type="text" name="interfaceArgs" data-options="required:true"></input></td>
                 </tr>
                 <tr>
                     <td>返回值:</td>
                     <td><input class="easyui-textbox" type="text" name="interfaceResult" data-options="required:true"></input></td>
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
    $('#createApiDescWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/onlineAccount/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
        title:"在线游戏账号列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,hidden:true},
                {field:'server',title:'服务器编号',width:60},
                {field:'loginName',title:'登录名',width:120},
                {field:'loginSubAccount',title:'服务',width:80},
                {field:'accountName',title:'游戏账号',width:200},
                {field:'loginRealm',title:'服务器',width:160},
                {field:'loginChar',title:'角色',width:160},
                {field:'loginBnAccount',title:'子账号',width:100},
                {field:'ipAddress',title:'ip地址',width:200},
                {field:'appVersion',title:'app版本',width:200},
                {field:'dllVersion',title:'dll版本',width:200},
                {field:'clientId',title:'客户端ID',width:200,hidden:true},
                {field:'socketId',title:'socketId',width:200,hidden:true}
	    ]]
	});  
});

function optClear(){
	$('#form').form('clear');    
}
function refershDg(){
	$('#dg').datagrid('load');
}
function toEdit() {
    opt ="update";
    var sel = $('#dg').datagrid('getSelected');
    if(sel){
        $('#createApiDescForm').form('load',sel);
        $('#createApiDescWin').window('open');
    }
}
function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}
function optDownload(){
    var arg = $('#form').serialize();
    window.location.href='<%=path%>wow/card/download?'+arg;
}
function fmtState(value,row,index){
        if(value =="0" ){
            return "未使用";
        }
        else if(value =="1" ){
            return "已使用";
        }
        else if(value =="2" ){
            return "已停用";
        }
        return "";
}
function fmtCardState(value,row,index){
        if(value =="0" ){
            return "正常";
        }
        else if(value =="1" ){
            return "已使用";
        }
        else if(value =="2" ){
            return "已停用";
        }
        return "";
}
function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}

 function toCreate() {
     opt="add";
     $('#createApiDescWin').window('open');
     $('#createApiDescForm').form('clear');

 }

    function submitForm(){
        if(opt=="add"){
            submitCreateForm();
        }
        else if(opt=="update"){
            submitUpdateForm();
        }
    }

    function fmtCardType(value,row,index){
        if(value !=null ){

            if("1" ==value){
                return "月卡";
            }
            else if("2" ==value){
                return "季卡";
            }
            else if("3" ==value){
                return "年卡";
			}
            else if("4" ==value){
                return "日卡";
            }

        }
        return "未知";
}

    function fmtDate(value,row,index){
        if(value !=null ){
            var date = new Date(value);
            return date.pattern("yyyy-MM-dd HH:mm:ss");
        }
        return "";
    }

    function submitCreateForm(){
        var isValid = $('#createApiDescForm').form('validate');
        if (!isValid){
          return ;
        }
        $.messager.confirm('创建接口信息', '您确认要保存吗', function(r){
            if (r){
                sendCreateApiData();
            }
        });
    }
    function submitUpdateForm(){
        var isValid = $('#createApiDescForm').form('validate');
        if (!isValid){
            return ;
        }
        $.messager.confirm('创建接口信息', '您确认要保存吗', function(r){
            if (r){
                sendUpdateApiData();
            }
        });
    }
    function sendUpdateApiData() {
        $('#createApiDescForm').form('submit', {
            url:'<%=path%>wow/apiDesc/save',
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
    function sendCreateApiData() {
        $('#createApiDescForm').form('submit', {
            url:'<%=path%>wow/apiDesc/add',
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

    function toSendScriptCmd(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.prompt('发送收集脚本', '向:【'+sel.loginName+"-"+sel.loginSubAccount+"】发送收集脚本吗", function(r){
                if (r){
                    doSendScriptCmd(sel.id,r);
                }
            });
        }
    }
    function doSendScriptCmd(id,scriptName) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/uploadScript/send?id='+id+"&scriptName="+scriptName,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','发送成功!');
                    refershDg();
                }else{
                    $.messager.alert('提示','发送失败!');
                }
            }
        });
    }
    function toDeleteOnlineAccount(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.prompt('T下线', '您确认要T下线:【'+sel.loginName+"-"+sel.loginSubAccount+"】吗", function(r){
                if (r){
                    doDeleteOnlineAccount(sel.id,r);
                }
            });
        }
    }

    function doDeleteOnlineAccount(id,clientType) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/onlineAccount/deleteOnlineAccount?id='+id+"&clientType="+clientType,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','T下线成功!');
                    refershDg();
                }else{
                    $.messager.alert('提示','T下线失败!');
                }
            }
        });
    }

</script>