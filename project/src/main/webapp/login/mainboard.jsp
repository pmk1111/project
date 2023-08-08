<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/navbar.css">
  <link rel="stylesheet" href="../css/leftbar.css">
  <link rel="stylesheet" href="../css/main.css">
  <link rel="stylesheet" href="../css/mainboard.css">
  
  <style>
  ul {list-style-type: none;}
    li {font-size: 10px}
    a {text-decoration: none; color: #8D52A9;}
    .navbar{margin-bottom: 0px;}
  </style>
</head>
<body>
<header>
<jsp:include page="/menu_bar/navbar.jsp"/>
</header>

	<main>
	<jsp:include page="/menu_bar/leftbar.jsp"/>
		<div class="content">
      <div class="board-content">

        <div class="statue">
          <h2 class="my_work_text">내 작업</h2>
        <div class="my_work_status">
          <p>To Do</p>
          <div class="todo_list">
            <table class="todo_item">
              <tr><td><a href="#">test1</a></td></tr>
              <tr><td><a href="#">test1</a></td></tr>
              <tr><td><a href="#">test1</a></td></tr>
            </table>
          </div>
        </div>

        <div class="my_work_status">
          <p>In Progress</p>
          <div class="progress_list">
            <table class="progress_item">
              <tr><td><a href="#">test1</a></td></tr>
              <tr><td><a href="#">test1</a></td></tr>
              <tr><td><a href="#">test1</a></td></tr>
            </table>
          </div>
        </div>

        <div class="my_work_status">
          <p>Done</p>
          <div class="done_list">
            <table class="done_item">
              <tr><td><a href="#">test1</a></td></tr>
              <tr><td><a href="#">test1</a></td></tr>
              <tr><td><a href="#">test1</a></td></tr>
            </table>
          </div>
        </div>
        </div>



        <div class="board_list_brief">
          <div class="see_all">
          <h2>모든 이슈</h2><a href="#"><sub>전체 보기</sub>
            <img src="../img/add.svg" alt="전체보기" style="position: relative; width: 12px; height: 12px; top: 5px;"></a>
        </div>
          <table class="brief">
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
            <tr>
              <td>admin</td>
              <td>글 제목이 표시됩니다.</td>
              <td>2023-08-07</td>
              <td>25</td>
            </tr>
          </table>
        </div>

        <br><br>
      </div>
    </div>
	</main>
</body>
</html>