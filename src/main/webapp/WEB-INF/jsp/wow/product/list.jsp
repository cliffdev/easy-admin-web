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
        	  <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAddProduct()" plain="true">新增</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="toDelProduct()" plain="true">删除</a>
			  <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershProductDg()" plain="true">刷新</a>
        </div>
    </div>

	 <div id="tbRenew">
		 <div class="wu-toolbar-button" >
			 <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAddRenew()" plain="true">新增</a>
			 <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="toDelRenew()" plain="true">删除</a>
			 <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershRenewDg()" plain="true">刷新</a>
		 </div>
	 </div>

	 <div id="tbCardType">
		 <div class="wu-toolbar-button" >
			 <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAddCardType()" plain="true">新增</a>
			 <a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="toDelCardType()" plain="true">删除</a>
			 <a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershCardTypeDg()" plain="true">刷新</a>
		 </div>
	 </div>
    <!-- End of toolbar -->

	<table id="productDg"></table>

	 <br>
	 <br>

	 <table id="renewDg"></table>

	 <br>
	 <br>

	 <table id="cardTypeDg"></table>


	 <div id="productWin" class="easyui-window" title="服务信息" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="productForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
	    	<table cellpadding="5">
	    		<tr>
	    			<td>名称:</td>
	    			<td><input class="easyui-textbox" type="text" name="productName" data-options="required:true"></input></td>
	    		</tr>
				<tr>
					<td>代码:</td>
					<td><input class="easyui-textbox" type="text" name="productCode" data-options="required:true"></input></td>
				</tr>
				<tr>
					<td>开通方式:</td>
					<td>

						<select name="openChannels">
							<option value="1" selected>自助开通</option>
							<option value="2">后台开通</option>
						</select>

					</td>
				</tr>
				</tr>
	    		<tr>
	    			<td>备注:</td>
	    			<td><input class="easyui-textbox" type="text" name="remark" data-options="required:true"></input></td>
	    		</tr>
			</table>
	    </form>
	    <div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitProudctForm()">提交</a>
	    </div>
	</div>


	 <div id="renewWin" class="easyui-window" title="续费时间设置" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="renewForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
			 <table cellpadding="5">
				 <tr>
					 <td>适用服务:</td>
					 <td>
						 <select class="easyui-combogrid" name="productId" style="width:250px" data-options="
						panelWidth: 500,
						idField: 'id',
						required:true,
						textField: 'productName',
						url: '<%=path%>wow/product/list',
						method: 'post',
						columns: [[
						{field:'id',title:'id',width:100,hidden:true},
						{field:'productName',title:'名称',width:100},
						{field:'productCode',title:'代码',width:200,},
						{field:'createTime',title:'创建时间',width:200,formatter:fmtDate},
						{field:'remark',title:'备注',width:200}
						]],
						fitColumns: true
					">
						 </select>

					 </td>
				 </tr>
				 <tr>
					 <td>名称 :</td>
					 <td><input class="easyui-textbox" type="text" name="title" data-options="required:true"></input></td>
				 </tr>
				 <tr>
					 <td>开通方式:</td>
					 <td>

						 <select name="openChannels">
							 <option value="1" selected>自助开通</option>
							 <option value="2">后台开通</option>
						 </select>

					 </td>
				 </tr>
				 <tr>
					 <td>游戏点数:</td>
					 <td><input class="easyui-textbox" type="text" name="amount" data-options="required:true"></input></td>
				 </tr>
				 <tr>
					 <td>有效天数:</td>
					 <td><input class="easyui-textbox" type="text" name="days" data-options="required:true"></input></td>
				 </tr>
				 </tr>
				 <tr>
					 <td>备注:</td>
					 <td><input class="easyui-textbox" type="text" name="remark" data-options="required:true"></input></td>
				 </tr>
			 </table>
		 </form>
		 <div style="text-align:center;padding:5px">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitRenewForm()">提交</a>
		 </div>
	 </div>



	 <div id="cardTypeWin" class="easyui-window" title="点卡类型设置" data-options="modal:true" style="width:400px;height:400px;padding:10px;">
		 <form id="cardTypeForm" method="post">
			 <input type="hidden" name="id">
			 <input type="hidden" name="deleteFlag" >
			 <table cellpadding="5">
				 <tr>
					 <td>名称 :</td>
					 <td><input class="easyui-textbox" type="text" name="title" data-options="required:true"></input></td>
				 </tr>
				 <tr>
					 <td>游戏点数:</td>
					 <td><input class="easyui-textbox" type="text" name="amount" data-options="required:true"></input></td>
				 </tr>
				 </tr>
				 <tr>
					 <td>备注:</td>
					 <td><input class="easyui-textbox" type="text" name="remark" data-options="required:true"></input></td>
				 </tr>
			 </table>
		 </form>
		 <div style="text-align:center;padding:5px">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitCardTypeForm()">提交</a>
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
	$('#productWin').window('close');
    $('#renewWin').window('close');
    $('#cardTypeWin').window('close');

	$('#productDg').datagrid({
	    idField:'id',
	    url:'<%=path%>wow/product/list',
	    loadMsg:'正在加载数据，请稍后...',
		title:"服务列表",
	    toolbar: '#tb',
	    pagination:false,
	    rownumbers:true,
	    singleSelect:false,
        checkOnSelect:true,
	    columns:[[    
	    		{field:'id',title:'id',width:100,checkbox:true},
                {field:'productName',title:'名称',width:100},
                {field:'productCode',title:'代码',width:200},
                {field:'openChannels',title:'开通方式',width:200,formatter:ftmOpenChannels},
			    {field:'createTime',title:'创建时间',width:200,formatter:fmtDate},
	    		{field:'remark',title:'备注',width:200}

	    ]]
	});

    $('#renewDg').datagrid({
        idField:'id',
        url:'<%=path%>wow/renew/list',
        loadMsg:'正在加载数据，请稍后...',
        toolbar: '#tbRenew',
        title:"续费时间配置列表",
        pagination:true,
        rownumbers:true,
        singleSelect:false,
        checkOnSelect:true,
        columns:[[
            {field:'id',title:'id',width:100,checkbox:true},
            {field:'title',title:'名称',width:100},
            {field:'openChannels',title:'续费方式',width:200,formatter:ftmOpenChannels},
            {field:'amount',title:'游戏点数',width:200},
            {field:'days',title:'有效天数',width:200},
            {field:'createTime',title:'创建时间',width:200,formatter:fmtDate},
            {field:'remark',title:'备注',width:200}
        ]]
    });

    $('#cardTypeDg').datagrid({
        idField:'id',
        url:'<%=path%>wow/card/getAllCardType',
        loadMsg:'正在加载数据，请稍后...',
        toolbar: '#tbCardType',
        title:"点卡类型列表",
        pagination:true,
        rownumbers:true,
        singleSelect:false,
        checkOnSelect:true,
        columns:[[
            {field:'id',title:'id',width:100,checkbox:true},
            {field:'title',title:'名称',width:100},
            {field:'amount',title:'点数',width:200},
            {field:'remark',title:'备注',width:200}
        ]]
    });
});

 function toAddProduct(){
        $('#productForm').form('clear');
        $('#productWin').window('open');
 }

 function toAddRenew(){
        $('#renewForm').form('clear');
        $('#renewWin').window('open');
 }
    function toAddCardType(){
        $('#cardTypeForm').form('clear');
        $('#cardTypeWin').window('open');
    }

function optClear(){
	$('#form').form('clear');    
}

function refershProductDg(){
	$('#productDg').datagrid('load');
}

function refershRenewDg(){
        $('#renewDg').datagrid('load');
}

function refershCardTypeDg(){
        $('#cardTypeDg').datagrid('load');
}

function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}
function fmtState(value,row,index){
        if(value =="0" ){
            return "正常";
        }
        else if(value =="1" ){
            return "停用";
        }
        return "";
}
function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}

	function submitProudctForm(){
		$('#productForm').form('submit', {
		    url:'<%=path%>wow/product/add',
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
		        	refershProductDg();
		        	$('#userWin').window('close');
		        }else{
		        	$.messager.alert('提示','保存失败!，失败原因：'+d.msg);
		        }
		    }    
		});  
	}
	function submitRenewForm(){
		$('#renewForm').form('submit', {
		    url:'<%=path%>wow/renew/add',
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
		        	refershRenewDg();
		        	$('#userWin').window('close');
		        }else{
		        	$.messager.alert('提示','保存失败!');    
		        }
		    }    
		});  
	}
    function submitCardTypeForm(){
        $('#cardTypeForm').form('submit', {
            url:'<%=path%>wow/card/addCardType',
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
                    refershCardTypeDg();
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

    function ftmOpenChannels(value,row,index){
        if(value !=null ){
            if("1" == value){
				return "自助开通";
			}
            else if("2" == value){
                return "后台开通";
            }
        }
        return "";
    }
    function toDelCardType(){
        var selRows = $('#cardTypeDg').datagrid('getSelections');
        if(selRows.length >0){
            var ids = "";
            for(var i=0;i< selRows.length;i++){
                ids+=selRows[i].id+",";
            }
            $.messager.confirm('删除点卡类型', '您确认要删除选中点卡类型吗', function(r){
                if (r){
                    doDelCardType(ids);
                }
            });
        }
    }
    function doDelCardType(ids) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/card/delCardType?ids='+ids,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','操作成功!');
                    refershCardTypeDg();
                }else{
                    $.messager.alert('提示','操作失败!');
                }
            }
        });
    }


    function toDelRenew(){
        var selRows = $('#renewDg').datagrid('getSelections');
        if(selRows.length >0){
            var ids = "";
            for(var i=0;i< selRows.length;i++){
                ids+=selRows[i].id+",";
            }
            $.messager.confirm('续费时间配置', '您确认要删除选中的续费时间配置吗', function(r){
                if (r){
                    doDelRenew(ids);
                }
            });
        }
    }
    function doDelRenew(ids) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/renew/delRenew?ids='+ids,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','操作成功!');
                    refershRenewDg();
                }else{
                    $.messager.alert('提示','操作失败!');
                }
            }
        });
    }

    function toDelProduct(){
        var selRows = $('#productDg').datagrid('getSelections');
        if(selRows.length >0){
            var ids = "";
            for(var i=0;i< selRows.length;i++){
                ids+=selRows[i].id+",";
			}
            $.messager.confirm('删除服务', '您确认要删除选中的服务吗', function(r){
                if (r){
                    doDelProduct(ids);
                }
            });
        }
    }
    function doDelProduct(ids) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/product/delProduct?ids='+ids,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (d) {
                if("success" == d.msg ){
                    $.messager.alert('提示','操作成功!');
                    refershProductDg();
                }else{
                    $.messager.alert('提示','操作失败!');
                }
            }
        });
    }

</script>