<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%String path = request.getContextPath()+"/"; %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
    
    <script  src="<%=path%>${queryTable.url}"></script>
 <div class="easyui-layout" >
	 <!-- Begin of toolbar -->
      <div id="tb">
        <div class="wu-toolbar-button" >
        	<c:forEach items="${queryTable.menus}" var="item">
        	 <a href="#" class="easyui-linkbutton" iconCls="${item.icon}" onclick="sayHello()" plain="true">${item.title}</a>
        	</c:forEach>
          
        </div>
        <div class="wu-toolbar-search">
       	 <form id="form"> 
           <table  class="kv-table">
         	<c:forEach items="${queryTable.searchColumns}" var="item" varStatus="status">
         		<c:if test="${status.first}"> <tr ></c:if>
         		 <c:if test="${status.index % 4==0 and status.index !=0 }">
         			</tr>
         			<tr>
         		</c:if>
         	 <TD class="kv-label"><label >${item.fieldName}：</label></td><td class="kv-content">
         	 <c:choose>
         	 	<c:when test="${item.conditionType eq 'between' }">
         	 	 	 <c:choose>
         	 			<c:when test="${item.conditionType eq 'between' }">
         	 			 <input class="easyui-datetimebox"   name="${item.field}1"  >至 <input class="easyui-datetimebox"  name="${item.field}2" >
		         	 	 </c:when>
		         	 	<c:otherwise>
		         	 	 <input class="  " name="${item.field}"  >
		         	 	</c:otherwise>
		         	 </c:choose>
         	 	</c:when>
         	 	<c:otherwise>
         	 	 <input class=" " name="${item.field}"  >
         	 	</c:otherwise>
         	 </c:choose>
         	 </TD>
         	  	<c:if test="${status.last}"> </tr></c:if>
           	</c:forEach>
          
           </table>
           </form>
            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="optQuery()">查询</a>
        </div>
    </div>
    <!-- End of toolbar -->

	<table id="dg"></table>

	<div id="win"></div>  

	
</div>
 
<script type="text/javascript">
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
	$('#dg').datagrid({    
	    url:'<%=path%>query/test/1.json',   
	    idField:'${queryTable.idField}',
	    loadMsg:'正在加载数据，请稍后...',
	    pageList:[${queryTable.pageList}],
	   // title:'${queryTable.title}',
	    toolbar: '#tb',
	    queryParams:getQueryParams,
	    pagination:${queryTable.pagination},
	    columns:[[    
	    	<c:forEach items="${queryTable.columns}" var="item">
	    	 	{field:'${item.field}',title:'${item.fieldName}',width:${item.width}}
	    	<c:choose><c:when test="${ status.last}"></c:when><c:otherwise>,</c:otherwise></c:choose>
	    	</c:forEach>
	    ]]
	});  
 
});
function optQuery(){
	$('#dg').datagrid({queryParams:getQueryParams()});    
}

function getQueryParams(){
	//var v = $('#form').serialize();
	//var data = $("#form").serializeArray();
	//alert(data);
	 var jsonuserinfo = $('#form').serializeObject();
	//  alert(jsonuserinfo);
    //  alert(JSON.stringify(jsonuserinfo));
    //  var data =JSON.stringify(jsonuserinfo);
    //  alert(data)
	return jsonuserinfo;// 要提交的表单 
}
	function fmt_opt(){
		return '<a href="javascript:openDetails()" >查看</a>';
	}
	function openDetails(){
		var url = 'customer/details.html';
		window.open(url);
	}
	function openAdd(){
		var url = 'project/apply.html';
		window.open(url);
	}
</script>