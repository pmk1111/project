<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인 폼</title>
<link href="../css/login.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>

</head>
<body>
<header>
<div id="home_nav">
      <!-- <div id="home_logo"> -->
       <a href="main.jsp"><img class="home_logo" src="../img/logo.png" alt="메인 로고"></a>
 	 <!-- </div> -->
  	   
      <div id="join_login_btn">
      <ul>
          <li><a class href="login.jsp">로그인</a></li>
          <li><a href="join.jsp">회원가입</a></li>
      </ul>
      </div>
   </div>
    </header>
   
   
	 <form name = "loginform" method="post" action="loginAction.net">
            <h1 id="login_text">로그인</h1>

            <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="id" maxlength="20" required><br>
	    
			<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="pass" maxlength="20" required>
	   	   
            <button type="submit" class="login_submit" name="login_submit">로그인</button>
			
			 <div class="hr"><span>또는</span> </div>
			
            <button type="submit" class="google" >google 계정으로 로그인</button>
            <br>
            <button type="submit" class="kakao">kakao 계정으로 로그인</button>
	    	
			
	 </form>

 
</body>
</html>