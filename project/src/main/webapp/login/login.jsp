<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="home_header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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

            <input type="text" class="form-control" placeholder="아이디를 입력하세요" id="id" name="id" maxlength="20" required><br>
			<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="pass" maxlength="20" required>
	   	    <p class="find_pw">비밀번호 찾기</p>
            <button type="submit" class="login_submit" name="login_submit">로그인</button>
			<p class="auto_login_text">자동 로그인</p><input type="checkbox" class="auto_login" name="auto_login">
			<div class="hr"><span>또는</span> </div>
			
            <button type="button" class="google" onclick="redirectToGoogleLogin()">Google 계정으로 가입하기</button>
  			<br>
  			<%--<ul>
	<li onclick="kakaoLogin();">
      <a href="javascript:void(0)">
          <span>카카오 로그인</span>
      </a>
	</li>
	<li onclick="kakaoLogout();">
      <a href="javascript:void(0)">
          <span>카카오 로그아웃</span>
      </a>
	</li>
</ul>
<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('80212a777e0765c1a3d3ce429414c9a1'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>--%>
  			 <button type="button" class="kakao" onclick="redirectToKakaoLogin()">Kakao 계정으로 가입하기</button>
	    	
			
	 </form>

 
</body>
</html>