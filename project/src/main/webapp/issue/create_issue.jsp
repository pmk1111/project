<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<div id="modal_overlay"></div>
  <div id="issue_modal">
    <form method="post" action ="IssueAddAction.bo" enctype = "multipart/form-data">
      <div id="issue_content">
        <p>프로젝트<span class="req">*</span></p>
        <select id="select_project">
          <option>프로젝트1</option>
          <option>프로젝트2</option>
          <option>프로젝트3</option>
        </select>
        <!-- 생성된 프로젝트 값들이 option에 추가되어야 한다 -->
        
        <br>
        <p>유형<span class="req">*</span></p>
        <select id="select_issue_type">
          <option>버그</option>
          <option>작업</option>
          <option>하위작업</option>
        </select>
        <hr>
        <p>제목<span class="req">*</span></p><input type="text" id="issue_title" name="issue_title" maxlength="100" required><br>
        <p>내용<span class="req">*</span></p><textarea id="summernote" name="editordata"></textarea>
        <hr>
        <p>보고자<span class="req">*</span></p><input type="text" id="issue_reporter" name="issue_reporter" <%-- value="${name}" readonly --%>><br>
        <!-- 보고자는 글을 작성한 유저의 이름을 가져온다 -->
        <p>담당자<span class="req">*</span></p>
        <select id="issue_manager">
          <option>직원 1</option>
          <option>직원 2</option>
          <option>직원 4</option>
        </select><br>
        <!-- 추후 해당 프로젝트에 참여 중인 인원을 표시할 수 있게 한다 -->
        <p>상태<span class="req">*</span></p>
        <select id="issue_status">
          <option></option>
          <option>To Do</option>
          <option>In Progress</option>
          <option>Done</option>
        </select><br>
        <p>관련이슈<span class="req">*</span></p><input type="text" id="related_issue" name="related_issue" required><br>
        <!-- 추후 같은 프로젝트 내의 이슈들을 불러와 선택할 수 있게 한다 -->
        <hr>
      </div>
      <div id="issue_btn">
      <button id="issue_submit_btn" type="submit">작성하기</button>
      <button type="button" id="close_modal_btn">취소</button>
    </div>
    </form>
    <br>
  </div>
 