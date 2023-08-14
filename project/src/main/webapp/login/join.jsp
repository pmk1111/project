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
<script type= "text/javascript">
$(document).ready(function () {
    $(".id_check").on('click', function () {
        const pattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{5,12}$/;
        const id = $("input:eq(0)").val();
        const $message = $("#id_message");
        
        if (!id) {
            $message.removeClass('message success').addClass('message error').html("아이디를 입력하세요.").css('color', 'red');
            $("#isChkId").val("N");
            return;
        }

        if (!pattern.test(id)) {
            $message.removeClass('message success').addClass('message error').html("영문, 숫자 조합하여 5~12글자까지 가능합니다.").css('color', 'red');
            $("#isChkId").val("N");
            return;
        }

        $message.removeClass('message error success').empty();

        $.ajax({
            url: "idcheck.net",
            data: { "id": id },
            success: function (resp) {
                if (resp == -1) {
                    $message.removeClass('message error').addClass('message success').html("사용 가능한 아이디입니다.").css('color', 'blue');
                    $("#isChkId").val("Y");
                } else {
                    $message.removeClass('message success').addClass('message error').html("사용 중인 아이디입니다.").css('color', 'green');
                    $("#isChkId").val("N");
                }
            }
        });
    });

    $("#password").on('focusout', function () {
        const pass = $("#password").val();
        const $message = $("#pw_message");
        const pattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{5,12}$/;

        if (!pattern.test(pass)) {
            $message.removeClass('message success').addClass('message error').html("영문자 숫자로 5~12자 가능합니다.").css('color', 'red');
            $("#isChkPassword").val("N");
        } else {
            $message.removeClass('message error').addClass('message success').html("사용 가능한 비밀번호입니다.").css('color', 'blue');
            $("#isChkPassword").val("Y");
        }
    });

    $("#userName").on('keyup', function () {
        const name = $("#userName").val();
        const pattern = /^([가-힣]{2,4}|[a-zA-Z]{2,15})$/;
        const $message = $("#name_message");

        if (!pattern.test(name)) {
            $message.removeClass('message success').addClass('message error').html("한글 2~4자 또는 영문 2~15자 가능합니다").css('color', 'red');
            $("#isChkName").val("N");
        } else {
            $message.removeClass('message error').addClass('message success').html("사용 가능한 이름입니다.").css('color', 'blue');
            $("#isChkName").val("Y");
        }
    });

    $(".pw, .pw_check").on('keyup', function () {
        const pass = $("#password").val();
        const passwd = $("#confirmPassword").val();
        const $passwdMessage = $("#pw_check_message");

        if (pass !== '' && passwd !== '' && pass !== passwd) {
            $passwdMessage.addClass('message error').html("비밀번호가 다릅니다.").css('color', 'red');
            $("#isChkPassword2").val("N");
        } else {
            $passwdMessage.removeClass('message error').empty();
            $("#isChkPassword2").val("Y");
        }
    });

    const createButton = document.querySelector('.create_pj_btn');
    
    createButton.addEventListener('click', function() {
        if (!validateForm()) {
            alert('프로젝트 생성 조건을 만족하지 않습니다.');
        } else {
            document.projectform.submit();
        }
    });
    fucntion isChkEmail(email){
    	
    }
    
    function validationcheck() {
        const isChkId = $("#isChkId").val();
        const isChkPassword = $("#isChkPassword").val();
        const isChkName = $("#isChkName").val();
        const isChkPassword2 = $("#isChkPassword2").val();
        
        if (isChkId !== "Y") {
            alert('아이디를 확인하세요.');
            return false;
        }
        
        if (isChkPassword !== "Y") {
            alert('비밀번호를 확인하세요.');
            return false;
        }

        if (isChkName !== "Y") {
            alert('이름을 확인하세요.');
            return false;
        }
        
        if (isChkPassword2 !== "Y") {
            alert('비밀번호를 다시 확인하세요.');
            return false;
        }
        
        return true;
    }
});

</script>


</head>
<body>
   <main>
   <form name="joinform" action="joinProcess.net" method="post">
      <h1>회원가입</h1>
      <br>
      <br>
          <b>아이디</b>
           <input type="text" id="userId"  placeholder="아이디를 입력하세요" name="id" maxLength="12" required> 
     		 <button type="button" class="id_check" name="id_check">중복검사</button>
         		<span id="id_message"></span>
          <b>비밀번호</b>
           <input type="password" id="password" placeholder="비밀번호를 입력하세요" class="pw" name="pass" required>
         		<span id="pw_message"></span>
          <b>비밀번호 확인</b>
           <input type="password" id="confirmPassword"  placeholder="비밀번호를 한번 더 입력하세요" class="pw_check" name="passwd"   required>
        		 <span id="pw_check_message"></span>
          <b>이름</b>
           <input type="text" id="userName" class="name"  name="name" placeholder="이름을 입력하세요" maxLength="15" required>
           		 <span id="name_message"></span>
          <b>이메일 주소</b>
           <input type="text" id="email"  class="email" name="email" maxLength="30"  placeholder="이메일을 입력하세요" required> 
    		  <button  id="emailAuthBtn" type="button" class="send_verify" name="send_verify">인증번호 받기</button>
    			  <span id="email_message"></span>
    	  <b>인증번호 입력</b>
    	   <input id="verify" type="text" class="verify" name="verify" maxLength="6" placeholder="인증번호를 입력하세요" required> 
     		 <button onclick ="chkAuthMailNum()" type="button" id="verify_check" class="verify_check" name="verify"> 인증번호 확인</button>
     		 <span id="verify_message"></span>
     	  

      <label>
       <input type="checkbox" id="policy" class="policy" name="policy" value="필수">
        <label for="policy">  <span class=required>&nbsp;&nbsp;(필수)&nbsp;</span>
            서비스 이용약관,개인정보 처리방침</label>
            <br>
            <input type="checkbox" id="benefits" class="benefits" name="benefits" value="선택">
             <label for="benefits">&nbsp;&nbsp;(선택)&nbsp;혜택 수신에 동의</label>
      </label>
      <div class="clearfix">
         <button type="submit" class="submitbtn" onclick="validationcheck()">가입하기</button>
      </div>
   </form>
    <input type="hidden" id = "authRandNum" name = "authRandNum" />
    
    <input type="hidden" id ="isChkId" name = "isChkId" value="N"/>
	<input type="hidden" id ="isChkPassword" name = "isChkPassword" value="N"/>
	<input type="hidden" id ="isChkPassword2" name = "isChkPassword2" value="N"/>
	<input type="hidden" id ="isChkName" name = "isChkName" value="N"/>
	<input type="hidden" id ="isChkEmail" name = "isChkEmail" value="N"/>
	<input type="hidden" id ="isChkverify" name = "isChkverify" value="N"/>
	<input type="hidden" id ="isChkpolicy" name = "isChkpolicy" value="N"/>
   </main>
</body>
</html>