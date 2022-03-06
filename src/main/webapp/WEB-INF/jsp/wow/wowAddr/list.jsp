<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>

<%String path = request.getContextPath()+"/"; %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript" src="<%=path%>js/fmt_date.js"></script>
<jsp:include page="../../include.jsp"></jsp:include>

<div class="easyui-layout" >
	<!-- Begin of toolbar -->
	<div id="tb">
		<div class="wu-toolbar-button" >
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="toAdd()" plain="true">新增</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toEdit()" plain="true">编辑</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

		</div>
	</div>
	<!-- End of toolbar -->

	<table id="dg"></table>


	<div id="optWin" class="easyui-window" title="基址" data-options="modal:true" style="width:600px;height:600px;padding:10px;">
		<form id="optForm" method="post">
			<input type="hidden" name="id">
			<input type="hidden" name="deleteFlag" >
			<table cellpadding="5">
				<tr>
					<td>客户端版本号:</td>
					<td><input class="easyui-textbox" type="text" name="versionNo" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>游戏版本号:</td>
					<td><input class="easyui-textbox" type="text" name="gameVersion" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>基址:</td>
					<td><input  id="addrList" name="addrList" class="easyui-textbox"  multiline="true" data-options="required:true"  style="width:360px;height: 180px"></input></td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:false"  style="width:360px;height: 100px"></input></td>
				</tr>
			</table>
		</form>
		<div style="text-align:center;padding:5px">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitQuickForm()">快速添加（将备注中填写内容转换）</a>
&nbsp;&nbsp;
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
        $('#optWin').window('close');
        $('#dg').datagrid({
            idField:'id',
            url:'<%=path%>wow/wowAddr/list',
            loadMsg:'正在加载数据，请稍后...',
            toolbar: '#tb',
            title:"基址管理列表",
            queryParams:getQueryParams,
            pagination:true,
            rownumbers:true,
            singleSelect:true,
            columns:[[
                {field:'id',title:'ID',width:100,hidden:true},
                {field:'versionNo',title:'客户端版本号',width:200},
                {field:'gameVersion',title:'游戏版本号',width:200},
                {field:'addrList',title:'基址',width:200},
                {field:'remark',title:'备注',width:200}

            ]]
        });
    });

    function optClear(){
        $('#optForm').form('clear');
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
    function toEdit(){
        opt ="update";
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $('#optForm').form('load',sel);
            $('#optWin').window('open');
        }
    }



    function toAdd(){
        opt ="add";
        $('#optForm').form('clear');
        $('#optWin').window('open');
    }

    function submitForm(){
        if(opt=="add"){
            addForm();
        }
        else if(opt=="update"){
            updateForm();
        }
    }

    function addForm(){
        $('#optForm').form('submit', {
            url:'<%=path%>wow/wowAddr/save',
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
                    $('#optWin').window('close');
                }else{
                    $.messager.alert('提示','保存失败!');
                }
            }
        });
    }

    function submitQuickForm(){
        $('#optForm').form('submit', {
            url:'<%=path%>wow/wowAddr/quick',
            onSubmit: function(){
                return true;
            },
            success:function(data){
                var d = eval("("+data+")") ;
                if("success" == d.msg ){
                    // $('#email').textbox({
                   $("#addrList").textbox({value:d.rows});
                }else{
                    $.messager.alert('提示','操作失败!');
                }
            }
        });
    }

    function updateForm(){
        $('#optForm').form('submit', {
            url:'<%=path%>wow/wowAddr/save',
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
                    $('#optWin').window('close');
                }else{
                    $.messager.alert('提示','保存失败!');
                }
            }
        });
    }

</script>