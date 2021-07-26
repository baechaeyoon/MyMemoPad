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
<link rel="stylesheet" href="./css/fadein.css">
</head>
<body>
	<%
	//로그인한 사람이라면 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
	int memoID = 0;
	//view.jsp에서 url파라미터로 보낸 memoID를 받는다
	if (request.getParameter("memoID") != null) {
		memoID = Integer.parseInt(request.getParameter("memoID"));
	}
	if (memoID == 0) { 	//memoID가 존재하지않으면 alert띄우고 main.jsp로 돌려보냄
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	Memo memo = new MemoDAO().getBBS(memoID); 	//작성자로 memo를 가져옴
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">
		<img src="./image/icon.png" style="padding:0px 3px 0px 5px;">My Memopad</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="main.jsp">▪ 메인</a>
				</li>
				<li class="nav-item active"><a class="nav-link"
					href="intro.jsp">▪ 소개</a></li>
				<li class="nav-item active"><a class="nav-link text-primary"
					href="userLogout.jsp">▪ 로그아웃</a></li>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="row">
			<table class="table mt-5"
				style="text-align: center; border: 1px solid #dddddd">
				<tbody>
					<tr>
						<td style="width: 20%;">제목</td>
						<td colspan="3"><%=memo.getMemoTitle()%></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3" style="min-height: 200px; text-align: left;"><%=memo.getMemoContent().replaceAll("\r\n", "<br>")%></td>
					</tr>
					<tr>
					<tr>
						<td>이미지</td>
						<td colspan="3" style="min-height: 200px; text-align: left;">
							<img src="<%=memo.getMemoImg()%>" style="width:200px; height: auto;">
						</td>
					</tr>
					<tr>
						<td>URL</td>
						<td colspan="3" style="min-height: 200px; text-align: left;">
							<a href="<%=memo.getMemoURL().replaceAll("\r\n", "<br>")%>" target=”_blank”>
								<%=memo.getMemoURL().replaceAll("\r\n", "<br>")%>
							</a>
						</td>
					</tr>
					<tr>
						<td>평가</td>
						<td colspan="3" style="text-align: left;"><%=memo.getTotalScore()%></td>
					</tr>
					<tr>
						<td>중요도</td>
						<td colspan="3" style="text-align: left;"><%=memo.getImportantScore()%></td>
					</tr>
				</tbody>
			</table>
			<a href="main.jsp" class="btn btn-primary">목록</a> 
			<a href="update.jsp?memoID=<%=memo.getMemoID()%>" class="btn btn-primary mx-2">수정</a> 
			<a href="deleteAction.jsp?memoID=<%=memo.getMemoID()%>"	class="btn btn-primary" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
		</div>
	</div>
	<!-- jQuery 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- pooper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>