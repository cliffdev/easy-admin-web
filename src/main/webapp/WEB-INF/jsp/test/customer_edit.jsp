<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html> 
<html lang="en"> 
<head> 
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <title>基本信息</title> 
    <jsp:include page="../include.jsp"></jsp:include>
    <link href="<%=request.getContextPath()+"/" %>css/base.css" rel="stylesheet">
    <link rel="<%=request.getContextPath()+"/"  %>stylesheet" href="../custom/uimaker/easyui.css">
    <link href="<%=request.getContextPath()+"/"  %>css/basic_info.css" rel="stylesheet">
</head> 
<body>
	<div class="container">
		<div class="content">
			<div class="easyui-tabs1" style="width:100%;">
		      <div title="基本信息" data-options="closable:false" class="basic-info">
		      	<div class="column"><span class="current">注册信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">企业名称</td>
							<td class="kv-content"><input class="easyui-textbox" type="text" name="name" data-options="required:true"></td>
							<td class="kv-label">企业法人</td>
							<td class="kv-content"><input class="easyui-textbox" type="text" name="name" data-options="required:true"></td>
							<td class="kv-label">注册资金(万元)</td>
							<td class="kv-content"><input class="easyui-textbox" type="text" name="name" data-options="required:true"></td>
						</tr>
						<tr>
							<td class="kv-label">企业类型</td>
							<td class="kv-content"><input class="easyui-textbox" type="text" name="name" data-options="required:true"></td>
							<td class="kv-label">企业性质</td>
							<td class="kv-content"><input class="easyui-textbox" type="text" name="name" data-options="required:true"></td>
							<td class="kv-label">主公品类</td>
							<td class="kv-content"><input class="easyui-textbox" type="text" name="name" data-options="required:true"></td>
						</tr>
						<tr>
							<td class="kv-label">注册地址</td>
							<td class="kv-content" colspan="5">江苏省苏州市</td>
						</tr>
						<tr>
							<td class="kv-label">公司地址</td>
							<td class="kv-content" colspan="5">河滨路88号</td>
						</tr>
						<tr>
							<td class="kv-label">邮编</td>
							<td class="kv-content">214000</td>
							<td class="kv-label">成立年份</td>
							<td class="kv-content" colspan="3">2016</td>
						</tr>
						<tr>
							<td class="kv-label">厂房所有</td>
							<td class="kv-content">自有</td>
							<td class="kv-label">厂房面积</td>
							<td class="kv-content">1253</td>
							<td class="kv-label">建筑面积</td>
							<td class="kv-content">68</td>
						</tr>
					</tbody>
				</table>
				<div class="column"><span class="current">三证信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">营业执照</td>
							<td class="kv-content">计算机估计配件</td>
							<td class="kv-label">扫描照</td>
							<td class="kv-content" colspan="3"><a href="javascript:;">营业执照.jpg</a></td>
						</tr>
						<tr>
							<td class="kv-label">组织机构代码</td>
							<td class="kv-content">051855369</td>
							<td class="kv-label">扫描照</td>
							<td class="kv-content" colspan="3"><a href="javascript:;">机组织代码.jpg</a></td>
						</tr>
						<tr>
							<td class="kv-label">税务登记证</td>
							<td class="kv-content">320698415263</td>
							<td class="kv-label">扫描照</td>
							<td class="kv-content" colspan="3"><a href="javascript:;">税务登记.jpg</a></td>
						</tr>
					</tbody>
				</table>
				<div class="column"><span class="current">联系信息</span></div>
		      	<table class="kv-table">
					<tbody>
						<tr>
							<td class="kv-label">公司电话</td>
							<td class="kv-content">0512-69168010</td>
							<td class="kv-label">传真</td>
							<td class="kv-content">0512-69168010</td>
							<td class="kv-label">公司网站</td>
							<td class="kv-content">www.szlf.com</td>
						</tr>
						<tr>
							<td class="kv-label">联系人</td>
							<td class="kv-content">左江胜</td>
							<td class="kv-label">联系手机</td>
							<td class="kv-content">15158966547</td>
							<td class="kv-label">联系人邮箱</td>
							<td class="kv-content">zhs88@szlf.com</td>
						</tr>
					</tbody>
				</table>
				<table class="kv-table yes-not">
					<tbody>
						<tr>
							<td class="kv-label">是否有亲属在公司</td>
							<td class="kv-content" colspan="2">无</td>
							<td class="kv-label">是否与公司是竞争关系</td>
							<td class="kv-content" colspan="2">否</td>
						</tr>
					</tbody>
				</table>

		      </div>
		      <div title="财务信息" data-options="closable:false"></div>
		      <div title="人员情况" data-options="closable:false"></div>
		      <div title="产品情况" data-options="closable:false"></div>
		      <div title="供货历史" data-options="closable:false"></div>
		      <div title="主要原材料供应商" data-options="closable:false"></div>
		      <div title="资质附件" data-options="closable:false"></div>
		    </div>
		</div>
	</div>
	
</body> 
</html>
    <script type="text/javascript" src="../custom/jquery.min.js"></script>
    <script type="text/javascript" src="../custom/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$('.easyui-tabs1').tabs({
      tabHeight: 36
    });
    $(window).resize(function(){
    	$('.easyui-tabs1').tabs("resize");
    }).resize();
</script>
