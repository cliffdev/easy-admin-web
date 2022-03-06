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

			  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toRegisterUser()" plain="true">注册用户</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAddAccount()" plain="true">开通服务</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toRechange()" plain="true">充值</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAddTime()" plain="true">增加时间</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toOpenUser()" plain="true">解封账号</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toStopUser()" plain="true">封锁账号</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toRestPassword()" plain="true">重置密码</a>

				<c:if test="${sessionScope.loginName=='admin' or  sessionScope.loginName=='superAdmin' }">
					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toResetAmount()" plain="true">重置游戏点数</a>
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
							  注册IP
						  </TD>
						  <td class="kv-content">
							  <input class="easyui-textbox"   name="regisetrIp"  value="" >
						  </td>
						  <TD  class="kv-label">
							  状态
						  </TD>
						  <td class="kv-content">
							  <select name="state">
								  <option value="">全部</option>
								  <option value="0">正常</option>
								  <option value="1">禁用</option>
							  </select>
						  </td>
					  </tr>

					  <tr>
						  <TD  class="kv-label">
							  注册时间
						  </TD>
						  <td class="kv-content" colspan="3">
							  <input class="easyui-datetimebox"  style="width: 160px;"  name="registerStartTime"  value="" >~ <input style="width: 160px;"  class="easyui-datetimebox"   name="registerEndTime"  value="">
						  </td>

						  <TD  class="kv-label">
							  游戏点数
						  </TD>
						  <td class="kv-content" colspan="3">
							  <input class="easyui-numberbox"  data-options="required:false,min:0"    name="minAmount"  value="" >~ <input data-options="required:false,min:0"  class="easyui-numberbox"   name="maxAmount"  value="">
						  </td>
					  </tr>


				  </table>
			  </form>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
		  </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>


	 <div id="userWin" class="easyui-window" title="注册用户" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="userForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
			 <table cellpadding="5">
				 <tr>
					 <td>用户名:</td>
					 <td><input class="easyui-textbox" type="text" name="loginName" data-options="required:true"></input></td>
				 </tr>
				 <tr>
					 <td>密码:</td>
					 <td><input class="easyui-textbox" type="text" name="loginPassword" data-options="required:true"></input></td>
				 </tr>
			 </table>
		 </form>
		 <div style="text-align:center;padding:5px">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="registerUser()">提交</a>
		 </div>
	 </div>


	 <div id="addAccountWin" class="easyui-window" title="添加服务" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="addAccountForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
			 <table cellpadding="5">
				 <tr>
					 <td>登录名:</td>
					 <td>
						 <select class="easyui-combogrid" id="addAccount_loginName" name="loginName" style="width:250px"  >
						 </select>
					 </td>
				 </tr>
				 <tr>
					 <td>请选择服务:</td>
					 <td>
						 <select class="easyui-combogrid" name="productId" style="width:250px" data-options="
						panelWidth: 500,
						idField: 'id',
						required:true,
						textField: 'productName',
						url: '<%=path%>wow/product/list',
						method: 'post',
						columns: [[
							{field:'id',title:'productId',width:100,hidden:true},
							{field:'productName',title:'版本类型',width:100},
							{field:'productCode',title:'代码',width:100},
							{field:'remark',title:'备注',width:100}
						]],
						fitColumns: true
					">
						 </select>
					 </td>
				 </tr>
				 <tr>
					 <td>生成数量:</td>
					 <td>
						 <input class="easyui-numberbox" type="text" value="1"    name="count" data-options="min:1,max:100,precision:0,required:true">
					 </td>
				 </tr>
				 <tr>
					 <td colspan="2">
						 <font color="red"> (服务名称自动生成)</font>
					 </td>
				 </tr>
			 </table>
		 </form>
		 <div style="text-align:center;padding:5px">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddAccountForm()">提交</a>
		 </div>
	 </div>


	 <div id="rechargeWin" class="easyui-window" title="充值" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="rechargeForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
			 <table cellpadding="5">
				 <tr>
					 <td>登录名:</td>
					 <td>
						 <select class="easyui-combogrid" id="recharge_loginName" name="loginName" style="width:250px"  >
						 </select>
					 </td>
				 </tr>
				 <tr>
					 <td>卡号:</td>
					 <td><input class="easyui-textbox" type="text" name="cardNo" style="width: 250px;" data-options="required:true"></input></td>
				 </tr>
			 </table>
		 </form>
		 <div style="text-align:center;padding:5px">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitRechargeForm()">提交</a>
		 </div>
	 </div>


	 <div id="addAccountTimeWin" class="easyui-window" title="给服务增加时间" data-options="modal:true" style="width:450px;height:400px;padding:10px;">
		 <form id="addAccountTimeForm" method="post">
			 <input type="hidden" name="id" id="addAccountTime_loginSubAccountId">
			 <input type="hidden" name="deleteFlag" >
			 <table cellpadding="5">
				 <tr>
					 <td>登录名:</td>
					 <td>
						 <select class="easyui-combogrid" id="addAccountTime_loginName" name="loginName" style="width:250px"  >
						 </select>
					 </td>
				   </tr>
				 <tr>
					 <td>请选择充值时间:</td>
					 <td>
						 <select class="easyui-combogrid" id="renewIdcombogrid" name="renewId" style="width:250px"  >
						 </select>
					 </td>
				 </tr>
				 <tr>
					 <td>请选择服务:</td>
					 <td>
						 <select  class="easyui-combogrid" id="loginSubAccountList" name="loginSubAccountList" style="width:250px"  >
						 </select>
					 </td>
				 </tr>
			 </table>
		 </form>
		 <div style="text-align:center;padding:5px">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitAddAccountTimeForm()">提交</a>
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
    $('#addAccountWin').window('close');
    $('#rechargeWin').window('close');
    $('#addAccountTimeWin').window('close');

	$('#dg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/clientUser/list',
	    loadMsg:'正在加载数据，请稍后...',
	    toolbar: '#tb',
        title:"用户管理列表",
	    queryParams:getQueryParams,
	    pagination:true,
	    rownumbers:true,
        checkOnSelect:true,
	    singleSelect:false,
	    columns:[[    
	    		{field:'id',title:'id',width:100,checkbox:true},
                {field:'loginName',title:'登录名',width:100},
                {field:'amount',title:'游戏点数',width:100},
                {field:'registerIp',title:'注册IP',width:200},
                {field:'registerTime',title:'注册时间',width:200,formatter:fmtDate},
                {field:'state',title:'状态',width:200,formatter:fmtState}
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
    function fmtPack(value,row,index){
        if(value =="1" ){
            return "是";
        }
        else if(value =="1" ){
            return "否";
        }
        return "";
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

function  fmtCardType(value,row,index) {
    if(value =="1" ){
        return "月卡";
    }
    else if(value =="2" ){
        return "季卡";
    }
    else if(value =="3" ){
        return "年卡";
    }
    else if(value =="4" ){
        return "日卡";
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
            $.messager.prompt('重置密码', '您确认要重置:【'+sel.loginName+"】的密码吗", function(r){
                if (r){
                    restPassword(sel.id,r);
                }
            });

        }
    }
    function restPassword(userId,password) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientUser/restPassword?id='+userId+"&password="+password,
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

    function toResetAmount(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.prompt('重置密码', '您确认要重置:【'+sel.loginName+"】的游戏点数吗", function(r){
                if (r){
                    restAmount(sel.id,r);
                }
            });
        }
    }

    function restAmount(userId,amount) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientUser/restAmount?id='+userId+"&amount="+amount,
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


    function toRegisterUser(){
        $('#userWin').form('clear');
        $('#userWin').window('open');
	}



	function registerUser(){
		$('#userForm').form('submit', {
		    url:'<%=path%>wow/clientUser/register',
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
		        	$.messager.alert('提示','注册成功!');
		        	refershDg();
		        	$('#userWin').window('close');
		        }else{
		        	$.messager.alert('提示','注册失败!，失败原因：'+d.msg);
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
    function toOpenUser(){
        var selRows = $('#dg').datagrid('getSelections');
        if(selRows.length >0) {
            var ids = "";
            for (var i = 0; i < selRows.length; i++) {
                ids+=selRows[i].id+",";
            }
            $.messager.confirm('解封账号', '您确认要解封选择的用户吗', function(r){
                if (r){
                    doOpenUser(ids);
                }
            });
        }

    }
    function doOpenUser(ids) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientUser/openUser?ids='+ids,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','操作成功!');
                    refershDg();
                }else{
                    $.messager.alert('提示','操作失败!');
                }
            }
        });
    }

    function toStopUser(){
        var selRows = $('#dg').datagrid('getSelections');
        if(selRows.length >0) {
            var ids = "";
            for (var i = 0; i < selRows.length; i++) {
                ids+=selRows[i].id+",";
            }
            $.messager.confirm('封锁账号', '您确认要封锁选择的用户吗', function(r){
                if (r){
                    doStopUser(ids);
                }
            });
        }

    }
    function doStopUser(ids) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/clientUser/stopUser?ids='+ids,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','操作成功!');
                    refershDg();
                }else{
                    $.messager.alert('提示','操作失败!');
                }
            }
        });
    }

    function toAddAccount(){
        $("#addAccountForm").form('clear');
        loadSelectUserForAddAccount();
        $('#addAccountWin').window('open');

    }
    function loadSelectUserForAddAccount(){
        $('#addAccount_loginName').combogrid({
            delay: 500,
            mode: 'remote',
            idField: 'loginName',
            textField: 'loginName',
            panelWidth: 500,
            required:true,
            method: 'post',
            pagination:true,
            multiple: false,
            url:'<%=path%>wow/clientUser/list?_t='+(new Date().getTime()),
            method: 'post',
            columns: [[
                {field:'id',title:'id',width:100,checkbox:true},
                {field:'loginName',title:'登录名',width:160},
                {field:'amount',title:'游戏点数',width:100},
                {field:'state',title:'状态',width:100,formatter:fmtState}
            ]],
            fitColumns: true

        });
    }
    function toRechange(){
        $("#rechargeForm").form('clear');
        loadSelectUserForRechange();
        $('#rechargeWin').window('open');
    }
    function loadSelectUserForRechange(){
        $('#recharge_loginName').combogrid({
            delay: 500,
            mode: 'remote',
            idField: 'loginName',
            textField: 'loginName',
            panelWidth: 500,
            required:true,
            method: 'post',
            pagination:true,
            multiple: false,
            url:'<%=path%>wow/clientUser/list?_t='+(new Date().getTime()),
            method: 'post',
            columns: [[
                {field:'id',title:'id',width:100,checkbox:true},
                {field:'loginName',title:'登录名',width:160},
                {field:'amount',title:'游戏点数',width:100},
                {field:'state',title:'状态',width:100,formatter:fmtState}
            ]],
            fitColumns: true

        });
    }
    function toAddTime(){
        $("#addAccountTimeForm").form('clear');
        loadSelectUser();
        loadRenewData();
        $('#addAccountTimeWin').window('open');
    }

    function loadSelectUser(){
        $('#addAccountTime_loginName').combogrid({
            delay: 500,
            mode: 'remote',
            idField: 'loginName',
            textField: 'loginName',
            panelWidth: 500,
            required:true,
            method: 'post',
            pagination:true,
            multiple: false,
            url:'<%=path%>wow/clientUser/list?_t='+(new Date().getTime()),
            method: 'post',
            columns: [[
                {field:'id',title:'id',width:100,checkbox:true},
                {field:'loginName',title:'登录名',width:160},
                {field:'amount',title:'游戏点数',width:100},
                {field:'state',title:'状态',width:100,formatter:fmtState}
            ]],
            fitColumns: true,
            onSelect:function(rowIndex, rowData){
                $('#renewIdcombogrid').combogrid("clear");
                $('#loginSubAccountList').combogrid("clear");
            }

        });
    }
    function loadRenewData(productId){
        $('#renewIdcombogrid').combogrid({
            delay: 500,
            mode: 'remote',
            idField: 'id',
            textField: 'title',
            panelWidth: 500,
            required:true,
            method: 'post',
            url: '<%=path%>wow/product/getRenewList?_t='+(new Date().getTime()),
            method: 'post',
            columns: [[
                {field:'id',title:'id',width:100,hidden:true},
                {field:'title',title:'名称',width:100},
                {field:'days',title:'有效天数',width:100},
                {field:'amount',title:'需要游戏点数',width:200},
                {field:'productId',title:'productId',width:100,hidden:true}
            ]],
            fitColumns: true,
            onSelect:function(rowIndex, rowData){
                if(rowData && rowData.productId){
                    loadRenewAccountData(rowData.productId);
                }
            }
        });
    }
    function loadRenewAccountData(productId){
        var g = $('#addAccountTime_loginName').combogrid('grid');	// get datagrid object
        var r = g.datagrid('getSelected');
        var loginName = "";
        if(r){
			loginName = r.loginName;
		}

        $('#loginSubAccountList').combogrid({
            multiple: true,
            mode: 'remote',
            idField: 'loginSubAccount',
            textField: 'loginSubAccount',
            panelWidth: 500,
            required:true,
            method: 'post',
            url: '<%=path%>wow/clientAccount/userSubAccountList?productId='+productId+'&loginName='+loginName+'&_t='+(new Date().getTime()),
            pagination:true,
            columns: [[
                {field:'id',title:'id',width:100,checkbox:true},
                {field:'productId',title:'productId',width:100,hidden:true},
                {field:'loginSubAccount',title:'服务',width:100},
                {field:'name',title:'版本类型',width:100},
                {field:'createTime',title:'开通时间',width:200},
                {field:'expiredTime',title:'过期时间',width:200},
                {field:'expired',title:'状态',width:200,formatter:fmtExpired},
                {field:'remark',title:'备注',width:200}
            ]],
            fitColumns: true
        });

    }
    function fmtExpired(value,row,index){
        if(!value ){
            return "正常";
        }
        else{
            return "没有可剩余时间";
        }
    }

    function submitAddAccountForm(){
        var isValid = $("#addAccountForm").form('validate');
        if(!isValid){
            return ;
        }

        $.messager.confirm('添加子账号', '您确认要添加新的服务吗', function(r) {
            if (r) {
                doSubmitAddAccountForm();
            }
        });
    }

    function doSubmitAddAccountForm(){

        $('#addAccountForm').form('submit', {
            url:'<%=path%>wow/clientAccount/addAccount',
            contentType:"application/json",
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
    function submitRechargeForm(){
        var isValid = $("#rechargeForm").form('validate');
        if(!isValid){
            return ;
        }

        $.messager.confirm('充值', '您确认要给此用户充值吗', function(r) {
            if (r) {
                doSubmitRechargeForm();
            }
        });
    }
    function doSubmitRechargeForm(){
        $('#rechargeForm').form('submit', {
            url:'<%=path%>wow/recharge/add',
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
                    $('#rechargeWin').window('close');
                }else{
                    $.messager.alert('提示','操作失败!，失败原因：'+d.msg);
                }
            }
        });
    }

    function submitAddAccountTimeForm(){
        var isValid = $("#addAccountTimeForm").form('validate');
        if(!isValid){
            return ;
        }
        $.messager.confirm('添加子账号时间', '您确认要为此服务添加时间吗', function(r) {
            if (r) {
                dosubmitAddAccountTimeForm();
            }
        });
    }
    function dosubmitAddAccountTimeForm(){
        $('#addAccountTimeForm').form('submit', {
            url: '<%=path%>wow/clientAccount/addAccountTime',
            onSubmit: function () {
                var isValid = $(this).form('validate');
                if (!isValid) {
                    $.messager.progress('close');	// hide progress bar while the form is invalid
                }
                return isValid;
            },
            success: function (data) {
                var d = eval("(" + data + ")");
                if ("0" == d.code) {
                    refershDg();
                    $.messager.alert('提示',  d.msg);
                } else {
                    $.messager.alert('提示', '操作失败!，失败原因：' + d.msg);
                }
            }
        });
    }
</script>