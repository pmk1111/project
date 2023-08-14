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
	0%{opacity: 0;top: -15px;}
	100%{opacity : 100%;top : 0px;}
}

body {animation: fade_in 0.4s linear;}
.content {animation: fade_in 0.6s linear;}
.header-search-btn {position: relative;top: -1px;}
.header-search {box-sizing: content-box;}
.left-bar-items>label {position: relative;top: 2.5px;}
.logo {position: relative;top: -2.5px;}

.left-bar {width: 260px;}

.left-bar a {text-decoration: none;color: #8D52A9;}

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
.pjImg{margin-top:10px;}
.pjName{
display:inline-block; position:absolute; 
min-width:110px;
top:63%; left:50%; transform:translate(-50%, -50%);
margin:10px 0px;
}
.goToMainboardbtn{position:relative; display:inline-block; top:45px; padding-top:8px; width:57%; height:40px; background-color:#8D52A9; border-radius: 3px}
.goToMainboardbtn:hover{opacity: .7; transition:0.4s; text-decoration: none;}
.goToMainboard{width:120px; height:40px; margin-top:15px; color:white; }
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
  position:relative;
  display: inline-block;
  font-size: 16px;
  min-width:210px;
  width: calc(25% - 30px); height:280px;
  margin: 0 5px 20px;
  box-sizing: border-box;
  vertical-align: top;
  border:1.2px solid lightgrey; border-radius: 3px;
}

.project_item {
	margin-top : 70px;
	top : 50%;
	trasform : translate(-50%, 0%);
	margin-left : 100px;
}





.pj_page {
    width: 100%;
     margin: 25px auto;
    display: inline-block;

    text-align: center;

}

.pj_page a {
    display: inline-block;
    width: 32px;
    height: 32px;
    box-sizing: border-box;
    vertical-align: middle;
    border: 1px solid #ddd;
    border-left: 0;
    line-height: 100%;
    color: black;
    text-align: center;
}

.pj_page a.bt {
    color: black;
    padding-top: 8px;
    text-align: center;
    font-size: 12.5px;
    letter-spacing: -1px;
}
.pj_page a {
    padding-top: 9px;
    font-size: 1.4rem;
    border-style: none;
    border-radius:3px;
}
.pj_page .num{font-size:12.5px;}
a.bt.first, a.bt.prev, a.bt.next, a.bt.last{
    border-style: none;
    padding-top: 9px;
}

.pj_page a:hover {
    background: #8D52A9;
    color: #fff;
    text-decoration: none;
    transition:0.4s;
}
.pj_type_img{
	position:relative;
	top:-2.2px;
	margin-right:5px;
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
				<div class ="project_item">
					<c:if test="${listcount > 0 }">

						<!-- 가져온 projectlist 정의 -->
						<c:forEach var="p" items="${projectlist}">

							<div class="row text-center">
								<!-- <div class="col-sm-4"> -->
									<!-- <div class="thumbnail"> -->
										<img class="pjImg" src="${p.p2_file}" width="150" height="150">
										<!-- <p> -->
											<strong class="pjName"> 
												<c:if test="${p.p_name.length() >= 20 }">
													<c:out value="${p.p_name.substring(0,20)}..." />
												</c:if> 
												    <c:if test="${p.p_name.length() < 20 }">
													<c:out value="${p.p_name }" />
												</c:if>
											</strong>
										<!-- </p> -->
										<p>${p.p_created }</p>
										
										<a class="goToMainboardbtn" href="ProjectMainboard.pro?num=${p.p_num }" class="btn">
										<span class="goToMainboard">프로젝트 선택</span></a>
									<!-- </div> -->
								<!-- </div> -->
							</div>
						</c:forEach>

						<%-- <div class="center-block">
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
						</div> --%>
						
						<div class="pj_page">
						<c:if test="${listcount !=0 }">


							<c:if test="${page <= 1 }">
								<a href="#" class="bt first">&lt;&lt;</a>
								<a href="#" class="bt prev">&lt;</a>
							</c:if>

							<c:if test="${page >1 }">
								<a href="ProjectList.pro?page=${page-1 }" class="bt first">&lt;&lt;</a>
								<a href="#" class="bt prev">&lt;</a>

							</c:if>

							<c:forEach var="a" begin="${startpage }" end="${endpage }">
								<c:if test="${a==page}">
									<a class="num">${a}</a>
								</c:if>
								<c:if test="${a !=page}">

									<a href="ProjectList.pro?page=${a}" class="num">${a}</a>
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