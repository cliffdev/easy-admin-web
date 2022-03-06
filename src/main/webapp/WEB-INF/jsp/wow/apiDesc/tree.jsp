<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%String path = request.getContextPath()+"/"; %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 

 <jsp:include page="../../include.jsp"></jsp:include>
<script type="text/javascript" src="<%=path%>js/fmt_date.js"></script>
 <div class="easyui-layout" >

     <table>
         <tr>

             <td>
                 <div class="easyui-panel" style="padding:5px;width: 200px">
                     <ul id="tt" class="easyui-tree"
                         data-options="url:'<%=path%>wow/apiDesc/findAll',method:'POST',animate:true,checkbox:false">

                     </ul>
                 </div>

             </td>
             <td>
                     <form id="showApiDescForm" method="post">
                         <input type="hidden" name="id" value="">
                         <table cellpadding="5">
                             <tr>
                                 <td>分类:</td>
                                 <td>
                                 <select name="catory">
                                     <option value="底层数据">底层数据</option>
                                     <option value="应用层数据">应用层数据</option>
                                     <option value="模块数据">模块数据</option>
                                 </select>
                                 </td>
                             </tr>
                             <tr>
                                 <td>名称:</td>
                                 <td><input   type="text" name="interfaceName" data-options="required:true"  class="easyui-textbox"  multiline="true"   style="width:400px;height: 100px"></input></td>
                             </tr>
                             <tr>
                                 <td>参数:</td>
                                 <td><input  type="text" name="interfaceArgs" data-options="required:true"  class="easyui-textbox"  multiline="true"  style="width:400px;height: 100px"></input></td>
                             </tr>
                             <tr>
                                 <td>返回值:</td>
                                 <td><input   type="text" name="interfaceResult" data-options="required:true"  class="easyui-textbox"  multiline="true"   style="width:400px;height: 100px"></input></td>
                             </tr>

                             <tr>
                                 <td>备注:</td>
                                 <td><input  name="remark" class="easyui-textbox"  multiline="true" data-options="required:true"  style="width:400px;height: 300px"></input></td>
                             </tr>
                         </table>
                     </form>
                     <div style="text-align:center;padding:5px">
                         <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
                     </div>

             </td>
         </tr>

     </table>


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

    $('#tt').tree({
        onClick: function(node){
            $('#showApiDescForm').form('load',node);
        }
    });
});

function reloadApiData(){
    $('#tt').tree('reload');

}

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

function getQueryParams(){
	 var jsonuserinfo = $('#form').serializeObject();
	 return jsonuserinfo;// 要提交的表单 
}

    function submitForm(){
        submitUpdateForm();
    }

    function submitUpdateForm(){
        var isValid = $('#createApiDescForm').form('validate');
        if (!isValid){
            return ;
        }
        $.messager.confirm('接口信息', '您确认要保存吗', function(r){
            if (r){
                sendUpdateApiData();
            }
        });
    }
    function sendUpdateApiData() {
        $('#showApiDescForm').form('submit', {
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
                    reloadApiData();
                }else{
                    $.messager.alert('提示','保存失败!');
                }
            }
        });
    }

</script>