<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>
    ul {list-style-type: none;}
    li {font-size: 10px}
    a {text-decoration: none; color: #8D52A9;}
    .navbar{margin-bottom: 0px;}
  </style>

    <div class="nav_bar">
      <a href="project_view.html"><img class="logo" src="img/logo.png" alt="메인 로고"></a>
      <div id="search">
        <input class="header-search" type="text" name="search" id="search" />
        <button class="header-search-btn">검색</button>
      </div>

      <ul class="nav_icon">
        <li><a href="#"><img class="nav_img" src="img/announce.png"></a></li>
        <li><a href="#"><img class="nav_img" src="img/alarm.png"></a></li>
        <li><a href="#"><img class="nav_img" src="img/chat.png"></a></li>
        <li>
          <div class="uicon-dropdown">
            <img class="nav_img" src="img/usericon.png">
            <div class="uicon-dropdown-item">
              <a id="mypage" name="mypage" href="#">마이페이지</a>
              <a id="logout" name="logout" href="#">로그아웃</a>
            </div>
          </div>
        </li>
      </ul>
    </div>
