<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();	// 세션 만료시킴
%>
<script>
	location.href = 'index.jsp';	// index로 지정한 페이지로 돌아감
</script>