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

            <c:if test="${sessionScope.roleId != '5' }">
                <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toCreate()" plain="true">生成卡号</a>
            </c:if>



            <c:if test="${sessionScope.loginName=='admin' or  sessionScope.loginName=='superAdmin' }">
                <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="toDelete()" plain="true">作废</a>
            </c:if>



			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>
        </div>

          <div class="wu-toolbar-search">
              <form id="form">
                  <input  name="groupBy" id="downloadGroupBy" value="" type="hidden">
                  <table  class="kv-table">

                      <tr>
                          <TD  class="kv-label">
                              批次号
                          </TD>
                          <td class="kv-content">
                              <input class="easyui-textbox"   name="batchNo"  value="" >
                          </td>

                          <td>卡号:</td>
                          <td>
                              <input class="easyui-textbox"   name="cardNo"  value="" >
                          </td>
                          <td>使用账号:</td>
                          <td>
                              <input class="easyui-textbox"   name="loginName"  value="" >
                          </td>
                      </tr>

                      <tr>

                          <TD  class="kv-label">
                              游戏点数
                          </TD>
                          <td class="kv-content" colspan="3">
                              <input class="easyui-numberbox"  data-options="required:false,min:1"    name="minAmount"  value="" >~ <input data-options="required:false,min:1"  class="easyui-numberbox"   name="maxAmount"  value="">
                          </td>
                          <td>卡状态:</td>
                          <td>
                              <SELECT NAME="cardState">
                                  <option VALUE="" selected>全部</option>
                                  <option VALUE="0">未使用</option>
                                  <option VALUE="1">已使用</option>
                                  <option VALUE="2">已停用</option>
                              </SELECT>
                          </td>
                      </tr>
                      <tr>
                          <TD  class="kv-label">
                              创建时间
                          </TD>
                          <td class="kv-content" colspan="3">
                              <input class="easyui-datetimebox"  style="width: 160px;"  name="createStartTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="createEndTime"  value="">
                          </td>

                          <TD  class="kv-label">
                              使用时间
                          </TD>
                          <td class="kv-content" colspan="3">
                              <input class="easyui-datetimebox"  style="width: 160px;"  name="useStartTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="useEndTime"  value="">
                          </td>
                      </tr>

                  </table>
              </form>
              <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
              <a href="#" class="easyui-linkbutton" iconCls="icon-download" onclick="optDownload()">表格下载</a>
              <a href="#" class="easyui-linkbutton" iconCls="icon-download" onclick="optDownload('batch')">按批次号分组下载</a>
          </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


     <div id="createCardNoWin" class="easyui-window" title="生成卡号" data-options="modal:true" style="width:450px;height:400px;padding:10px;">
         <form id="createCardNoForm" method="post">
             <table cellpadding="5">
                 <tr>
                     <td>批次号:</td>
                     <td><input class="easyui-textbox" type="text" name="batchNo" data-options="required:true"></input></td>
                 </tr>
                 <tr>
                     <td>卡类型:</td>
                     <td>
                         <select class="easyui-combogrid" name="cardType" style="width:250px" data-options="
						panelWidth: 500,
						idField: 'id',
						required:true,
						textField: 'title',
						url: '<%=path%>wow/card/getAllCardType',
						method: 'post',
						columns: [[
							 {field:'id',title:'id',width:100,hidden:true},
                             {field:'title',title:'名称',width:100},
                             {field:'amount',title:'点数',width:200},
                             {field:'remark',title:'备注',width:200}
						]],
						fitColumns: true
					">
                         </select>

                     </td>
                 </tr>
                 <tr>
                     <td>生成张数:</td>
                     <td><input class="easyui-numberbox" type="text"  precision="0"  name="number" data-options="required:true,min:1,max:1000"></input></td>
                 </tr>
                 </tr>
                 <tr>
                     <td>备注:</td>
                     <td><input class="easyui-textbox" type="text" name="remark" data-options="required:true"></input></td>
                 </tr>
             </table>
         </form>
         <div style="text-align:center;padding:5px">
             <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitCreateForm()">提交</a>
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
    $('#createCardNoWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/card/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
        title:"卡号管理列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:false,
	    columns:[[    
	    		{field:'id',title:'ID',width:100,checkbox:true},
                {field:'batchNo',title:'批次号',width:200},
                {field:'cardNo',title:'卡号',width:200},
                {field:'amount',title:'游戏点数',width:200},
                {field:'createTime',title:'创建时间',width:200,formatter:fmtDate},
                {field:'useAccount',title:'使用账号',width:200},
                {field:'useTime',title:'使用时间',width:200,formatter:fmtDate},
                {field:'cardState',title:'卡状态',width:200,formatter:fmtCardState},
                {field:'createby',title:'创建人账号',width:200},
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
function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}
function optDownload(groupBy){
    $("#downloadGroupBy").val(groupBy);
    var arg = $('#form').serialize();
    window.location.href='<%=path%>wow/card/download?'+arg;
}
    function fmtPack(value,row,index){
        if(value =="1" ){
            return "是";
        }
        return "否";

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
     $('#createCardNoWin').window('open');
     $('#createCardNoForm').form('clear');

 }
function toDelete(){
    var selRows = $('#dg').datagrid('getSelections');
    if(selRows.length>0){
        if(selRows.length >10){
            alert("选择的数据太多(最多10个)！");
            return ;
        }
        var ids = "";
        for (var i = 0; i < selRows.length; i++) {
            ids+=selRows[i].cardNo+",";
        }
        $.messager.prompt('作废', '您确认要作废选中的卡号吗（填写备注）？', function(r){
            if (r){
                doDeleteCard(ids,r);
            }
        });
    }
}

    function doDeleteCard(ids,remark) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/card/delete?ids='+ids+"&remark="+remark,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','作废成功!');
                }else{
                    $.messager.alert('提示','作废失败!');
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

    function submitCreateForm(){
        var isValid = $('#createCardNoForm').form('validate');
        if (!isValid){
          return ;
        }
        $.messager.confirm('生成卡号', '您确认要生成吗', function(r){
            if (r){
                sendCreateCardNoData();
            }
        });
    }
    function sendCreateCardNoData() {
        $('#createCardNoForm').form('submit', {
            url:'<%=path%>wow/card/createCardNo',
            onSubmit: function(){
                var isValid = $(this).form('validate');
                if (!isValid){
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success:function(data){
                var d = eval("("+data+")") ;
                if("0" == d.code ){
                    $.messager.alert('提示','生成成功!');
                    refershDg();
                    $('#userWin').window('close');
                }else{
                    $.messager.alert('提示',d.msg);
                }
            }
        });
    }
</script>