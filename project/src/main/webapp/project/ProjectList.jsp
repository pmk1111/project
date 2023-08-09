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
	overflow : "auto";
}

 @keyframes fade_in{
      0%{opacity: 0; top:-15px;}
      100%{opacity: 100%; top: 0px;}
    }
   	body{animation: fade_in 0.4s linear;}
   	.content{animation: fade_in 0.6s linear;}
.header-search-btn{position:relative; top:-1px;}
.header-search{box-sizing:content-box;}
.left-bar-items>label {
  position: relative;
  top:2.5px;
}
.logo{
position:relative;
top:-2.5px;
}
.left-bar{width:260px;}
.left-bar a {
	text-decoration: none;
	color: #8D52A9;
}
select.form-control {
	width: auto;
	margin-bottom: 2em;
	display: inline-block
}

.rows {
	text-align: right;
}

.gray {
	color: gray;
}

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
<div class ="container">
	<c:if test="${listcount > 0 }">

		<div class="rows">
		<br>
		<table class="table table-striped">
			<thead>
				<tr>
					<th colspan="3">내 프로젝트 리스트</th>
					<th colspan="2"><span>글 개수 : ${listcount}</span></th>
				</tr>
				<tr>
					<th><div>번호</div></th>
					<th><div>프로필</div></th>
					<th><div>제목</div></th>
					<th><div>상태</div></th>
					<th><div>시작일</div></th>
					<th><div>마감일</div></th>
					<th><div>생성일</div></th>
				</tr>
			</thead>
			<tbody>
				<!-- num 정의 -->
				<c:set var="num" value="${listcount-(page-1)*limit}" />
				
				<!-- 가져온 projectlist 정의 -->
				<c:forEach var="p" items="${projectlist}">
				
					<tr>
						
						<!-- 번호 할당 -->
						<td>
							<c:out value="${num}" /> 
							<c:set var="num" value="${num-1}" />
						</td>
						
						<!-- 사진 등록 -->
						<td>
							<img src="projectupload/${p.p_file}" width="50" height="50">
						</td>
						
						
						<td>
							<div>
								<!-- 이름 클릭시 p_num에 해당하는 프로젝트로 이동 -->
								<a href="ProjectMainboard.pro?p_num=${p.p_num }"> 
									
									<!-- 이름 길이 나타내는 방법 -->
									<c:if test="${p.p_name.length() >= 20 }">
										<c:out value="${p.p_name.substring(0,20)}..." />
									</c:if> 
									<c:if test="${p.p_name.length() < 20 }">
										<c:out value="${p.p_name }" />
									</c:if>
									
								</a>
							</div>
						</td>
						
						
						<td><div>${p.p_status }</div></td>
						<td><div>${p.p_start }</div></td>
						<td><div>${p.p_closing }</div></td>
						<td><div>${p.p_created }</div></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
				</div>
		<div class="center-block">
			<ul class="pagination justify-content-center">
				<c:if test="${page <= 1 }">
					<li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
				</c:if>
				<c:if test="${page > 1 }">
					<li class="page-item"><a href="BoardList.bo?page=${page-1 }"
						class="page-link">이전&nbsp;</a></li>
				</c:if>

				<c:forEach var="a" begin="${startpage }" end="${endpage }">
					<c:if test="${a == page }">
						<li class="page-item active"><a class="page-link">${a }</a></li>
					</c:if>
					<c:if test="${a != page }">
						<li class="page-item"><a href="BoardList.bo?page=${a}"
							class="page-link">${a}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${page >= maxpage }">
					<li class="page-item"><a class="page-link gray">&nbsp;다음</a></li>
				</c:if>
				<c:if test="${page < maxpage }">
					<li class="page-item"><a href="BoardList.bo?page=${page + 1 }"
						class="page-link">&nbsp;다음</a></li>
				</c:if>
			</ul>
		</div>
	</c:if> <!-- listcount>0 end -->
		<br>
	<br>

	<c:if test="${listcount == 0 }">
		<h3 style="text-align: center">프로젝트를 생성해 주세요.</h3>
	</c:if>

	</div>
	</div>
	
	</div>
	</main>
</body>
</html>