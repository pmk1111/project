<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/board_detail.css">
<link rel="stylesheet" href="css/create_issue.css">
<script src="js/comm.js"></script>
<!-- <script src="js/board_detail.js"></script> -->

<script>
/* 상세보기 드롭다운 아이템 클릭 시, info_dropdown_item의 display none 해제 */
/* $(document).ready(function() {
  const infoDownWrap = $(".info_down_wrap");
  const infoDropdownItem = $(".info_dropdown_item");

  infoDownWrap.on("click", function() {
    infoDropdownItem.slideToggle();
  });
}); */

$(document).ready(function() {
	  const infoDownWrap = $(".info_down_wrap");
	  const infoDropdownItem = $(".info_dropdown_item");

	  infoDownWrap.on("click", function() {
	    if (infoDropdownItem.is(":visible")) {
	      infoDropdownItem.slideUp(400);
	    } else {
	      infoDropdownItem.slideDown(400);
	    }
	  });
	  
	/*   const edDelIcon = $(".ed_del_dropdown_icon");
	  const edDelItem = $(".ed_del_dropdown_item");
	  
	  edDelIcon.on("click", function() {
		  console.log("Clicked on edDelIcon");
		  if (edDelItem.is(":visible")) {
		    console.log("Dropdown item is visible. Sliding up.");
		    edDelItem.slideUp(400);
		  } else {
		    console.log("Dropdown item is hidden. Sliding down.");
		    edDelItem.slideDown(400);
		  }
	  }); */
	});
</script>

<style>
.header-search {
	box-sizing: content-box;
}

.left-bar-items>label {
	position: relative;
	top: 2.2px;
}

.left-bar-items a:hover {
	color: #8D52A9;
	text-decoration: none
	

}
</style>
</head>
<body>
	<header>
		<jsp:include page="/menu_bar/navbar.jsp" />
	</header>

	<main>
		<jsp:include page="/menu_bar/leftbar.jsp" />
		<input type="hidden" id="loginid" value="${id}" name="loginid">
		<%--comm.js에서 사용예정 --%>
		<div class="content">
			<div class="board-content">
				<div id="board_title_info">

					<span class="pj_board_name" name="pj_board_name">
						프로젝트&nbsp;&nbsp;/&nbsp; ${pName}&nbsp;&nbsp;/&nbsp;
						<c:if test="${issuedata.i_title.length()>=20 }">
							<c:out value="${issuedata.i_title.substring(0,20)}..." />
						</c:if>
						 <c:if test="${issuedata.i_title.length()<20}">
							<c:out value="${issuedata.i_title}" />
						</c:if>
					</span>
					<h2 style="font-size: 25px; font-weight: 500; margin-top: 10px;">${issuedata.i_title}</h2>
					<!-- <hr style="margin-top:23px; border:0.9px solid lightgrey;"> -->
				</div>
				<div>
					<input class="reporter" type="text"
						value="보고자&nbsp;:&nbsp;${issuedata.i_reporter}" readonly>
				</div>



				<%-- 	<div class="fav_ed_del">
				<div class="fav">
               <img id="fav_icon" name="fav" src="img/star_grey.jpeg"> <label
                  for="fav" class="fav_label">즐겨찾기</label>
               </div>
               <div class="ed_del_dropdown">
                  <img class="ed_del_dropdown_icon" src="img/contentSetting.svg"
                     style="position: relative; width: 18px; height: 18px; top: 2.5px;">
                  <div class="ed_del-dropdown_item">
                     <a id="openModalBtn" class="ed_issue" name="ed_issue" href="#">수정</a>

                     <a class="del_issue" name="del_issue"
                        href="IssueDeleteAction.bo?num=${issuedata.i_seq }">삭제</a>
                  </div>
               </div>
               </div> --%>

				<div class="board_desc">
					<div class="discription">
						<span>설명</span>
					</div>
					<div class="issue_content">
						<span class="i_content">${issuedata.i_content}</span> <br> <br>

					</div>

				</div>
				<%--issue content end --%>

				<div class="info_down_wrap">
					<img class="info_down" src="img/infoDown.svg" width="18px"
						height="18px">
				</div>
				<div class="info_dropdown_item">

					<div class="info_text">
						<span>상세 정보</span>

						<div class="fav_ed_del">
							<div class="fav">
								<img id="fav_icon" name="fav" src="img/star_grey.jpeg"> <label
									for="fav" class="fav_label">즐겨찾기</label>
							</div>
						
							<div class="ed_del_dropdown">
							<c:if test="${issuedata.i_id == id || id =='admin' }">
								<img class="ed_del_dropdown_icon" src="img/contentSetting.svg">
								<div class="ed_del-dropdown_item">
									<a id="openModalBtn" class="ed_issue" name="ed_issue" href="#">수정</a>

									<a class="del_issue" name="del_issue"
										href="IssueDeleteAction.bo?num=${issuedata.i_seq }">삭제</a>
								</div>
								</c:if>
							</div>
						
						</div>
					</div>

					<div class="board_info">
						<div class="create">
							<span>생성일</span><span id="i_create">${issuedata.i_created }</span>
						</div>
						<div class="assign">
							<span>담당자</span><span id="i_assign">${issuedata.i_assign}</span>
						</div>
						<div class="status">
							<span>진행상태</span><span id="i_status">${issuedata.i_status}</span>
						</div>
					</div>
				</div>



		<input type="hidden" name="num" value="${param.num}"
					id="comment_i_num">
		<div class="comment-area">
			<div class="comment-head">
			
				<div class="comment-write">
				
				<div class="comment-write-area">
					<textarea placeholder="댓글을 남겨보세요" rows="1"
						class="comment-write-area-text" maxLength="200"></textarea>
					
				</div>
				<div class="re_sub_cancel">
								<button type="submit" class="re_submit" name="re_submit">댓글달기</button>
								<button type="reset" class="re_cancel" name="re_cancel">취소</button>
				</div>
				</div><%--comment-write end--%>
			</div><%-- comment-head end--%>
				<div class="comment-order">
					<ul class="comment-order-list">
					</ul>
				</div>
		
				<ul class="comment-list">
				</ul>
		
		</div><%-- comment-area end--%>
				<br> <br> <br>
			</div>

		</div>
		<%--comment-area end --%>
	</main>

	<jsp:include page="issue_modify.jsp" />
	<script src="js/issue_modal2.js"></script>
	
</body>
</html>