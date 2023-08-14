<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
    function loginLink() {
	    location.href = "login.net";
    }
    function joinLink(){
    	location.href = "join.net"	
    }
  </script>
<!-- 중복되는 html 태그 삭제 -->
<div id="home_nav">
      <!-- <div id="home_logo"> -->
       <a href="home.net">
       <img class="home_logo" src="img/logo.png" alt="메인 로고"></a>
 	 <!-- </div> -->
  	   
      <div id="join_login_btn">
      <ul>
          <li><button class="header_login_btn" type="button" onclick="loginLink()">로그인</button></li>
          <!--  href='login.net' -->
          <li><button class="header_join_btn" type="button" onclick="joinLink()">회원가입</button></li>
      </ul>
      </div>
   </div>

