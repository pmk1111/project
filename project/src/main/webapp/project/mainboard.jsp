<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인보드 : ${pname}</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="js/list.js"></script>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>


<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/mainboard.css">
<link rel="stylesheet" href="css/create_issue.css">
<script src="js/list_mainboard.js"></script>
<script src="js/getToDoList.js"></script>
<script src="js/getProgressList.js"></script>
<script src="js/getDoneList.js"></script>
<style>
.header-search-btn {
	justify-content: center;
}

ul {
	list-style-type: none;
}

li {
	font-size: 10px
}

.header-search {
	box-sizing: content-box;
}

.left-bar {
	width: 260px;
}

.left-bar-items>label {
	position: relative;
	top: 2.5px;
}
.left-bar-items a:hover{color:#8D52A9;text-decoration: none}
.logo {
	position: relative;
	top: -2.5px;
}

.navbar {
	margin-bottom: 0px;
}

@keyframes modal_slide_fade { 
	0% {opacity: 0;margin-top: -30px;}
	100%{opacity:1;margin-top:0;}
}
#issue_modal {
	animation: modal_slide_fade .5s linear;
}
.addToDoList, .addProgressList, .addDoneList{
	padding-left:0px !important;
	/* background-color: lightgray; */
	background-color: rgb(240, 240, 240);
}
.addToDoListBtn, .addProgressListBtn, .addDoneListBtn{
	text-align:left;
	width:220px; height:32px;
	border-radius:3px;
	padding-left:10px;
	border-style: none;
}
.addToDoListBtn:hover, .addProgressListBtn:hover, .addDoneListBtn:hover{
	background-color: rgb(220, 220, 220); transition:.5s;
	visibility: visible;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="../menu_bar/navbar.jsp" />
	</header>

	<main>
		<jsp:include page="../menu_bar/leftbar.jsp" />
		<div class="content">
			<div class="board-content">

				<div class="statue">
					<h2 class="my_work_text">내 작업</h2>
					<div class="my_work_status">
						<p>To Do</p>
						<div class="todo_list">
							<table class="todo_item">
								<!-- <tbody>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								</tbody> -->
								<c:set var="num" value="${listcount-(page-1)*limit}" />

								<c:forEach var="i2" items="${issuelist2}">
									<tbody>
									<tr>
										<td>
											<div>
												<a class="title" href="IssueDetailAction.bo?num=${i2.i_seq }">
													<c:if test="${i2.i_title.length()>=15 }">
														<c:out value="${i2.i_title.substring(0,15) }..." />
													</c:if> <c:if test="${i2.i_title.length()<15 }">
														<c:out value="${i2.i_title}" />
													</c:if>
												</a>
											</div>
										</td>
									</tr>
									</tbody>
								</c:forEach>
								<c:if test="${issuelist2 == null or fn:length(issuelist2) < 3}">
									<tr><td class="addToDoList"><button class="openModalBtn addToDoListBtn">
									<img class="plusicon" src="img/plusicon.svg"><span class="openModalText">이슈 작성하기</span></button></td></tr>
								</c:if>
							</table>
						</div>
					</div>

					<div class="my_work_status">
						<p>In Progress</p>
						<div class="progress_list">
							<table class="progress_item">
								<c:set var="num" value="${listcount-(page-1)*limit}" />

								<c:forEach var="i3" items="${issuelist3}">
									<tbody>
									<tr>
										<td>
											<div>
												<a class="title" href="IssueDetailAction.bo?num=${i3.i_seq }">
													<c:if test="${i3.i_title.length()>=15 }">
														<c:out value="${i3.i_title.substring(0,15) }..." />
													</c:if> <c:if test="${i3.i_title.length()<15 }">
														<c:out value="${i3.i_title}" />
													</c:if>
												</a>
											</div>
										</td>

									</tr>
									</tbody>
								</c:forEach>
								
								<c:if test="${issuelist3 == null or fn:length(issuelist3) < 3}">
									<tr><td class="addProgressList"><button class="openModalBtn addProgressListBtn">
									<img class="plusicon" src="img/plusicon.svg"><span class="openModalText">이슈 작성하기</span></button></td></tr>
								</c:if>
							</table>
						</div>
					</div>

					<div class="my_work_status">
						<p>Done</p>
						<div class="done_list">
							<table class="done_item">
								<c:set var="num" value="${listcount-(page-1)*limit}" />

								<c:forEach var="i4" items="${issuelist4}">
									<tbody>
									<tr>
										<td>
											<div>
												<a class="title" href="IssueDetailAction.bo?num=${i4.i_seq }">
													<c:if test="${i4.i_title.length()>=15 }">
														<c:out value="${i4.i_title.substring(0,15) }..." />
													</c:if> <c:if test="${i4.i_title.length()<15 }">
														<c:out value="${i4.i_title}" />
													</c:if>
												</a>
											</div>
										</td>

									</tr>
									</tbody>
								</c:forEach>
								
								<c:if test="${issuelist4 == null or fn:length(issuelist4) < 3}">
									<tr><td class="addDoneList"><button class="openModalBtn addDoneListBtn">
									<img class="plusicon" src="img/plusicon.svg"><span class="openModalText">이슈 작성하기</span></button></td></tr>
								</c:if>
							</table>
						</div>
					</div>
				</div>



				<div class="board_list_brief">
					<div class="see_all">
						<h2>모든 이슈</h2>
						<a href="IssueList.bo"><sub>전체 보기</sub> <img src="img/add.svg"
							alt="전체보기"
							style="position: relative; width: 12px; height: 12px; top: 2px;"></a>
					</div>
					<%-- <c:if test="${listcount > 0 }"> --%>
					<table class="brief">
						<thead>
							<tr>
								<td>작성자</td>
								<td>제목</td>
								<td>타입</td>
								<td>작성일</td>
								<td>조회수</td>

							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${listcount-(page-1)*limit}" />

							<c:forEach var="i" items="${issuelist1}">

								<tr>
									<td>${i.i_name}</td>
									<td>
										<div>

											<a class="title" href="IssueDetailAction.bo?num=${i.i_seq }">
												<c:if test="${i.i_title.length()>=30 }">
													<c:out value="${i.i_title.substring(0,30) }..." />
												</c:if> <c:if test="${i.i_title.length()<30 }">
													<c:out value="${i.i_title}" />
												</c:if>

											</a>
										</div>
									</td>
									<td><img class="issue_type_img" src="">${i.i_type}</td>
									<td>${i.i_created }</td>
									<td>${i.i_readcount}</td>

								</tr>
							</c:forEach>
						</tbody>

					</table>
					<%-- </c:if> --%>
				</div>

				<br> <br>
			</div>
		</div>
	</main>
	
	<jsp:include page="../issue/create_issue.jsp"/>
	<script src="js/issue_modal.js"></script>
</body>
</html>