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
	<%
	request.setCharacterEncoding("UTF-8"); // 한글 안 깨지도록 설정
	String memoDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if (request.getParameter("memoDivide") != null)
		memoDivide = request.getParameter("memoDivide");
	if (request.getParameter("searchType") != null)
		searchType = request.getParameter("searchType");
	if (request.getParameter("search") != null)
		search = request.getParameter("search");
	if (request.getParameter("pageNumber") != null)
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch (Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
	String userID = null;
	if (session.getAttribute("userID") != null) { 	// userID 이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID"); // userID에 해당 세션값을 넣어 줌
	}
	if (userID == null) { // 로그인 안 돼 있는 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인하세요.');");
		script.println("location.href = 'userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">
		<img src="./image/icon1.png" style="padding:0px 3px 0px 5px;">My Memopad</a>
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
		<form method="get" action="./main.jsp" class="form-inline mt-3">
			<select name="memoDivide" class="form-control mx-1 mt-2" id="category">
				<!-- 탭 분류  -->
				<option value="전체">전체</option>
				<%
				 	ArrayList<Tab> tabList1 = new TabDAO().getTabNameList(userID);
					if (tabList1.size() > 0){
						for (int i = 0; i < tabList1.size(); i++) {
							Tab tab = tabList1.get(i);
				%>
				<option value=<%=tab.getTabName()%>
					<%if (tab.getTabName().equals(memoDivide))out.println("selected");%>>
					<%=tab.getTabName()%>
				</option>
				<%
						}
					}
				%>
			</select>

			<!-- 정렬 타입 -->
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순"
					<%if (searchType.equals("최신순"))out.println("selected");%>>최신순</option>
				<option value="중요도순"
					<%if (searchType.equals("중요도순"))out.println("selected");%>>중요도순</option>
				<option value="평가점수순"
					<%if (searchType.equals("평가점수순"))out.println("selected");%>>평가점수순</option>
			</select> 
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요." />

			<!-- 버튼 -->
			<button type="submit" class="btn btn-outline-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" href="write.jsp">메모 +</a> 
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#tabModal">카테고리 편집</a>
		</form>

		<!-- DB에 저장된 메모 불러오기(MemoDAO 참고) -->
		<%
	 	ArrayList<Memo> memoList = new MemoDAO().getList(memoDivide, userID, searchType, search, pageNumber);
		if (memoList != null)
			for (int i = 0; i < memoList.size(); i++) {
				if (i == memoList.size()) {
					break;	
				}
				Memo memo = memoList.get(i);
		%>

		<!-- 화면에 보여지는 메모 스타일 -->
		<div class="card bg-light mt-3" style="height: auto;">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">📂 <%=memo.getMemoDivide()%>&nbsp;
					</div>
					<div class="col-4 text-right">
						평가 <span style="color: red;"><%=memo.getTotalScore()%></span> 중요도
						<span style="color: red;"><%=memo.getImportantScore()%></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<a href="view.jsp?memoID=<%=memoList.get(i).getMemoID()%>"><%=memoList.get(i).getMemoTitle()%>&nbsp;</a>
				</h5>
				<div class="row">
					<p class="card-text col-sm-8" id="text"><%=memo.getMemoContent().replaceAll("\r\n", "<br>")%></p>
					<div class="row col-sm-4">
						<img src="<%=memo.getMemoImg()%>" style="width:150px; height: auto;">
					</div>
				</div>

			</div>
			<div class="card-footer">📌 <a href="<%=memo.getMemoURL().replaceAll("\r\n", "<br>")%>" target=”_blank”>
								<%=memo.getMemoURL().replaceAll("\r\n", "<br>")%>
							</a>
			</div>
		</div>
		<%
		}
		%>
	</div>

	<!-- 카테고리 추가하기 화면 -->
	<div class="modal fade" id="tabModal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">📂 카테고리 편집</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./addTab.jsp" method="post">
						<div class="form-group mt-2">
							<label>카테고리 추가</label> <input type="text" name="tabName"
								class="form-control" maxlength="50">
							<button type="button" class="btn btn-secondary mt-2"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary mt-2" id="addTab">추가</button>
						</div>
					</form>
					<form action="./deleteTab.jsp" method="post">
						<div class="form-group mt-4">
							<label>카테고리 삭제</label> <select name="tabName"
								class="form-control">
								<%
								ArrayList<Tab> tabList = new TabDAO().getTabNameList(userID);
								if (tabList.size() > 0) {
									for (int i = 0; i < tabList.size(); i++) {
										Tab tab = tabList.get(i);
								%>
								<option value=<%=tab.getTabName()%>><%=tab.getTabName()%></option>
								<%
								}
								}
								%>
							</select>
							<button type="button" class="btn btn-secondary mt-2"
								data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary mt-2">삭제</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-3 text-center" style="color: #FFFFFF;">
		Copyright &copy; 2021 DCU Capstone Team 04 Rights Reserved.</footer>
	<!-- jQuery 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- pooper 추가 -->
	<script src="./js/popper.js"></script>
	<!-- bootstrap.js 추가 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>