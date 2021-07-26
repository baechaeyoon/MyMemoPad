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
<title>강의평가 웹 사이트</title>
<!-- bootstrap CSS 추가 -->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!-- custom CSS 추가 -->
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="join.css">
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {	// userID 이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");	//userID에 해당 세션값을 넣어 줌
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 된 상태입니다.');");
		script.println("location.href = 'main.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	%>
	<form action="userRegisterAction.jsp" method="post" class="loginForm">
		<!-- header -->
		<div id="header">
			<h2>SIGN UP</h2>
			<img src="./image/memo.JPG">
		</div>

		<section class="container mt-3" style="max-width: 560px;">
			<form method="post" action="./userRegisterAction.jsp">	<!-- userRegisterAction으로 실행되는 페이지 -->
				<div class="form-group">
					<input type="text" name="userID" id="id" placeholder="ID" class="form-control">
					<span class="error_next_box"></span>
				</div>
				<div class="form-group">
					<input type="password" name="userPassword" id="pw" placeholder="8-20 Characters" class="form-control">
					<span id="alertTxt">사용불가</span>
					<span class="error_next_box"></span>
				</div>
				<div class="form-group">
					<input type="email" name="userEmail" placeholder="E-mail" class="form-control">
				</div>
				<input type="submit" class="submitbtn btn-primary form-control" value="SIGN UP">
				<button type="button" class="backbtn" onClick="location.href='userLogin.jsp'">BACK</button>
			</form>
		</section>

	</form>
	<!-- wrapper -->
	<script src="join.js"></script>
	<!-- jQuery 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- pooper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>