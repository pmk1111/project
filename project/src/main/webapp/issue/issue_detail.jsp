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
<script src="js/board_detail.js"></script>

<style>
.header-search{box-sizing: content-box;}
.left-bar-items > label{position:relative; top:2.2px;}
.left-bar-items a:hover{color:#8D52A9;text-decoration: none}

.info_text{font-size:14px; padding-left:15px; width:90%; height:40px;
	margin:40px 0px 0px 60px; border:1.5px solid lightgray; border-radius:3px 3px 0px 0px; 
	background-color: #F2EFF3; color: #929292;
	display: block;}
.info_text > span{position:relative; top:9px;}
.board_info{    
	/* position: relative; */
    /* top: -1.5px; */
    /* min-width: 270px; */
    width: 90%;
    margin:10px 0px 0px 60px;
    letter-spacing: 0.7px;
    font-size: 12.5px;
    border: 1.5px solid lightgrey;
    border-radius: 0px 0px 3px 3px;
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
      <%--view.js에서 사용예정 --%>
      <div class="content">
         <div class="board-content">
            <div id="board_title_info">

               <span class="pj_board_name" name="pj_board_name">프로젝트&nbsp;&nbsp;/&nbsp;
               ${pName}&nbsp;&nbsp;/&nbsp;<c:if test="${issuedata.i_title.length()>=20 }">
               									<c:out value="${issuedata.i_title.substring(0,20)}..." />
												</c:if><c:if test="${issuedata.i_title.length()<20}">
												<c:out value="${issuedata.i_title}"/></c:if></span>
               <h2 style="font-size: 25px; font-weight: 500; margin-top:10px;">${issuedata.i_title}</h2>
               <!-- <hr style="margin-top:23px; border:0.9px solid lightgrey;"> -->
            </div>
			<div>
            	<input class="reporter" type="text" 
            	value="보고자&nbsp;:&nbsp;${issuedata.i_reporter}"readonly>         
            </div>
			
            <%-- <div class="fav_ed_del">
               <!-- <div class="fav"> -->
               <img id="fav_icon" name="fav" src="img/star_grey.jpeg"> <label
                  for="fav" class="fav_label">즐겨찾기</label>
               <!-- </div> -->
               <div class="ed_del_dropdown">
                  <img class="ed_del_dropdown_icon" src="img/contentSetting.svg"
                     style="position: relative; width: 18px; height: 18px; top: 2.5px;">
                  <div class="ed_del-dropdown_item">
                     <a id="openModalBtn" class="ed_issue" name="ed_issue" href="#">수정</a>

                     <a class="del_issue" name="del_issue"
                        href="IssueDeleteAction.bo?num=${issuedata.i_seq }">삭제</a>
                  </div>
               </div> --%>

               


            <div class="board_desc">
            <div class="discription">
               <span>설명</span>
               </div>
               <div class="issue_content">
                  <span class="i_content">${issuedata.i_content}</span> <br>
                  <br>

               </div>

            </div>
            <%--issue content end --%>
            
            	<div class="info_text">
                  	<span>상세 정보</span>
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
 
            
            

            <input type="hidden" name="num" value="${param.num}"
               id="comment_i_num">
            <%--주소값을 가져오기 --%>
            <div class="reply_textarea">
               <b class="reply-write-area-name">${id}</b>
               <textarea class="reply" id="summernote_comm" name="editordata"
                  maxLength="200"></textarea>
                  <div class="re_sub_cancel">
             <button type="submit" class="re_submit" name="re_submit">댓글달기</button>
             <button type="reset" class="re_cancel" name="re_cancel">취소</button>
          </div>
            </div>

            <div class="reply-write">
               <%-- 댓글창에 등록 --%>

            </div>
            <%--reply-write end --%>
            <div class="reply-area" style="clear: both">
               <div class="reply-order">
                  <ul class="reply-order-list">
                  </ul>
               </div>
               <ul class="reply-list">
               </ul>

            </div>
            <%--reply-area end --%>
            <br>
            <br>
            <br>
         </div>

      </div>
      <%--reply-area end --%>
   </main>

   <jsp:include page="issue_modify.jsp" />
   <script src="js/issue_modal2.js"></script>
   <script>
     $("body").on('keyup'
           , 'div.note-editable'
           , function(){
              //console.log('a')
              //console.log($(this).text())
              
           })
   </script>
</body>
</html>