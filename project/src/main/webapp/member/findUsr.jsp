<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버초대</title>
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
</style>

<script>

$(document).ready(function () {

  $(".userID li").hide();

  $("input[name='user_ID']").on("keyup", function () {
    const searchValue = $(this).val().toLowerCase();

    if (!searchValue) {
      $(".userID li").hide();
      return;
    }


    $(".userID li").each(function () {
      const userId = $(this).text().toLowerCase();

      if (userId.indexOf(searchValue) > -1) {
        $(this).show();
      } else {
        $(this).hide();
      }
      
    });
  });

  $(".userID li a").on("click", function (e) {
    e.preventDefault();

    const selectedUserID = $(this).text();
    $("input[name='user_ID']").val(selectedUserID);

    $(".userID li").hide();
  });
  
  $("form").on("submit", function (e) {
    let isValid = true;

    if (!$("input[name='user_ID']").val()) {
      alert("유저 ID를 입력하세요");
      isValid = false;
      }

    if (!isValid) {
      e.preventDefault();
    }
    
  });
  
});
</script>

</head>
<body>

	<header>
		<jsp:include page="/menu_bar/navbar.jsp" />
	</header>


	<main>

		<jsp:include page="/menu_bar/leftbar.jsp" />

		<form  id="container" method="post" action="MemberInviteProcess.mem">
		<div class="input">
			<div class="label">
				<label>유저 초대하기</label>
			</div>
			<input type="text" name="user_ID" maxlength="20" placeholder="유저 ID를 검색하세요." autocomplete="off" class="search" data-gtm-form-interact-field-id="1"> 
		</div>
		
		<ol class="userID">
		
			<c:forEach var="user" items="${userList}">
				<li><a>${user.id}</a></li>
			</c:forEach>

		</ol>
		
		<input type="submit" value="초대">
		</form>
	</main>
</body>
</html>