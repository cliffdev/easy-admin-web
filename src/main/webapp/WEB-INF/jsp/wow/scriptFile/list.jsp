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
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="toRelease()" plain="true">发布</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-delete" onclick="toDelete()" plain="true">删除</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="toDownload()" plain="true">下载</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-refresh" onclick="refershDg()" plain="true">刷新</a>

		</div>
	</div>
	<!-- End of toolbar -->

	<table id="dg"></table>

	<div id="userWin" class="easyui-window" title="脚本" data-options="modal:true" style="width:550px;height:600px;padding:10px;">
		<form id="userForm" method="post"   enctype="multipart/form-data">
			<input type="hidden" name="id">
			<input type="hidden" name="deleteFlag" >
			<input type="hidden" name="scriptPath" >
			<table cellpadding="5">
				<tr>
					<td>脚本名称:</td>
					<td><input class="easyui-textbox" type="text" name="scriptName" data-options="required:true" style="width: 400px"></input></td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:true" maxlength="500" style="width:400px;height: 50px"></input></td>
				</tr>
				<tr>
					<td>发布状态:</td>
					<td>
						<select name="releaseStatus">
							<option value="1">草稿</option>
							<option value="2">发布</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>附件:</td>
					<td>
						<input name="file" type="file"> <br>
					</td>
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
        $('#userWin').window('close');
        $('#dg').datagrid({
            idField:'id',
            url:'<%=path%>wow/scriptFile/list',
            loadMsg:'正在加载数据，请稍后...',
            title:"脚本管理列表",
            toolbar: '#tb',
            queryParams:getQueryParams,
            pagination:true,
            rownumbers:true,
            singleSelect:true,
            columns:[[
                {field:'id',title:'id',width:100,hidden:true},
                {field:'scriptName',title:'脚本名称',width:200},
                {field:'releaseStatus',title:'状态',width:100,formatter:fmtReleaseStatus},
                {field:'remark',title:'备注',width:300}

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

    function fmtReleaseStatus(value,row,index){
        if(value !=null ){
            if("1" ==value){
                return "草稿";
            }
            else if("2" ==value){
                return "已发布";
            }
        }
        return "";
    }

    function getQueryParams(){
        var jsonuserinfo = $('#form').serializeObject();
        return jsonuserinfo;// 要提交的表单
    }
    function toEdit(){
        opt ="update";
        $('#userForm').form('clear');
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $('#userForm').form('load',sel);
            $('#userWin').window('open');
        }
    }

    function toAdd(){
        opt ="add";
        $('#userForm').form('clear');
        $('#userWin').window('open');
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
        $('#userForm').form('submit', {
            url:'<%=path%>wow/scriptFile/add',
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
    function updateForm(){
        $('#userForm').form('submit', {
            url:'<%=path%>wow/scriptFile/save',
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

    function toDownload(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.confirm('下载', '您确认要下载:【'+sel.scriptName+"】吗", function(r){
                if (r){
                    var dUrl='<%=path%>wow/scriptFile/download?id='+sel.id;
                    window.location.href  = dUrl;
                }
            });


        }
    }

    function toRelease(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.confirm('发布', '您确认要发布:【'+sel.scriptName+"】吗", function(r){
                if (r){
                    doRelease(sel.id,r);
                }
            });
        }
    }

    function doRelease(id) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/scriptFile/doRelease?id='+id,
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

    function toDelete(){
        var sel = $('#dg').datagrid('getSelected');
        if(sel){
            $.messager.confirm('删除', '您确认要删除:【'+sel.scriptName+"】吗", function(r){
                if (r){
                    doDelete(sel.id,r);
                }
            });
        }
    }

    function doDelete(id) {
        $.ajax({
            type: "POST",
            url: '<%=path%>wow/scriptFile/delete?id='+id,
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

</script>