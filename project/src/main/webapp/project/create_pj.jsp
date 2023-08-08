<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 생성하기</title>
<link rel="stylesheet" href="../css/create_pj.css">
  <link rel="stylesheet" href="../css/main.css">
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
    <!-- <div class="create_pj"> -->
    <form action="#" method="post">
    <div class="create_pj_content">
      <h1>프로젝트 생성하기</h1>
      <div class="pj_upload">
        <img class="pj_file" name="pj_file" src="../img/pj_file.png" alt="">
      </div>

      <div class="filebox bs3-primary">
        &nbsp;&nbsp; <input class="upload-name" value="파일선택" disabled="disabled">
         <label for="ex_filename">업로드</label>
         <input type="file" id="ex_filename" class="upload-hidden">
       </div>

      <div class="edit">
        <div class="pj_name">
          <p>프로젝트명</p><input type="text" class="id" name="id">
        </div>
        <div class="pj_statue">
          <p>진행상태</p>
          <select name="statue" id="statue">
            <option>To Do</option>
            <option>In Progress</option>
            <option>Done</option>
          </select>
        </div>
        <div class="pj_statue">
          <p>프로젝트 생성일</p><input type="datetime-local" id="create_date" name="create_date">
        </div>
        <div class="pj_begin">
          <p>프로젝트 시작일</p><input type="date" id="begin" name="begin">
        </div>
        <div class="pj_end">
          <p>프로젝트 종료일</p><input type="date" id="end" name="end">
        </div>
        <div class="pj_submit">
          <button type="submit" class="create_pj_btn">생성하기</button>
        </div>

    </div>
  </div>
</form>
<!-- </div> -->
  </main>

  <script>
    document.getElementById('create_date').value= new Date().toISOString().slice(0, -1);
  </script>
</body>
</html>