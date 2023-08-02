<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 생성하기</title>
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/project_create.css">
</head>
<body>
    <header>
        <div id="home_nav">
          <!-- <div id="home_logo"> -->
          <a href="main.jsp"><img class="home_logo" src="../img/logo.png" alt="메인 로고"></a>
          <!-- </div> -->
        </div>
      </header>

<main>
    <div class="create_pj">
    <div class="create_pj_content">
      <h1>프로젝트 생성하기</h1>
      <div class="pj_upload">
        <img class="pj_file" name="pj_file" src="../img/pj_file.png" alt="">
        <div class="filebox bs3-primary">
         <br>
         &nbsp;&nbsp; <input class="upload-name" value="파일선택" disabled="disabled">
          <label for="ex_filename">업로드</label>
          <input type="file" id="ex_filename" class="upload-hidden">
        </div>
      </div>

      <div class="edit">
        <div class="pj_name">
          <p>프로젝트명</p><input type="text" class="id" name="id">
        </div>
        <div class="pj_serial">
          <p>시리얼번호</p><input type="password" class="pw" name="pw">
        </div>
    </div>
    <div class="pj_submit">
      <input type="submit" class="create_pj_btn" value="생성하기">
    </div>
  </div>
  </div>
  </main>
</body>
</html>