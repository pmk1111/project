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


							<!-- <img src="img/profile2.png" class="profile_img" name="profile_img"> -->
							<!--  프로필 사진 수정 -->
							<span id="showImage"> 
							<c:if test='${empty usrinfo.pic}'>
									<c:set var='src' value='img/profile3.png' />
								</c:if> <c:if test='${!empty usrinfo.pic}'>
									<c:set var='src' value='${"usrupload/"}${usrinfo.pic}' />
									<input type="hidden" name="check" value="${usrinfo.pic}">
								</c:if> <img src="${src}" width="185px" alt="profile">
							</span> <br> <br> <input class="upload-name" value="파일선택"
								disabled="disabled"> <span id="filename"></span> <label
								for="ex_filename">업로드</label> <input type="file"
								id="ex_filename" class="upload-hidden" name="pic"
								accept="image/*">
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
									value="${usrinfo.pass}">
							</div>

							<div class="p_email">
								<p>이메일</p>
								<input type="text" class="email" name="email"
									value="${usrinfo.email}">
							</div>
							<%--       <input style="width: 130px;" type="text" class="mail" name="mail" value="${usrinfo.email}"> @
        	  <input style="width: 130px; margin:0;" type=text name=domain id=domain>
      		  <select name=sel id=sel >
            		<option value="">직접입력</option>
            		<option value="naver.com">naver.com</option>
            		<option value="daum.net">daum.net</option>
            		<option value="nate.com">nate.com</option>
            		<option value="gmail.com">gmail.com</option>
     		  </select>
     		   --%>
							<div class="p_name">
								<p>이름</p>
								<input type="text" class="name" name="name"
									value="${usrinfo.name}">
							</div>

							<div class="p_tel">
								<p>전화번호</p>
								<input type="tel" class="tel" name="tel" value="${usrinfo.tel}"
								  maxlength="13">
							</div>
						</div>
						<br> <br>

						<div class="change_withdraw">
							<input type="submit" class="change_submit" value="수정하기">
							<input type="button" class="withdraw" name="withdraw"
								value="탈퇴하기">
						</div>


						<!-- 파이널때 수정할 것 
            <div class="poition">
              <p>직책</p><input type="text" class="position" name="position">
            </div>
            <div class="dept">
              <p>부서</p><input type="text" class="dept" name="dept">
            </div>
            <div class="company">
              <p>회사</p><input type="text" class="company" name="company">
            </div>
              -->


						<br> <br>
					</div>
				</div>
			</div>
		</form>
	</main>
	<script>
		$('input[type=file]').change(function(event) {
			const inputfile = $(this).val().split('\\');
			const filename = inputfile[inputfile.length - 1];

			const pattern = /(gif|jpg|jpeg|png)$/i;
			if (pattern.test(filename)) {
				$('.upload-name').text(filename);

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

		//이메일 도메인 선택
	<%--	 $("#sel").change(function(){
		 const domain = $("#domain");
		 if($(this).val()==""){ 	//직접 선택한 경우
			 domain.val("")
			 	   .focus()
			 	   .prop("readOnly", false);
		 } else {	//도메인 선택한 경우
			 domain.val($(this).val())
			 	   .prop("readOnly", true);
		 }
	 });
	--%>
	
		// 전화번호 형식 확인
		$("input[name=tel]").on('keyup',
				function(){
		const patt = /^[0-9]{2,3}[0-9]{4}[0-9]{4}$/
		const res = patt.test( $(".tel").val());

	
		})
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
	</script>

</body>
</html>