<%@page import="java.io.File"%>
<%@page import="com.sun.management.OperatingSystemMXBean"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
    <%String path = request.getContextPath()+"/"; %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<script type="text/javascript" src="<%=path%>js/fmt_date.js"></script>
 <jsp:include page="../include.jsp"></jsp:include>
 
 <body >
 <pre>
  服务器信息:
  <%
    OperatingSystemMXBean osmb = (OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();
         
     %>
        系统物理内存总计： <%=osmb.getTotalPhysicalMemorySize() / 1024/1024 %>MB
        系统物理可用内存总计： <%=osmb.getFreePhysicalMemorySize() / 1024/1024 %>MB
        
        硬盘信息：  <% File file = new File("/alidata1");%>  
       <%=file.getPath()%> 信息如下:
             空闲未使用: <%=file.getFreeSpace() / 1024 / 1024/1024%>G
             已经使用 :<%=file.getUsableSpace() / 1024 / 1024/1024%>G
             总容量 :<%=file.getTotalSpace() / 1024 / 1024/1024%>G
          <% 
        %>
        
 </pre>

 
 </body>
 

  