<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="home_header.jsp" />
<!DOCTYPE html>
<html>
<meta name="google-signin-client_id"
			content="625666498826-vv7f0001u0rk3v8pc18on0icn71vro2e.apps.googleusercontent.com">

<head>
<title>로그인</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>

<script>
$(document).ready(function () {
	
	.abcRioButtonContents.text('구글 계정으로 로그인');
	
	function redirectToGoogleLogin() {
    window.location.href = 'https://accounts.google.com/'; 
  }

function redirectToKakaoLogin() {
    window.location.href = 'https://accounts.kakao.com/'; 
  }
function onSignIn(googleUser) {
	  var profile = googleUser.getBasicProfile();
	  console.log('ID: ' + profile.getId()); 
	  console.log('Name: ' + profile.getName());
	  console.log('Image URL: ' + profile.getImageUrl());
	  console.log('Email: ' + profile.getEmail()); 
	}
	
function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
    });
  }
  
  
	
	$('.abcRioButtonContents span').val('Google 계정으로 로그인')
});
</script>

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
</script>

</head>
<body>
<main>
	<form name="loginform" method="post" action="loginProcess.net">
		<h1 id="login_text">로그인</h1>

		<input type="text" class="form-control" placeholder="아이디를 입력하세요"
			id="id" name="id" maxlength="20" required><br> <input
			type="password" class="form-control" placeholder="비밀번호를 입력하세요"
			name="pass" maxlength="20" required>
		<p class="find_pw">비밀번호 찾기</p>
		<button type="submit" class="login_submit" name="login_submit">로그인</button>
		<p class="auto_login_text">자동 로그인</p>
		<input type="checkbox" class="auto_login" name="auto_login">
		<div class="hr">
			<span>또는</span>
		</div>

		<div class="social-login-group">
		<div class="g-signin2" data-onsuccess="onSignIn"></div>
		
		<a href="#" onclick="signOut();">Sign out</a> <br> <a href="#"
			class="btn_login link_kakao_id" onclick="kakaoLogin();"> <img
			class="kakao-login-btn-img" alt="카카오 계정으로 로그인"
			src="img/kakao_login_large_wide.png">
		</a>
		</div>
		
		<!-- <ul>
			<li class="kakao-login" onclick="kakaoLogin();"><a href="javascript:void(0)"> <span>카카오
						로그인</span>
			</a></li>
			<li onclick="kakaoLogout();"><a href="javascript:void(0)"> <span>카카오
						로그아웃</span>
			</a></li>
		</ul> -->
		<!-- 카카오 스크립트 -->
		<!-- 		<button type="button" class="kakao" onclick="redirectToKakaoLogin()">Kakao
			계정으로 가입하기</button> -->
	</form>

</main>
</body>
</html>