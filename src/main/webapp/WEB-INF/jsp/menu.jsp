<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
 String path = request.getContextPath()+"/";
 %>
<!-- begin of sidebar -->
<div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航菜单'">
	<div class="easyui-accordion" data-options="border:false,fit:true">
		<div title="系统管理" data-options="iconCls:'icon-wrench'"  style="padding: 5px;">
			 <ul class="easyui-tree wu-side-tree">
             				<li iconCls="icon-users">
             				<a href="javascript:void(0)" data-icon="icon-users" data-link="<%=path%>sys/config/list" iframe="1">系统参数设置</a>
             				</li>

             				<li iconCls="icon-users">
             				<a href="javascript:void(0)" data-icon="icon-users" data-link="<%=path%>sys/user/list" iframe="1">角色管理</a>
             				</li>
             				<li iconCls="icon-users">
             				<a href="javascript:void(0)" data-icon="icon-users" data-link="<%=path%>sys/user/list" iframe="1">菜单管理</a>
             				</li>
			        	    <li iconCls="icon-users">
			            	<a href="javascript:void(0)" data-icon="icon-users" data-link="<%=path%>sys/user/list" iframe="1">用户管理</a>
				          </li>
			</ul>
		</div>
        <div title="开发平台" data-options="iconCls:'icon-wrench'"  style="padding: 5px;">
             <ul class="easyui-tree wu-side-tree">
                     <li iconCls="icon-users">
                      <a href="javascript:void(0)" data-icon="icon-users" data-link="<%=path%>easy/dict/list" iframe="1">字典管理</a>
                      </li>
                      <li iconCls="icon-users">
                       <a href="javascript:void(0)" data-icon="icon-users" data-link="<%=path%>easy/query/list" iframe="1">简表配置管理</a>
                       </li>
               </ul>
        </div>

	</div>
</div>
<!-- end of sidebar -->

