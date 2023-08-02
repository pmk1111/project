<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link href="../css/join.css" rel="stylesheet" type="text/css">
<link href="../css/login.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>

<style>
form {
	background-color: #fefefe;
	margin: 5% auto 15% auto;
	/* 5% from the top, 15% from the bottom and centered */
	border: none;
	width: 750px; /* Could be more or less, depending on screen size */
	padding: 16px;
}

input[type=text], input[type=password] {
    width: 580px;
    height:45px;
    padding: 10px;
    margin: 5px 0 30px 0;
    display: inline-block;
    border: 0.8px solid #8D52A9;
    border-radius: 3px;
}

.hr {
	display: flex;
	flex-basis: 100%; /*가로 방향으로 flex 컨테이너의 전체 너비를 차지 */
	align-items: center;
	color: rgba(0, 0, 0, 0.35);
	font-size: 12px;
	margin: 30px 0px 30px 0px;
}

input[id="policy"] {
	position: relative;
	top: 1.5px;
}

input[id="benefits"] {
	position: relative;
	top: 3.5px;
}

label[for="policy"] {
	position: relative;
	top: -2.5px;
}

</style>
</head>
<body>

    <header>
      <%@include file="/login/home_header.jsp"%>
    </header>
   
<form name = "joinform" action="joinProcess.net" method="post">
			<h1>회원가입</h1>
			<br><br>
			<b>아이디</b>
			<input type="text" id="id" placeholder="아이디를 입력하세요" name = "id" maxLength="12" required>
			<span id="id_message"></span>
			<button type="button" class="id_check" name="id_check">중복검사</button>
			
			<b>비밀번호</b>
			<span id="pw_message"></span>
			<input type="password"  placeholder="비밀번호를 입력하세요" class="pw" name = "passwd" required>
			
			<b>비밀번호 확인</b>
			<span id="pw_check_message"></span>
			<input type="password"  placeholder="비밀번호를 한번 더 입력하세요" class="pw_check" name = "passwd" required>
			
			<b>이름</b>
			<input type="text" class="name" name="name" placeholder="이름을 입력하세요" maxLength="5" required>
			
			<b>이메일 주소</b>
			<input type="text" class="mail" name="mail" maxLength="30" placeholder="이메일을 입력하세요" required>
			<span id="email_message"></span>
			<button type="button" class="send_verify" name="send_verify">인증번호 받기</button>
			
			<b>인증번호</b>
			<input type="text" class="verify" name="verify" maxLength="30" placeholder="인증번호를 입력하세요" required>
			<span id="verify_message"></span>
			<button type="button" class="verify_check" name="verify">인증번호 확인</button>
					
			
			<label>
			<input type="checkbox" id="policy" class="policy" name="policy" value="필수">
			<label for="policy"><span class=required>&nbsp;&nbsp;(필수)</span>서비스 이용약관,개인정보 처리방침</label><br>
			<input type="checkbox" id="benefits" class="benefits" name="benefits" value="선택">
			<label for="benefits">&nbsp;&nbsp;(선택)혜택 수신에 동의</label>
			</label>
			<div class="hr"> <span>또는</span> </div>
			
            <button type="submit" class="google" >google 계정으로 가입하기</button>
            <br>
            <button type="submit" class="kakao">kakao 계정으로 가입하기</button>
			
			<div class="clearfix">
				<button type="submit" class="submitbtn">가입하기</button>

			</div>
	</form>
</body>
</html>