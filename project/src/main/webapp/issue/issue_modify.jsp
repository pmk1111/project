<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <div id="modal_overlay"></div>
  <div id="issue_modal">
    <form action="IssueModifyAction.bo" method="post" enctype="multipart/form-data">
             	 <input type="hidden" name="i_seq" value="${issuedata.i_seq}">
      <div id="issue_content">
        <p>프로젝트<span class="req">*</span></p>
        <select id="select_project">
          <option>프로젝트1</option>
          <option>프로젝트2</option>
          <option>프로젝트3</option>
        </select>
        <br>
        <p>유형<span class="req">*</span></p>
         <select name="i_type" id="select_issue_type">
          <option>버그</option>
          <option>작업</option>
          <option>하위작업</option>
        </select>
        <hr>
        <p>제목<span class="req">*</span></p><input type="text" id="issue_title" name="issue_title" value="${issuedata.i_title}"  required><br>
        
        <p>내용<span class="req">*</span></p>
        <textarea id="summernote" name="i_content">${issuedata.i_content}</textarea>
        
        <hr>
        <p>보고자<span class="req">*</span></p><input type="text" id="issue_reporter" name="issue_reporter" value="${issuedata.i_name}" readOnly><br>
        <p>담당자<span class="req">*</span></p>
     <!-- 빡쌔요 -->
    <!--    <select id="issue_manager" name="i_assign">
          <option>직원 1</option>
          <option>직원 2</option>
          <option>직원 4</option>
        </select> -->
        <input type="text" id="issue_manager" name="i_assign" value="${issuedata.i_name}" readonly>
        <!-- 담당자는 현재 프로젝트에 참여한 인원을 표시한다(최종) / 일단은 보고자로 세팅-->
        <br>
        <p>상태<span class="req">*</span></p>
        <select name = "i_status" id="issue_status">
          <option selected>${issuedata.i_status}</option>
          <option>To Do</option>
          <option>In Progress</option>
          <option>Done</option>
        </select><br>
        <p>관련이슈<span class="req">*</span></p><input type="text" id="related_issue" name="related_issue" required><br>
        <hr>
      </div>
      <button id="issue_submit_btn" type="submit">작성하기</button>
      <button id="close_modal_btn">취소</button>
    </form>
    <br>
  </div>
</body>
</html>