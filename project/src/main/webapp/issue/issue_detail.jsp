<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<link rel="stylesheet" href="css/view.css" type="text/css">
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/board_detail.css">
<link rel="stylesheet" href="css/create_issue.css">
<script src="js/board_detail.js"></script>


</head>
<body>
	<header>
		<jsp:include page="/menu_bar/navbar.jsp" />
	</header>

	<main>
		<jsp:include page="/menu_bar/leftbar.jsp" />
		<input type="hidden" id="loginid" value="${id}" name="loginid"><%--view.js에서 사용예정 --%>
		<div class="content">
      <div class="board-content">
        <div id="board_title_info">

          <span class="pj_board_name" name="pj_board_name">프로젝트 / ${pName} /	${issuedata.i_title} </span>
          <h2 style="font-size: 1.5em;">${issuedata.i_title}</h2>
        </div>

        <div class="fav_ed_del">
          <!-- <div class="fav"> -->
            <img id="fav_icon" name="fav" src="img/star_grey.jpeg">
            <label for="fav" class="fav_label">즐겨찾기</label>
          <!-- </div> -->
          <div class="ed_del_dropdown">
            <img class="ed_del_dropdown_icon" src="img/favorite.png"
              style="position: relative; width: 18px; height: 18px; top: 3.2px;">
            <div class="ed_del-dropdown_item">
              <a id="openModalBtn" class="ed_issue" name="ed_issue" href="#" >수정</a>
     
              <a class="del_issue" name="del_issue" href="BoardDeleteAction.bo?num=${issuedata.p_num }" >삭제</a>
            </div>
          </div>

          <div class="board_info">
            <span>상세 정보</span>
            <hr>
            <div class="create">
              <span>생성일</span><span id="i_create">${issuedata.i_created }</span>
            </div>
            <div class="reporter">
            <span>보고자</span><span id="i_reporter">${issuedata.i_reporter}</span>
          </div>
          <div class="assign">
            <span>담당자</span><span id="i_assign">${issuedata.i_assign}</span>
          </div>
          <div class="status">
            <span>진행상태</span><span id="i_status">${issuedata.i_status}</span>
          </div>
          </div>
        </div>


        <div class="board_desc">
          <span>내용</span>
          <div class="issue_content">
          <span class="i_content">${issuedata.i_content}</span>
  
          <br><br><br><br>
          
        </div>
                   
    </div> <%--issue content end --%>
	<input type="hidden" name="num" value="${param.num}"
	                       id="comment_i_num"> <%--주소값을 가져오기 --%>
	<div class = "reply-area">
		<div class = "reply-order">
		  <ul class="reply-order-list">
		  </ul>
		</div>
		<ul class="reply-list">
		</ul>
		<div class="reply-write"> <%-- 댓글창에 등록 --%>
          <div class="reply_textarea">
            <b class="reply-write-area-name">${id}</b>
            <textarea id="summernote_comm" name="editordata" maxLength="200"></textarea>
          </div>
          
          <div class="re_sub_cancel">
             <button type="submit" class="re_submit" name="re_submit">댓글달기</button>
             <button type="submit" class="re_cancel" name="re_cancel">취소</button>
          </div>
        </div> <%--reply-write end --%>
      </div> <%--reply-area end --%>
        <br><br><br>
      </div>

    </div>
	</main>
	
	<jsp:include page="issue_modify.jsp"/>
	<script src="js/issue_modal.js"></script>

</body>
</html>