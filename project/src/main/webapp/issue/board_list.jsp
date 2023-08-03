<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

  <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  <!-- include summernote css/js -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

  <link rel="stylesheet" href="../css/create_issue.css">
  <link rel="stylesheet" href="../css/navbar.css">
  <link rel="stylesheet" href="../css/leftbar.css">
  <link rel="stylesheet" href="../css/main.css">
  <link rel="stylesheet" href="../css/board_list.css">
  <style>
    ul {
      list-style-type: none;
    }

    li {
      font-size: 10px
    }

    .left-bar a {
      text-decoration: none;
      color: #8D52A9;
    }

    .navbar {
      margin-bottom: 0px;
    }
  </style>

  <script>
    $(document).ready(function () {


      $('#summernote').summernote({
        height: 300,
        minHeight: null,
        maxHeight: null,
        focus: true,
        lang: "ko-KR",
        placeholder: '최대 2048자까지 쓸 수 있습니다'
      });


      // 서머노트에 text 쓰기
      $('#summernote').summernote('insertText', 'sample Text');


      // 서머노트 쓰기 비활성화
      $('#summernote').summernote('disable');

      // 서머노트 쓰기 활성화
      $('#summernote').summernote('enable');


      // 서머노트 리셋
      $('#summernote').summernote('reset');


      // 마지막으로 한 행동 취소 ( 뒤로가기 )
      $('#summernote').summernote('undo');
      // 앞으로가기
      $('#summernote').summernote('redo');
      
    });
  </script>

</head>
<body>

<header>
<jsp:include page="/menu_bar/navbar.jsp"/>
</header>


<main>
<jsp:include page="/menu_bar/leftbar.jsp"/>
<div class="content">
      <div class="board-content">

        <div class="board_list_wrap">
          <div class="board_title">
            <strong>전체이슈</strong>
          </div>


          <div class="selector">
            <label>필터</label>
            <label> 유형:
              <select class="numbers">
                <option value="1">모두</option>
                <option value="2">2</option>
              </select>
            </label>

            <label> 중요도:
              <select class="numbers">
                <option value="1">모두</option>
                <option value="2">2</option>
              </select>
            </label>

            <label> 작성자:
              <select class="numbers">
                <option value="1">모두</option>
                <option value="2">2</option>
              </select>
            </label>

            <label> 담당자:
              <select class="numbers">

                <option value="1">모두</option>
                <option value="2">2</option>

              </select>
            </label>

          </div>

          <table class="board_list">
            <tr>
              <td> 작성자</td>
              <td> 제목</td>
              <td> 작성일</td>
              <td> 조회</td>
            </tr>

            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>
            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>
            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>
            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>
            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>
            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>
            <tr>
              <td> 홍길동</td>
              <td><a class="title" href="#">글 제목이 들어갑니다.</a></td>
              <td> 2023-7-27</td>
              <td> 33</td>
            </tr>

          </table>

        </div>

        <div class="board_page">

          <a href="#" class="bt first">&lt;&lt;</a>
          <a href="#" class="bt prev">&lt;</a>
          <a href="#" class="num on">1</a>
          <a href="#" class="num">2</a>
          <a href="#" class="num">3</a>
          <a href="#" class="num">4</a>
          <a href="#" class="num">5</a>
          <a href="#" class="bt next">&gt;</a>
          <a href="#" class="bt last">&gt;&gt;</a>
          <button id="openModalBtn" class="write">
            글쓰기
          </button>
        </div>
      </div>
    </div>
</main>

<jsp:include page="/issue/create_issue.jsp"/>
<script src="../js/issue_modal.js"></script>
</body>
</html>