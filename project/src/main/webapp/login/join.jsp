<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:include page="home_header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link href="css/join.css" rel="stylesheet" type="text/css">
<link href="css/login.css" rel="stylesheet" type="text/css">		<!-- common.css -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
   <main>
   <form id="joinform" name="joinform" action="joinProcess.net" method="post">
      <h1>회원가입</h1>
      <div class = "formDiv">
      	<div>
			<b class="bTxt">아이디</b>
	        <input type="text" id="userId"  placeholder="아이디를 입력하세요" name="id" maxLength="12" required> 
     		<button type="button" id="chkIdBtn">중복검사</button>
	        <p class="errMsg" id="id_message">오류메세지 영역</p>
      	</div>
      	<div>
      		<b class="bTxt">비밀번호</b>
           	<input type="password" id="password" placeholder="비밀번호를 입력하세요" class="pw" name="pass" required>
         	<p class="errMsg" id="pw_message">오류메세지 영역</p>
      	</div>
      	<div>
      		<b class="bTxt">비밀번호 확인</b>
           	<input type="password" id="confirmPassword"  placeholder="비밀번호를 한번 더 입력하세요" class="pw_check" name="passwd"   required>
        	<p class="errMsg" id="pw_check_message">오류메세지 영역</p>
      	</div>
      	<div>
      		<b class="bTxt">이름</b>
           	<input type="text" id="userName" class="name"  name="name" placeholder="이름을 입력하세요" maxLength="15" required>
           	<p class="errMsg" id="name_message">오류메세지 영역</p>
      	</div>
      	<div>
      		<b class="bTxt">이메일 주소</b>
           	<input type="text" id="email"  class="email" name="email" maxLength="30"  placeholder="이메일을 입력하세요" required> 
    		<button  id="emailAuthBtn" type="button" name="send_verify">메일발송</button>
    		<p class="errMsg" id="email_message">오류메세지 영역</p>
      	</div>
      	<div>
      		<b class="bTxt">인증번호 입력</b>
    	   	<input id="verify" type="text" class="verify" name="verify" maxLength="6" placeholder="인증번호를 입력하세요" required> 
     		<button onclick ="chkAuthMailNum()" type="button" id="verify_check">인증하기</button>
     		<p class="errMsg" id="verify_message">오류메세지 영역</p>
      	</div>
    	  
    	<div class="mt10">
	   		<div>
	   			<input type="checkbox" id="policyCheckbox" class="policy" name="policy" value="필수">
	   			<label for="policy" class="policyLabel">  
	        		<b class="require">(필수)</b>&nbsp;
	        		<a href="Service.net" style="color:#7C00B6; text-decoration: dash ">
	        		서비스 이용약관</a>,<a href="PrivatePolicy.net" style="color:#7C00B6; text-decoration: dash ">개인정보 처리방침</a>에 동의합니다.
	           	</label>
			</div>
			<br>
			<div>
	          	<input type="checkbox" id="benefits" class="benefits" name="benefits" value="선택">
	            <label for="benefits" class="benefitsLabel">  
	            	<b>(선택)</b>&nbsp;혜택 수신에 동의합니다.
			    </label>
			</div>
    	</div>
      </div>
    
      <div class="clearfix">
         <button type="button" id="confirmBtn" class="submitbtn" onclick="validationcheck()"><strong>가입하기</strong></button>
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

<script type="text/javascript">

function chkAuthMailNum() {		
	var authRandNum = $("#authRandNum").val();
    var inAuthMailNum = $("#verify").val();	//입력받은 인증번호
    
    const $verifyMessage = $("#verify_message");	//오류를 출력하기 위한 메세지태그

    if(authRandNum === ''){
    	$verifyMessage.attr("style","visibility:visible");
        $verifyMessage.html('인증번호받기 버튼을 눌러 인증번호를 받으세요.');
        return;	
    }
    if(inAuthMailNum === '') {
    	$verifyMessage.attr("style","visibility:visible");
        $verifyMessage.html('인증번호를 입력하세요.');
        return;
    }
    if (inAuthMailNum == $("#authRandNum").val()) {
        alert("인증성공");
        $("#isChkverify").val("Y");
        $verifyMessage.attr("style","visibility:hidden");
    } else {
        alert("인증실패");
        $("#isChkverify").val("N");
    }
}

function printErrMsg(id,msg,color){
	const printErrObj = $("#"+id);
	printErrObj.html(msg);
	printErrObj.attr("style","visibility:visible");
	
	if(color != undefined && color != ""){
		printErrObj.css("color",color);
	}else{
		printErrObj.css("color","red");
	}
}

function emailValCheck(email) {
    if (email === '') return "empty";
    const emailPattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
    return emailPattern.test(email) ? "valid" : "invalid";
}


$(document).ready(function () {
	
    $("#chkIdBtn").on('click', function () {
        const pattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{5,12}$/;
        const id = $("#userId").val();
        
        if (id == "") {
        	printErrMsg('id_message','아이디를 입력하세요.');
			return;
        }

        if (!pattern.test(id)) {
        	printErrMsg('id_message','영문, 숫자 조합하여 5~12글자까지 가능합니다.');
			return;
        }

        $("#id_message").attr("style","visibility:hidden");

        $.ajax({
            url: "idcheck.net",
            data: { "id": id },
            success: function (resp) {
                if (resp == -1) {
                	printErrMsg('id_message','사용가능한 아이디입니다.','green');
                    $("#isChkId").val("Y");
                } else {
                	printErrMsg('id_message','사용 중인 아이디입니다.');
                    $("#isChkId").val("N");
                }
            }
        });
    });

    $("#password").on('focusout', function () {
        const pass = $("#password").val();
        const pattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{5,12}$/;

        if (!pattern.test(pass)) {
        	printErrMsg('pw_message','영문자 숫자로 5~12자 가능합니다.');
            $("#isChkPassword").val("N");
        } else {
        	printErrMsg('pw_message','사용 가능한 비밀번호입니다.','green');
            $("#isChkPassword").val("Y");
        }
    });

    $("#userName").on('focusout', function () {
        const name = $("#userName").val();
        const pattern = /^([가-힣]{2,4}|[a-zA-Z]{2,15})$/;
        if (!pattern.test(name)) {
        	printErrMsg('name_message','한글 2~4자 또는 영문 2~15자 가능합니다.');
            $("#isChkName").val("N");
        } else {
        	printErrMsg('name_message','사용 가능한 이름입니다.','green');
            $("#isChkName").val("Y");
        }
    });

    $("#confirmPassword").on('focusout', function () {
        const pass = $("#password").val();
        const passwd = $("#confirmPassword").val();
       
        const $passwdMessage = $("#pw_check_message");

        if (pass !== '' && passwd !== '' && pass !== passwd) {
        	printErrMsg('pw_check_message','비밀번호가 다릅니다.');
            $("#isChkPassword2").val("N");
        } else {
        	$('#pw_check_message').attr("style","visibility:hidden");
            $("#isChkPassword2").val("Y");
        }
    });

    
    var emailAuthTimer;
    var sendMailAble = 'Y';
    
    $("#emailAuthBtn").on("click", function () {
        const email = $("#email").val();
        const emailCheckResult = emailValCheck(email);
        
        if (emailCheckResult === "empty") {
         	printErrMsg('email_message','이메일을 입력하세요.');
            return false;
        } else if (emailCheckResult === "invalid") {
        	printErrMsg('email_message','이메일 형식에 맞게 입력하세요.');
            return false;
        } else
        	printErrMsg('name_message','사용 가능한 이메일입니다.','green');
        	$("#isChkEmail").val("Y");
        
        if(sendMailAble =="N"){
        	printErrMsg('email_message','1분 후 다시 발송가능합니다.');
            return false;
        }
        $('#email_message').attr("style","visibility:hidden");

        var url = "confirmEmail.net";
        alert("인증번호가 발송되었습니다.");

        $.ajax({
            url: url,
            data: { email: email },
            success: function (resp) {
                $("#authRandNum").val(resp);
            },
        });

        // 타이머를 시작합니다. 초(60000ms) 후에 버튼을 다시 활성하고 텍스트를 변경합니다.
        clearTimeout(emailAuthTimer);
        sendMailAble="N";
        emailAuthTimer = setTimeout(function () {
            printErrMsg('email_message','이메일을 입력하세요.','green');
            clearTimeout(emailAuthTimer);
            sendMailAble="Y";
        }, 60000);
    });

    $("#verifyBtn").on("click", function () {
        chkAuthMailNum();
    });
   
});



function validationcheck() {
 	const isChkId = $("#isChkId").val();
    const isChkPassword = $("#isChkPassword").val();
    const isChkName = $("#isChkName").val();
    const isChkPassword2 = $("#isChkPassword2").val();
    const isChkEmail = $("#isChkEmail").val();
    const isChkverify = $("#isChkverify").val();
    const isChkpolicy = $("#isChkpolicy").val();

    if (isChkId !== "Y") {
        alert('아이디를 확인하세요.');
        $("#userId").focus();
        return false;
    }

    if (isChkPassword !== "Y") {
        alert('비밀번호를 확인하세요.');
        $("#password").focus();
        return false;

    }

    if (isChkName !== "Y") {
        alert('이름을 확인하세요.');
        $("#userName").focus();
        return false;
    }

    if (isChkPassword2 !== "Y") {
        alert('비밀번호를 다시 확인하세요.');
        $("#password").focus();
        return false;
    } 
    if (isChkEmail !== "Y") {
        alert('이메일을 확인하세요');
        $("#email").focus();
        return false;
    } 
    if (isChkverify !== "Y") {
        alert('인증번호를 확인하세요');
        $("#verify").focus();
        return false;
    } 
    if ($("#policyCheckbox").is(":checked") != true) {
        alert('서비스 이용약관 동의는 필수입니다.');
        $("#policyCheckbox").focus();
        return false;
    } 
    

    $("#joinform").submit();
}
</script>

</html>