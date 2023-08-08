<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="home_header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>
<script>

	function redirectToGoogleLogin() {
    window.location.href = 'https://accounts.google.com/'; 
  }

function redirectToKakaoLogin() {
    window.location.href = 'https://accounts.kakao.com/'; 
  }
</script>

</head>
<body>
	 <form name = "loginform" method="post" action="loginProcess.net">
            <h1 id="login_text">로그인</h1>

            <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="id" maxlength="20" required><br>
			<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="pass" maxlength="20" required>
	   	    <p class="find_pw">비밀번호 찾기</p>
            <button type="submit" class="login_submit" name="login_submit">로그인</button>
			<p class="auto_login_text">자동 로그인</p><input type="checkbox" class="auto_login" name="auto_login">
			<div class="hr"><span>또는</span> </div>
			
            <button type="button" class="google" onclick="redirectToGoogleLogin()">Google 계정으로 가입하기</button>
  			<br>
  			<button type="button" class="kakao" onclick="redirectToKakaoLogin()">Kakao 계정으로 가입하기</button>
	    	
			
	 </form>

 
</body>
</html>