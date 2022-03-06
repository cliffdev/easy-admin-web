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
		<div class="wu-toolbar-search">
			<form id="form">
				<table  class="kv-table">

					<tr>
						<TD  class="kv-label">
							名称
						</TD>
						<td class="kv-content">
							<input name="lineName" class="easyui-textbox" >
						</td>
						<TD  class="kv-label">
							分类
						</TD>
						<td class="kv-content">
							<select name="category">
								<option value="">全部</option>
								<option value="船">船</option>
								<option value="飞艇">飞艇</option>
								<option value="电梯">电梯</option>
								<option value="地铁">地铁</option>
							</select>
						</td>

					</tr>
				</table>
			</form>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
		</div>
	</div>
	<!-- End of toolbar -->

	<table id="dg"></table>


	<div id="userWin" class="easyui-window" title="线路" data-options="modal:true" style="width:600px;height:600px;padding:10px;">
		<form id="userForm" method="post">
			<input type="hidden" name="id">
			<input type="hidden" name="deleteFlag" >
			<table cellpadding="5">
				<tr>
					<td>线路名称:</td>
					<td><input class="easyui-textbox" type="text" name="lineName" data-options="required:true" style="width:360px;"></input></td>
				</tr>

				<tr>
					<td>分类:</td>
					<td>
						<select name="category">
							<option value="船">船</option>
							<option value="飞艇">飞艇</option>
							<option value="电梯">电梯</option>
							<option value="地铁">地铁</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>对象名称:</td>
					<td><input class="easyui-textbox" type="text" name="boatName" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>对象英文名称:</td>
					<td><input class="easyui-textbox" type="text" name="enBoatName" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>对象编号:</td>
					<td><input class="easyui-textbox" type="text" name="objectGuid" data-options="required:false" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>对象坐标(x,y,z)</td>
					<td><input class="easyui-textbox" type="text" name="position" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>参考坐标(x,y,z)</td>
					<td><input class="easyui-textbox" type="text" name="referPosition" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>完成坐标(x,y,z)</td>
					<td><input class="easyui-textbox" type="text" name="endPosition" data-options="required:true" style="width:360px;"></input></td>
				</tr>
				<tr>
					<td>扩展坐标:</td>
					<td><input  name="extPositions" class="easyui-textbox"  multiline="true" data-options="required:false"  style="width:360px;height: 100px"></input></td>
				</tr>
				<tr>
					<td>备注:</td>
					<td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:false"  style="width:360px;height: 100px"></input></td>
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
            url:'<%=path%>wow/shipLine/list',
            loadMsg:'正在加载数据，请稍后...',
            toolbar: '#tb',
            title:"线路管理列表",
            queryParams:getQueryParams,
            pagination:true,
            rownumbers:true,
            singleSelect:true,
            columns:[[
                {field:'id',title:'ID',width:100,hidden:true},
                {field:'lineName',title:'线路名称',width:200},
                {field:'category',title:'分类',width:200},
                {field:'boatName',title:'对象名称',width:200},
                {field:'enBoatName',title:'对象英文名称',width:200},
                {field:'objectGuid',title:'对象编号',width:200},
                {field:'position',title:'对象坐标（x,y,z）',width:200},
                {field:'referPosition',title:'参考坐标（x,y,z）',width:200},
                {field:'endPosition',title:'完成坐标（x,y,z）',width:200},
                {field:'extPositions',title:'扩展坐标',width:200},
                {field:'remark',title:'备注',width:200}

            ]]
        });
    });

    function optClear(){
        $('#userForm').form('clear');
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
            url:'<%=path%>wow/shipLine/save',
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
            url:'<%=path%>wow/shipLine/save',
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