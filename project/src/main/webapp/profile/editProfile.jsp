<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.Enumeration"%>

<!DOCTYPE html>
<html>
<head>
<title>회원정보수정</title>
<link rel="stylesheet" href="css/navbar.css">
<link rel="stylesheet" href="css/leftbar.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/edit_profile.css">

<script src="js/jquery-3.7.0.min.js"></script>
<script>
	
	//프로필 이미지
	$(document).ready(function () {
		$('input[type=file]').change(function(event) {
			const inputfile = $(this).val().split('\\');
			const filename = inputfile[inputfile.length - 1];

			const pattern = /(gif|jpg|jpeg|png)$/i;
			console.log($(this).val());
			if (pattern.test(filename)) {
				$('.upload-name').val(filename);
				
				const reader = new FileReader(); //파일 읽는 객체

				reader.readAsDataURL(event.target.files[0]);

				reader.onload = function() {
					$('#showImage > img').attr('src', this.result);
				};
			} else {
				alert('이미지 파일(gif,jpg,jpeg,png)만 첨부 바랍니다.');
				$(this).val('')
			}

		})

		//비밀번호 형식 확인
		let checkpass = true;
		
		$(".pass").on('keyup',function(){
			const pattern = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{5,12}$/; 
			const pass_value = $(this).val();
			console.log("checkpass: "+checkpass);
			console.log(pass_value);
			if(!pattern.test(pass_value)){
				$("#pass_message").css('color','red')
								.html("비밀번호 형식이 맞지 않습니다.");
				checkpass = false;
			}else{
				$("#pass_message").html("");
				checkpass = true;
			}
		});
	
		//이메일 형식 확인
		let checkemail=true;
		
		 $(".email").on('keyup',function(){
  		  		const pattern = /^\w+@\w+[.]\w{3}$/;
  		  		const email_value=$(this).val();
  		  		
  		  		if(!pattern.test(email_value)){
  		  			$("#email_message").css('color','red')
  		  						 .html("이메일 형식이 맞지 않습니다.");
  		  			checkemail=false;
  		  		
  		  		}else{
  		  			$("#email_message").html("");
  	  				checkemail=true;
  		  		}
  		  }); 

	
		// 전화번호 형식 확인	
		
		let checktel = true;

		$(".tel").on("input", function() {
 		 const pattern = /^(010)(\d{4})(\d{4})$/;
 		 const telNo = $(this).val();
  		 const nonDigit = telNo.match(/[^0-9]/g); // 숫자가 아닌 문자 확인


 		 if (telNo === '' ) { 
  	    	 $("#tel_message").html("");
   			 checktel = true;
  		} else if (nonDigit || !pattern.test(telNo)) { //문자입력이나 패턴 안맞을때
   		     $("#tel_message").html("전화번호 형식에 맞게 입력하세요.").css('color', 'red');
  		     checktel = false;
 	    } else {
    		 $("#tel_message").html("");
    		 checktel = true;
  		}
  
});
      
	
       
        $('form').submit(function(){
        	
        	if(!checkpass){
        		alert("비밀번호 형식을 확인하세요");
        		$(".pass").focus();
        		return false;
        	}
        	
        	if(!checkemail){
  				alert("이메일 형식을 확인하세요.");
  				$(".email").focus();
  				return false;
  			}
        	
        	  if (!checktel) {
        		    alert("전화번호 형식을 확인하세요.");
        		    $(".tel").focus();
        		    return false;
        		  }
        	
        	
        });//submit
        
	
		
		//회원탈퇴 구현
		$(".withdraw").click(function() {
			const pass = $('.pass');
			const pass_value = pass.val();

			const inputPass = prompt("비밀번호를 입력하세요.");

			const correctPass = "${usrinfo.pass}"; //비밀번호 체크
			
				if (inputPass.trim() != '') {
				// 입력 하지 않은 경우
				
				if (inputPass != correctPass) {
					// 비밀번호가 일치하지 않을때
					alert("비밀번호가 일치하지 않습니다.");
				} else {
					$.ajax({
						url : "usrDelete.net",
						data : {"pass" : pass_value},
						success : function(data) {
							alert("회원탈퇴가 되었습니다.");
							location.href = 'home.net';
						},
					})//ajax end
				}
			} else {
				prompt("비밀번호를 입력하세요.");

			}

		})//function end
	})
	</script>

</head>
<body>
	<header>
		<jsp:include page="/menu_bar/navbar.jsp" />

	</header>

	<main>
		<jsp:include page="/menu_bar/leftbar.jsp" />
		<form name="editform" action="usrEditProcess.net" method="post"
			enctype="multipart/form-data">
			<div class="content">
				<div class="board-content">
					<div class="edit_pf">
						<h2 class="edit_pf_text">프로필 수정</h2>
						<br>
						<div class="filebox bs3-primary">


							<!--  프로필 사진 수정 -->
							<span id="showImage"> 
							<c:if test='${empty usrinfo.pic}'>
									<c:set var='src' value='img/profile3.png' />
								</c:if> 
								<c:if test='${!empty usrinfo.pic}'>
									<c:set var='src' value='${"usrupload/"}${usrinfo.pic}' />
									<input type="hidden" name="check" value="${usrinfo.pic}" >
								</c:if> 
								<img src="${src}" width="185px" alt="profile">
							</span> 
							<br> <br> 
							<input id = "filevalue" class="upload-name" value="파일선택" disabled="disabled"> 
												 
							<label for="ex_filename">업로드
								<input type="file" id="ex_filename" class="upload-hidden" name="pic"
								accept="image/*">
							</label> 
						</div>


						<div class="edit">
							<div class="p_id">
								<p>아이디</p>
								<input type="text" class="id" name="id" value="${usrinfo.id}"
									readOnly>
							</div>

							<div class="p_pass">
								<p>비밀번호</p>
								<input type="password" class="pass" name="pass"
									value="${usrinfo.pass}" maxlength="12" 
									placeholder="숫자,문자 포함 6~12자 사이를 입력해주세요">
									<br>
								<span id="pass_message" ></span>
							</div>

							<div class="p_email">
								<p>이메일</p>
								<input type="text" class="email" name="email"
									value="${usrinfo.email}">
									<br>
								<span id="email_message" ></span>
							</div>
							
										
							<div class="p_name">
								<p>이름</p>
								<input type="text" class="name" name="name"
									value="${usrinfo.name}">
							</div>

							<div class="p_tel">
								<p>전화번호</p>
								<input type="text" class="tel" name="tel" value="${usrinfo.tel}"
								  placeholder="숫자만 입력해주세요" maxlength="11">
								   <br>
								<span id="tel_message" ></span>
							</div>
						</div>
						<br> <br>

						<div class="change_withdraw">
							<input type="submit" class="change_submit" value="수정하기">
							<input type="button" class="withdraw" name="withdraw"
								value="탈퇴하기">
						</div>

						<br> <br>
					</div>
				</div>
			</div>
		</form>
	</main>
	
</body>
</html>