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
<script src="js/list.js"></script>

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
<link rel="stylesheet" href="css/board_list.css">
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

.issue_list_wrap>h2 {
	display: block;
	font-size: 1.5em;
	margin-block-start: 0.83em;
	margin-block-end: 0.83em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	font-weight: bold;
}
</style>

<!-- <script>
	$(document).ready(function() {

		$('#summernote').summernote({
			height : 300,
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : "ko-KR",
			placeholder : '최대 2048자까지 쓸 수 있습니다'
		});

		// 서머노트에 text 쓰기
		$('#summernote').summernote('insertText', 'sample Text');

		// 서머노트 쓰기 비활성화
		$('#summernote').summernote('disable');

		// 서머노트 쓰기 활성화
		$('#summernote').summernote('enable');

		// 서머노트 리셋
		$('#summernote').summernote('reset');

		// 마지막으로 한 행동 취소 ( 뒤로가기 )
		$('#summernote').summernote('undo');
		// 앞으로가기
		$('#summernote').summernote('redo');

	});
</script>
 -->
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
						<h2>전체이슈</h2>
					</div>

					<c:if test="${listcount > 0 }">

						<div class="selector">
							<label>필터</label> <label> 유형: <select class="numbers">
									<option value="1">모두</option>
									<option value="2">2</option>
							</select>
							</label> <label> 중요도: <select class="numbers">
									<option value="1">모두</option>
									<option value="2">2</option>
							</select>
							</label> <label> 작성자: <select class="numbers">
									<option value="1">모두</option>
									<option value="2">2</option>
							</select>
							</label> <label> 담당자: <select class="numbers">

									<option value="1">모두</option>
									<option value="2">2</option>

							</select>
							</label>
						</div>
						<!-- selector end -->


						<table class="issue_list">

							<tr>
								<th>작성자</th>
								<th>제목</th>
								<th>작성일</th>
								<th>조회수</th>

							</tr>

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
					<h3 style="color:lightgrey;">등록 된 글이 없습니다.</h3>
				</c:if>
						<button id="openModalBtn" class="write">글쓰기</button>
					</div>
				</div>


			</div>
		</div>

	</main>

	<jsp:include page="create_issue.jsp" />
	<script src="js/issue_modal.js"></script>

</body>
</html>