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
                      </tr>

                  </table>
              </form>
              <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
          </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	<div id="rechargeWin" class="easyui-window" title="充值" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="rechargeForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
	    	<table cellpadding="5">
	    		<tr>
	    			<td>卡号:</td>
	    			<td><input class="easyui-textbox" type="text" name="cardNo" style="width: 200px;" data-options="required:true"></input></td>
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
	$('#rechargeWin').window('close');
	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/amountLog/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
		title:"充值查询列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
	    singleSelect:true,
	    columns:[[    
	    		{field:'id',title:'id',width:100,hidden:true},
                {field:'bizType',title:'业务类型',width:100},
                {field:'loginName',title:'登录名',width:100},
                {field:'title',title:'标题',width:100},
                {field:'amount',title:'游戏点数',width:200},
                {field:'createTime',title:'操作时间',width:200,formatter:fmtDate},
            	{field:'resultStatus',title:'状态',width:200,formatter:fmtState},
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
function fmtState(value,row,index){
        if(value =="0" ){
            return "失败";
        }
        else if(value =="1" ){
            return "成功";
        }
        return "";
}
function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}
    function toAdd(){
        $('#rechargeForm').form('clear');
        $('#rechargeWin').window('open');
	}

	function submitForm(){
        addForm();

	}

	function addForm(){


		$('#rechargeForm').form('submit', {
		    url:'<%=path%>recharge/add',
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
		        	$.messager.alert('提示','操作成功!');
		        	refershDg();
		        	$('#userWin').window('close');
		        }else{
		        	$.messager.alert('提示','操作失败!，失败原因：'+d.msg);
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