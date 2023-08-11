<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>내 프로젝트 리스트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">

<style>

main {
overflow: "auto";
}

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
	position: relative;
	top: -1px;
}

.header-search {
	box-sizing: content-box;
}

.left-bar-items>label {
	position: relative;
	top: 2.5px;
}

.logo {
	position: relative;
	top: -2.5px;
}

.left-bar {
	width: 260px;
}

.left-bar a {
	text-decoration: none;
	color: #8D52A9;
}

select.form-control {
	width: auto;
	margin-bottom: 2em;
	display: inline-block
}

.gray {
	color: gray;
}

/* Remove rounded borders from list */
.list-group-item:first-child {
	border-top-right-radius: 0;
	border-top-left-radius: 0;
}

.list-group-item:last-child {
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

/* bootstrap */
/* Remove border and add padding to thumbnails */
.thumbnail {
	padding: 0 0 15px 0;
	border: none;
	border-radius: 0;
}

.thumbnail p {
	margin-top: 15px;
	color: #555;
}

/* Black buttons with extra padding and without rounded borders */
.btn {
	padding: 10px 20px;
	background-color: #333;
	color: #f1f1f1;
	border-radius: 0;
	transition: .2s;
}

/* On hover, the color of .btn will transition to white with black text */
.btn:hover, .btn:focus {
	border: 1px solid #333;
	background-color: #fff;
	color: #000;
}

/* 프로젝트 테이블 */
.row {
  display: inline-block;
  font-size: 16px;
  width: calc(25% - 30px);
  margin: 0 5px 20px;
  box-sizing: border-box;
  vertical-align: top;
  weidth : 210px;
}

.project_item {
	margin-top : 70px;
	top : 50%;
	trasform : translate(-50%, 0%);
	margin-left : 100px;
}



/*
body>div>table>thead>tr:nth-child(2)>th:nth-child(1) {
	width: 5%;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(2) {
	width: 20%;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(3) {
	width: 30%;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(4) {
	width: 10%;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(5) {
	width: 10%;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(6) {
	width: 10%;
}

body>div>table>thead>tr:nth-child(2)>th:nth-child(7) {
	width: 15%;
}
*/

</style>
</head>
<body>

	<header>
		<jsp:include page="/menu_bar/navbar.jsp" />
	</header>

	<main>
		<jsp:include page="/menu_bar/leftbar.jsp" />

		<div class="content">

			<div class="board-content">
				<div class ="project_item">
					<c:if test="${listcount > 0 }">

						<!-- 가져온 projectlist 정의 -->
						<c:forEach var="p" items="${projectlist}">

							<div class="row text-center">
								<div class="col-sm-4">
									<div class="thumbnail">
										<img src="${p.p_file}" width="200" height="150">
										<p>
											<strong> 
												<c:if test="${p.p_name.length() >= 20 }">
													<c:out value="${p.p_name.substring(0,20)}..." />
												</c:if> 
												    <c:if test="${p.p_name.length() < 20 }">
													<c:out value="${p.p_name }" />
												</c:if>
											</strong>
										</p>
										<p>${p.p_created }</p>
										<a href="ProjectMainboard.pro?num=${p.p_num }" class="btn">go to Mainboard</a>
									</div>
								</div>
							</div>
						</c:forEach>

						<div class="center-block">
							<ul class="pagination justify-content-center">
								<c:if test="${page <= 1 }">
									<li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
								</c:if>
								<c:if test="${page > 1 }">
									<li class="page-item"><a
										href="ProjectList.pro?page=${page-1 }" class="page-link">이전&nbsp;</a></li>
								</c:if>

								<c:forEach var="a" begin="${startpage }" end="${endpage }">
									<c:if test="${a == page }">
										<li class="page-item active"><a class="page-link">${a }</a></li>
									</c:if>
									<c:if test="${a != page }">
										<li class="page-item"><a href="ProjectList.pro?page=${a}"
											class="page-link">${a}</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${page >= maxpage }">
									<li class="page-item"><a class="page-link gray">&nbsp;다음</a></li>
								</c:if>
								<c:if test="${page < maxpage }">
									<li class="page-item"><a
										href="ProjectList.pro?page=${page + 1 }" class="page-link">&nbsp;다음</a></li>
								</c:if>
							</ul>
						</div>
					</c:if>
					<!-- listcount>0 end -->
					</div>
					<br> <br>

					<c:if test="${listcount == 0 }">
						<h3 style="text-align: center">프로젝트를 생성해 주세요.</h3>
					</c:if>

				</div>
			</div>

	</main>
</body>
</html>