<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="memo.*, util.*"%>

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
	
	String memoTitle = null;
	String memoDivide = null;
	String memoContent = null;
	String totalScore = null;
	String importantScore = null;
	String memoURL = null;
	String memoImg = null;
	
	if(request.getParameter("memoDivide") != null)
		memoDivide = request.getParameter("memoDivide");
	if(request.getParameter("memoTitle") != null)
		memoTitle = request.getParameter("memoTitle");
	if(request.getParameter("memoContent") != null)
		memoContent = request.getParameter("memoContent");
	if(request.getParameter("totalScore") != null)
		totalScore = request.getParameter("totalScore");
	if(request.getParameter("importantScore") != null)
		importantScore = request.getParameter("importantScore");
	if(request.getParameter("memoURL") != null)
		memoURL = request.getParameter("memoURL");
	if(request.getParameter("memoImg") != null)
		memoImg = request.getParameter("memoImg");
	
	
	if(memoTitle == null || memoContent == null || totalScore == null || importantScore == null ||  memoTitle.equals("") || memoContent.equals("")) {
		// 하나라도 입력 안 된 사항 있을 때(memoTitle memoContent는 공백이 있을 경우로 조건 걺)
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	MemoDAO memoDAO = new MemoDAO();
	int result = memoDAO.write(new Memo(0, userID, memoDivide, memoTitle, memoContent, totalScore, importantScore, memoURL, memoImg));
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
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>