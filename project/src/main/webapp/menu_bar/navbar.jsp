<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>
$(document).ready(function() {
    const userIconDrop = $(".uicon-dropdown");
    const userDropItems = $(".uicon-dropdown-item");

    let isDropdownVisible = false; // Track the visibility state

    userIconDrop.on("click", function() {
        if (isDropdownVisible) {
            userDropItems.slideUp(250, function() {
                userDropItems.css("margin-right", "0px");
                isDropdownVisible = false;
            });
        } else {
            userDropItems.css("margin-right", "200px");
            userDropItems.slideDown(250, function() {
                isDropdownVisible = true;
            });
        }
    });
});

</script>


<style>
    ul {list-style-type: none;}
    li {font-size: 10px}
    a {text-decoration: none; color: #8D52A9;}
    .navbar{margin-bottom: 0px;}
  </style>

    <div class="nav_bar">
      <a href="ProjectList.pro"><img class="logo" src="img/mainlogo.svg" alt="메인 로고"></a>
      <div id="search">
       <!--  <input class="header-search" type="text" name="search" id="search" />
        <button class="header-search-btn">검색</button> -->
      </div>

      <ul class="nav_icon">
        <li><a href="#"><img class="nav_img" src="img/announce.png"></a></li>
        <li><a href="#"><img class="nav_img" src="img/alarm.png"></a></li>
        <li><a href="#"><img class="nav_img" src="img/chat.png"></a></li>
        <li>
          <div class="uicon-dropdown">
            <img class="nav_img" src="img/usericon.png">
            <div class="uicon-dropdown-item">
              <a class="uicon-dropdown-item1" id="mypage" href="usrEdit.net">마이페이지</a>
              <a class="uicon-dropdown-item2" id="logout" href="logout.net">로그아웃</a>
            </div>
          </div>
        </li>
      </ul>
    </div>
