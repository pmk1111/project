<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 보기</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/leftbar.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/edit_profile.css">
<jsp:include page="../menu_bar/navbar.jsp"/>
</head>
<body>
<jsp:include page="../menu_bar/leftbar.jsp"/>
<div class="container">
	<table class="table table-bordered">
	
		<tr>
			<td>번호</td>
			<td>${usrinfo.num}</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>${usrinfo.id}</td><%--Member클래스의 getId()메서드 --%>
		</tr>
		<tr>
			<td>이름</td>
			<td>${usrinfo.name}</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>${usrinfo.pass}</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>${usrinfo.tel}</td>
		</tr>
		<tr>
			<td>이메일주소</td>
			<td>${usrinfo.email}</td>
		</tr>
		<tr>
			<td>프로필사진</td>
			<td>${usrinfo.pic}</td>
		</tr>
		<tr>
			<td colspan=2>
			<a href="usrList.net">리스트로 돌아가기</a></td>
		</tr>
	
	</table>
</div>
</body>
</html>
