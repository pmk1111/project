<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link href="../css/join.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>
</head>
<body>
<div id="container">
    <header>
      <div id="top_menu">
       <a href="main.jsp"><img class="logo" src="../img/logo.png" alt="메인 로고"></a>
 	 </div>
  	   
      <div id="top_menu1">
      <ul>
          <li><a href="login.jsp">로그인</a></li>
          <li><a href="join.jsp">회원가입</a></li>
      </ul>
      </div>
    </header>
   </div>
   
<form name = "joinform" action="joinProcess.net" method="post">
			<h1>회원가입</h1>
			
			<b>이메일 주소</b>
			<input type="text" name="email" maxLength="30" placeholder="이메일을 입력하세요" required>
			<span id="email_message"></span>
			
			<b>아이디</b>
			<input type="text" id="id" placeholder="아이디를 입력하세요" name = "id" maxLength="12" required>
			<span id="message"></span>
					
			<b>이름</b>
			<input type="text" name="name" placeholder="이름을 입력하세요" maxLength="5" required>
			
			<b>비밀번호</b>
			<input type="password"  placeholder="비밀번호를 입력하세요" name = "passwd" required>
			
			<b>비밀번호 확인</b>
			<input type="password"  placeholder="비밀번호를 한번 더 입력하세요" name = "passwd" required>
			
			<label>
			<input type="checkbox" name="필수" value="필수">
			<span class=required>(필수)</span>서비스 이용약관,개인정보 처리방침<br>
			<input type="checkbox" name="선택" value="선택">(선택)혜택 수신에 동의
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