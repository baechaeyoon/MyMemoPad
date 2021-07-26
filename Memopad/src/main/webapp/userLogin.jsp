<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
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
<link rel="stylesheet" href="login.css">
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인된 상태입니다.');");
		script.println("location.href = 'main.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	%>
	<form action="userLoginAction.jsp" method="post" class="loginForm">	<!-- userLoginAction으로 실행되 페이지 -->
		<h2>WELCOME!</h2>
		<img src="./image/memo.png">
		<div class="idForm">
			<input type="text" class="id" placeholder="ID" name="userID">
		</div>
		<div class="pwForm">
			<input type="password" class="pw" placeholder="PW" name="userPassword">
		</div>
		<input type="submit" class="btn btn-primary form-control"
			value="LOG IN">
		<div class="bottomText">
			계정이 없으신가요? <a href="userJoin.jsp">회원가입</a>
		</div>

	</form>
	<!-- jQuery 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- pooper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>