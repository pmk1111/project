<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 초대하기 : ${pname}</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->

<script src="js/member_invite.js"></script>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/member_invite.css">
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
				<div class="addMemberIntoProject">
					<h2 class="addMemberIntoProjectH2">프로젝트에 팀원을 초대하세요</h2>
					<form id="container" method="post" action="MemberInviteProcess.mem">

						<div class="addMemberInput">
							<input class="addMemberSearch" type="text" name="user_ID"
								maxlength="20" placeholder="초대할 유저 정보를 입력하세요."
								autocomplete="off" data-gtm-form-interact-field-id="1">
							<br> <input class="addMemberBtn" type="submit" value="초대하기">
						<br><br><h5>입력 후 초대할 유저의 아이디를 클릭하세요</h5>
						</div>
							
						<div class="MemberList">
							<table class="SearchedMemberInfo">
								<c:forEach var="user" items="${userList}">
									<tr>
										<td><img src="usrupload/${user.pic}" alt="유저 사진"
												 style="width:45px; height:45px; border-radius:3px;"></td>
										<td>${user.name}</td>
										<td><a>${user.id}</a></td>
										<td class="employeeNum">${user.num}</td>
									</tr>
								</c:forEach>
							</table>
							<br> <br>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
</body>
</html>