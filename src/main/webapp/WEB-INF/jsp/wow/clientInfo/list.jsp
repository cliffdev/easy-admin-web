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
              <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toCreate()" plain="true">添加</a>
        	  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toEdit()" plain="true">编辑</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

        </div>

          <div class="wu-toolbar-search">
              <form id="form">
                  <table  class="kv-table">

                      <tr>
                          <TD  class="kv-label">
                              名称
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="interfaceName"  value="" >
                          </td>
                      </tr>

                  </table>
              </form>
              <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
              <a href="#" class="easyui-linkbutton" iconCls="icon-download" onclick="optDownload()">下载</a>
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
	    url:'<%=path%>wow/clientInfo/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
        title:"客户端管理列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,hidden:true},
                {field:'clientId',title:'客户端ID',width:200},
                {field:'ipAddress',title:'IP地址',width:200},
                {field:'macAddress',title:'mac地址',width:200},
                {field:'computeName',title:'计算机名称',width:200},
                {field:'displayResolution',title:'分辨率',width:200},
                {field:'systemType',title:'系统类型',width:200},
                {field:'pnpDeviceId',title:'pnpDeviceId',width:200},
                {field:'volumeSerialNumber',title:'volumeSerialNumber',width:200},
                {field:'diskSerialNumber',title:'diskSerialNumber',width:200},
                {field:'networkInfo',title:'网络信息',width:200}

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
</script>