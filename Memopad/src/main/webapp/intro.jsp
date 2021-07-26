<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.PrintWriter, java.util.ArrayList, java.net.URLEncoder"%>
<%@ page import="memo.*, util.*, tab.*, user.*"%>
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
	<div class="container mt-2">
		<div class="row">
			<div class="card" style="text-align:center; float:none; margin:auto">
				<div class="card-body">
				<img src="./image/dcu.jpg" class="card-img-top" style="border: 10px;"/>
					<h4>Info</h4>
					<h5>나만의 필요한 정보를 모아 두는 다용도 메모장</h5>
					<p class="card-text">평소에 웹 사이트를 통해서 원하는 정보를 따로 저장해 관리해 주는 곳이
						없어서 나중에 다시 찾게 될 때 종종 링크를 잊어버리는 경우가 많습니다.<br>
					    북마크하고 싶은 제품들을 발견한 즉시 장단점을 메모하고 점수로 평가하여 비교하기 위해 시공간에 제약받지 않고 확인할 수 있도록<br>
						웹과 모바일을 연동시킨 다목적성 메모장 서비스입니다.</p><br>
					<h4>Developer</h4>
					<h5>대구가톨릭대학교 소프트웨어융합대학 컴퓨터소프트웨어학부</h5>
					<h5>캡스톤디자인 4조 취업시켜조</h5>
					<p class="card-text">사이버보안전공 17 권 세 연<br> 사이버보안전공 18 배 채 윤<br>
					컴퓨터공학전공 18 장 소 연<br> 컴퓨터공학전공 18 김 민 승 </p>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-4 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2021 DCU Capstone Team 04 Rights Reserved.</footer>
	<!-- jQuery 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- pooper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.min.js"></script>ipt>
</body>
</html>