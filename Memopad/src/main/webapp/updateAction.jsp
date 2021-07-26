<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder"%>
<%@ page import="user.*,memo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>My Memopad</title>
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if (session.getAttribute("userID") != null) {	// userID 이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");	//userID에 해당 세션값을 넣어 줌
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인하세요.')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
	}
	
	// 글이 유효한지 판별
	int memoID = 0;
	if (request.getParameter("memoID") != null) {
		memoID = Integer.parseInt(request.getParameter("memoID"));
	}
	if (memoID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
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
	Memo memoUser = new MemoDAO().WriterCheck(memoID);	// 작성자로 memo를 가져옴
	if (!userID.equals(memoUser.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('수정 권한이 없습니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} else {
		Memo memo = new Memo(memoID, userID, memoDivide, memoTitle, memoContent, totalScore, importantScore, memoURL, memoImg);
		MemoDAO memoDAO = new MemoDAO();
		int result = memoDAO.update(memo);
		if (result == -1) {		// DB 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		} else {	// 수정 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정되었습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
			script.close();
		}
	}
	%>
	
</body>
</html>