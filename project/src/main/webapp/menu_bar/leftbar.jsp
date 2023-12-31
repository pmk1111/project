<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

	<div class="left-bar">
		<h3 class="project_name">
			<c:if test="${pname.length()>=11 }">
				<c:out value="${pname.substring(0,11) }..." />
			</c:if>
			<c:if test="${pname.length()<11 }">
				<c:out value="${pname}" />
		</c:if>
		</h3>
      
      <h5>프로젝트</h5>
      <div class="left-bar-items">
          <img id="create_pj" class="left-menu-icon" src="img/clipboard.svg">
          <label for="create_pj"><a href="ProjectCreate.pro">프로젝트 생성하기</a></label>
      </div>
      <div class="left-bar-items">
          <img id="pj_all" class="left-menu-icon" src="img/notebook.svg">
          <label for="pj_all"><a href="ProjectList.pro">내 프로젝트</a></label>
      </div>
      <div class="left-bar-items">
          <img id="issue_all" class="left-menu-icon" src="img/news.svg">
          <label for="issue_all"><a href="IssueList.bo?num=${p_num }">전체 이슈</a></label>
      </div>


      <h5>일정</h5>
      <div class="left-bar-items">
          <img id="main_board" class="left-menu-icon" src="img/new.svg">
          <label for="main_board"><a href="ProjectMainboard.pro?num=${p_num }">메인보드</a></label>
      </div>
      
      <div class="left-bar-items">
          <img id="pj_status" class="left-menu-icon" src="img/stats.svg">
          <label for="pj_status">프로젝트 현황</label>
      </div>
      <div class="left-bar-items">
          <img id="calendar" class="left-menu-icon" src="img/calendar.svg">
          <label for="calendar">캘린더</label>
      </div>

      <h5>코드</h5>

      <div class="left-bar-items">
          <img id="code" class="left-menu-icon" src="img/code-alt.svg">
          <label for="code">코드</label>
      </div>

      <div class="left-menu-line"></div>


	  <h5>추가 기능</h5>
	  
      <div class="left-bar-items">
          <img id="fav_page" class="left-menu-icon" src="img/Star.svg">
          <label for="fav_page">즐겨찾는 페이지</label>
      </div>
      <div class="left-bar-items">
          <img id="pj_setting" class="left-menu-icon" src="img/settings.svg">
          <label for="pj_setting"><a href="ProjectModifyView.pro?num=${p_num }">프로젝트 설정</a></label>
      </div>
      
      <div class = "left-bar-items">
      	<img id = "pj_setting" class= "left-menu-icon" src = "img/people.svg">
      	<label for="pj_member"><a href = "MemberList.mem?num=${p_num }">프로젝트 멤버</a></label>
      </div>  
      
      <div class="left-bar-items">
          <img id="add_team" class="left-menu-icon" src="img/person-add.svg">
          <label for="add_team"><a href = "MemberInvite.mem?num=${p_num }">팀원 초대하기</a></label>
      </div>
      <br><br>
    </div>