<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인보드</title>

<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/mainboard.css">
<script src="js/list_mainboard.js"></script>
<style>
@keyframes fade_in { 

0%{
opacity: 0;
top: -15px;
}

100%{
opacity : 100%;
top : 0px;
}

}

body {
	animation: fade_in 0.4s linear;
}

.content {
	animation: fade_in 0.6s linear;
}

.header-search-btn {
	justify-content: center;
}

ul {
	list-style-type: none;
}

li {
	font-size: 10px
}

a {
	text-decoration: none;
	color: #8D52A9;
}

.navbar {
	margin-bottom: 0px;
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
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
							</table>
						</div>
					</div>

					<div class="my_work_status">
						<p>In Progress</p>
						<div class="progress_list">
							<table class="progress_item">
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
							</table>
						</div>
					</div>

					<div class="my_work_status">
						<p>Done</p>
						<div class="done_list">
							<table class="done_item">
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
								<tr>
									<td><a href="#">test1</a></td>
								</tr>
							</table>
						</div>
					</div>
				</div>



				<div class="board_list_brief">
					<div class="see_all">
						<h2>모든 이슈</h2>
						<a href="IssueList.bo"><sub>전체 보기</sub> <img src="img/add.svg"
							alt="전체보기"
							style="position: relative; width: 12px; height: 12px; top: 5px;"></a>
					</div>
					<table class="brief">
						<!-- <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr> -->

						<tbody>
								<c:set var="num" value="${listcount-(page-1)*limit}" />
								
								<c:forEach var="i" items="${issuelist}">
									<tr>
										<td>${i.i_name}</td>
										<td>
											<div>

												<a class="title" href="IssueDetailAction.bo?num=${i.i_seq }"> 
												<c:if test="${i.i_title.length()>=20 }">
														<c:out value="${i.i_title.substring(0,20) }..." />
													</c:if> <c:if test="${i.i_title.length()<20 }">
														<c:out value="${i.i_title}" />
													</c:if>

												</a>
											</div>
										</td>
										
										<td>${i.i_created }</td>
										<td>${i.i_readcount}</td>

									</tr>
								</c:forEach>
							</tbody>

					</table>
				</div>

				<br> <br>
			</div>
		</div>
	</main>
</body>
</html>