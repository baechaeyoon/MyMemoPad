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
	<!-- 메모 등록하기 화면 구현 -->
	<div class="container">
		<div class="modal-header">
			<h5 class="modal-title" id="modal">📝 메모 추가</h5>
			<button type="button" class="close" data-dismiss="modal"
				onClick="location.href='main.jsp'">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<form action="./writeAction.jsp" method="post">
				<div class="form-row">
					<div class="form-group col-sm-4">
						<label>그룹</label> 
						<select name="memoDivide" class="form-control">
							<%
								String userID = null;
								if (session.getAttribute("userID") != null) { 	// userID 이름으로 세션이 존재하는 회원들은 
									userID = (String) session.getAttribute("userID"); // userID에 해당 세션값을 넣어 줌
								}
								
							 	ArrayList<Tab> tabList1 = new TabDAO().getTabNameList(userID);
						
								if (tabList1.size() > 0){
									for (int i = 0; i < tabList1.size(); i++) {
										Tab tab = tabList1.get(i);
							%>
							<option value=<%=tab.getTabName()%>>
								<%=tab.getTabName()%>
							</option>
							<%
									}
								}
							%>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label>제목</label> <input type="text" name="memoTitle"
						class="form-control" maxlength="50">
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea name="memoContent" id = "text" class="form-control" maxlength="2048"
						style="height: 200px;"></textarea>
				</div>
				<div class="form-group">
					<label>이미지 링크</label>
					<textarea name="memoImg" id = "text" class="form-control" maxlength="2048"
						style="height: 100px;"></textarea>
				</div>
				<div class="form-group">
					<label>URL</label>
					<textarea name="memoURL" id = "text" class="form-control" maxlength="1000"
						style="height: 100px;"></textarea>
				</div>
				<div class="form-row">
					<div class="form-group col-sm-3">
						<label>평가</label> <select name="totalScore" class="form-control">
							<option value="5" selected>5</option>
							<option value="4">4</option>
							<option value="3">3</option>
							<option value="2">2</option>
							<option value="1">1</option>
						</select>
					</div>
					<div class="form-group col-sm-3">
						<label>중요도</label> <select name="importantScore"
							class="form-control">
							<option value="5" selected>5</option>
							<option value="4">4</option>
							<option value="3">3</option>
							<option value="2">2</option>
							<option value="1">1</option>
						</select>
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						onClick="location.href='main.jsp'">취소</button>
					<button type="submit" class="btn btn-primary">등록하기</button>
				</div>
			</form>
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