<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이슈 게시판</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<link rel="stylesheet" href="css/create_issue.css">
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<style>
ul {
	list-style-type: none;
}

li {
	font-size: 10px
}

.left-bar a {
	text-decoration: none;
	color: #8D52A9;
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

.logo {
	position: relative;
	top: -2.5px;
}

.navbar {
	margin-bottom: 0px;
}

.meber_list_wrap>h2 {
	display: block;
	font-size: 1.5em;
	margin-block-start: 0.83em;
	margin-block-end: 0.83em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	font-weight: bold;
}
td:nth-child(2){
border-bottom:1px solid gray;
padding:10px;
color:rgb(116, 0, 137);



}
td{
border-bottom:1px solid gray;
padding:18px;




}

th{


border-bottom:1px solid gray;
text-align :center;
padding:18px;


}

table{

font-size:20px;
text-align :center;
width:80%;
height:60%;



}
.issue_title{
 margin-top:50px;
}
.issue_page{
margin-left:40%;
margin-top:10px;
font-size:18px;

}

.issue_list_wrap{
 margin-left:20px;

}
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

				<div class="issue_list_wrap">


					<div class="issue_title">
					 <h3>${pname} 멤버리스트</h3>
					</div>
					<hr>
                    <div class="member_total">
					<c:if test="${listcount > 0 }">


						<table class="member_list">

							<tr>
								<th>프로필</th>
								<th>이름</th>
								<th>권한</th>
								<th>연락처</th>
								<th>이메일</th>
							</tr>

							
								<c:set var="num" value="${listcount-(page-1)*limit}" />
                                
								<c:forEach var="m" items="${memberlist}">
									<tr>
										<td><img class="pjImg" src="${m.m_pic2}" width="50" height="50"></td>
										<td>${m.m_name}</td>
										<td>${m.grade2}</td>
										<td>${m.m_tel2}</td>
										<td>${m.m_email2}</td>
									</tr>
								</c:forEach>
							

						</table>
					</c:if>
					<%-- </c:if> --%>
					<div class="issue_page">
						<c:if test="${listcount !=0 }">


							<c:if test="${page <= 1 }">
								<a href="#" class="bt first">&lt;&lt;</a>
								<a href="#" class="bt prev">&lt;</a>
							</c:if>

							<c:if test="${page >1 }">
								<a href="IssueList.bo?page=${page-1}" class="bt first">&lt;&lt;</a>
								<a href="#" class="bt prev">&lt;</a>

							</c:if>

							<c:forEach var="a" begin="${startpage }" end="${endpage }">
								<c:if test="${a==page}">
									<a class="num">${a}</a>
								</c:if>
								<c:if test="${a !=page}">

									<a href="IssueList.bo?page=${a}" class="num">${a}</a>
								</c:if>
							</c:forEach>
							<c:if test="${page >= maxpage }">

								<a href="#" class="bt next">&gt;</a>
								<a href="#" class="bt last">&gt;&gt;</a>
							</c:if>
							<c:if test="${page < maxpage}">
								<a href="#" class="bt next">&gt;</a>
								<a href="#" class="bt last">&gt;&gt;</a>
							</c:if>

						</c:if>
						<c:if test="${listcount ==0 }">
					<h3 style="color:lightgrey;">유저가 존재하지 않습니다.</h3>
				</c:if>
				</div>
						
					
					</div>
				</div>

			</div>
		</div>

	</main>

</body>
</html>