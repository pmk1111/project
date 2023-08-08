<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
<link href="css/login.css" rel="stylesheet" type="text/css">
  <link href="css/home.css" rel="stylesheet" type="text/css">
    <script>
    function hrefLink() {
	    location.href = "login.net";
    }
  </script>
</head>
<body>
 <header>
    <jsp:include page="home_header.jsp" />
    </header>
    
    <main>
    <div class="home_content">
      <img class="home_img" src="img/home2.png">
      <div class="slogan">
        <h1>WidUs Software</h1>
        <br><br>
        <h2>효율적인 업무관리를 위한<br>
          최고의 솔루션</h2>
        <br><br>
        <button type="button" onclick="hrefLink()" >지금 시작하기</button>
      </div>
    </div>
  </main>
</body>
</html>