<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정하기</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/leftbar.css">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/edit_profile.css">
</head>
<body>
<header>
<jsp:include page="/menu_bar/navbar.jsp"/>

</header>

<main>
<jsp:include page="/menu_bar/leftbar.jsp"/>
<div class="content">
      <div class="board-content">
        <div class="edit_pf">
          <h2 class="edit_pf_text">프로필 수정</h2>
          <br>
          <div class="filebox bs3-primary">
            <img src="../img/profile2.png" class="profile_img" name="profile_img">
            <br><br>
            <input class="upload-name" value="파일선택" disabled="disabled">
            <label for="ex_filename">업로드</label>
            <input type="file" id="ex_filename" class="upload-hidden">
          </div>
          <div class="edit">
            <div class="u_id">
              <p>아이디</p><input type="text" class="id" name="id" value="내 아이디" readonly>
            </div>
            <div class="u_pw">
              <p>비밀번호</p><input type="password" class="pw" name="pw">
            </div>
            <div class="u_email">
              <p>이메일</p><input type="text" class="mail" name="mail">
            </div>
            <div class="u_name">
              <p>이름</p><input type="text" class="name" name="name">
            </div>
            <div class="poition">
              <p>직책</p><input type="text" class="position" name="position">
            </div>
            <div class="dept">
              <p>부서</p><input type="text" class="dept" name="dept">
            </div>
            <div class="company">
              <p>회사</p><input type="text" class="company" name="company">
            </div>
            <div class="tel">
              <p>전화번호</p><input type="text" class="tel" name="tel">
            </div>
          </div>
          <br><br>
          <div class="change_withdraw">
            <input type="submit" class="change_submit" value="수정하기">
              <input type="button" class="withdraw" value="탈퇴하기">
          </div>
          <br><br>
        </div>
      </div>
    </div>
</main>
</body>
</html>