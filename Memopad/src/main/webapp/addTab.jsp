<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="memo.*, util.*, tab.*, user.*"%>

<%
request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	String tabName = null;
	if(request.getParameter("tabName") != null)
		tabName = request.getParameter("tabName");
	
 	if(tabName == null || tabName.equals("")){
		// 하나라도 입력 안 된 사항 있을 때
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이름을 입력해 주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	TabDAO tabDAO = new TabDAO();
	int result = tabDAO.add(userID, tabName);
	if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('추가되었습니다.');");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>