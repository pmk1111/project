<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="home_header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link href="css/join.css" rel="stylesheet" type="text/css">
<link href="css/login.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.7.0.min.js"></script>

<style>
.message {
	font-size: 12px;
}

.message.success {
	color: green;
}

.message.error {
	color: blue;
}

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
	height: 45px;
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
<script>

$(document).ready(function () {
	
    $(".id_check").on('click', function () {
        const pattern = /^\w{5,12}$/;
        const id = $("input:eq(0)").val();
        const $message = $("#id_message");

        if (!id) {
            $message.removeClass('message success').addClass('message error').html("아이디를 입력하세요.").css('color', 'red');
            checkid = false;
            return;
        }

        if (!pattern.test(id)) {
            $message.removeClass('message success').addClass('message error').html("영문자 숫자 _ 로 5~12자 가능합니다.").css('color', 'red');
            checkid = false;
            return;
        }

        $message.removeClass('message error success').empty(); // 초기 메시지 제거

        $.ajax({
            url: "idcheck.net",
            data: { "id": id },
            success: function (resp) {
                if (resp == -1) {
                    $message.removeClass('message error').addClass('message success').html("사용 가능한 아이디입니다.");
                    checkid = true;
                } else {
                    $message.removeClass('message success').addClass('message error').html("사용 중인 아이디입니다.");
                    checkid = false;
                }
            }
        });
    });

    $(".pw").on('keyup', function () {
      const pass = $(this).val();
      const passwd = $(".pw_check").val();
      const $passMessage = $("#pw_message");
      const $passwdMessage = $("#pw_check_message");

      if (pass !== '' && passwd !== '' && pass !== passwd) {
        $passwdMessage.addClass('message error').html("비밀번호가 다릅니다.").css('color', 'red');
      } else {
        $passwdMessage.removeClass('message error').empty();
      }
    });

    $(".pw_check").on('keyup', function () {
      const pass = $(".pw").val();
      const passwd = $(this).val();
      const $passMessage = $("#pw_message");
      const $passwdMessage = $("#pw_check_message");

      if (pass !== '' && passwd !== '' && pass !== passwd) {
        $passwdMessage.addClass('message error').html("비밀번호가 다릅니다.").css('color', 'red');
      } else {
        $passwdMessage.removeClass('message error').empty();
      }
    });
  
  
 	function redirectToGoogleLogin() {
	    window.location.href = 'https://accounts.google.com/'; 
	  }

	function redirectToKakaoLogin() {
	    window.location.href = 'https://accounts.kakao.com/'; 
	  }
	
	const form = document.join;

	function emailValCheck(email){
	    if (email === '') return "empty";
	    const emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	    return emailPattern.test(email) ? "valid" : "invalid";
	  }

	  $("#emailAuthBtn").on('click', function () {
	    const email = $("input[name=email]").val();
	    const $message = $("#email_message");
	    const emailCheckResult = emailValCheck(email);

	    if (emailCheckResult === "empty") {
	      $message.addClass('message error').html("이메일을 입력하세요.").css('color','red');
	      return false;
	    } else if (emailCheckResult === "invalid") {
	      $message.addClass('message error').html("이메일 형식에 맞게 입력하세요.").css('color','red');
	      return false;
	    } else {
	      $message.removeClass('message error').empty();
	    }
			
		 var url = "confirmEmail.net";
		 alert('인증번호가 발송되었습니다.');
		 
		  $.ajax({
		        url: url,
		        data: { "email": email }, 
		        success: function (resp) {
		        	$("#authRandNum").val(resp);
		        }
		      });	 
     });

  });
  
function chkAuthMailNum() {
	  var inAuthMailNum = $("input[name=verify]").val();
	  const $verifyMessage = $("#verify_message");

	  if (inAuthMailNum === '') {
	    $verifyMessage.addClass('message error').html('인증번호를 입력하세요.').css('color', 'red');
	    return;
	  }

	  if (inAuthMailNum == $("#authRandNum").val()) {
	    alert("인증성공");
	    $verifyMessage.removeClass('message error').empty(); 
	  } else {
	    alert("인증실패");
	  }
	}


</script>
</head>
<body>

	<form name="joinform" action="joinProcess.net" method="post">
		<h1>회원가입</h1>
		<br>
		<br>
			 <b>아이디</b> <input type="text" id="id"
			placeholder="아이디를 입력하세요" name="id" maxLength="12" required> 
		<button type="button" class="id_check" name="id_check">중복검사</button>
			<span id="id_message"></span>
			<b>비밀번호</b>  <input type="password"	placeholder="비밀번호를 입력하세요" class="pw" name="pass" required>
			<span id="pw_message"></span>
			 <b>비밀번호 확인</b>  <input type="password"
			placeholder="비밀번호를 한번 더 입력하세요" class="pw_check" name="passwd"	required>
			<span id="pw_check_message"></span>
			 <b>이름</b> <input type="text" class="name"
			name="name" placeholder="이름을 입력하세요" maxLength="5" required> <b>이메일
			주소</b> <input type="text" class="email" name="email" maxLength="30"
			placeholder="이메일을 입력하세요" required> 
		<button  id="emailAuthBtn" type="button" class="send_verify" name="send_verify">인증번호 받기</button>
		<span id="email_message"></span>
		<b>인증번호 입력</b> <input id="verify" type="text" class="verify" name="verify"
			maxLength="6" placeholder="인증번호를 입력하세요" required> 
		<button onclick ="chkAuthMailNum()" type="button" id="verify_check" class="verify_check" name="verify">인증번호
			확인</button><span id="verify_message"></span>
		<input type="hidden" id = "authRandNum" name = "authRandNum" />

		<label> <input type="checkbox" id="policy" class="policy"
			name="policy" value="필수"> <label for="policy"><span
				class=required>&nbsp;&nbsp;(필수)</span>서비스 이용약관,개인정보 처리방침</label><br> <input
			type="checkbox" id="benefits" class="benefits" name="benefits"
			value="선택"> <label for="benefits">&nbsp;&nbsp;(선택)혜택
				수신에 동의</label>
		</label>
		<div class="hr">
			<span>또는</span>
		</div>

		<button type="button" class="google" onclick="redirectToGoogleLogin()">Google
			계정으로 가입하기</button>
		<br>
		<button type="button" class="kakao" onclick="redirectToKakaoLogin()">Kakao
			계정으로 가입하기</button>

		<div class="clearfix">
			<button type="submit" class="submitbtn">가입하기</button>

		</div>
	</form>
</body>
</html>