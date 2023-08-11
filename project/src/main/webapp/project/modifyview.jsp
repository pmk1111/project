<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 수정</title>
<jsp:include page ="header.jsp"/>
<link rel="stylesheet" href="css/create_pj.css">

<script src="js/createform.js"></script>
<script>
 const urlSearchParams = new URLSearchParams(window.location.search);
  const p_num = urlSearchParams.get('num');
  </script>
<script>
  function modifyProject() {
    document.projectform.action = "ProjectModifyAction.pro";
    document.projectform.submit();
  }

  function deleteProject() {
    if (confirm("정말 프로젝트를 삭제하시겠습니까?")) {
      location.href="ProjectDeleteAction.pro?p_num=${projectdata.p_num }"
    }
  }
</script>

</head>
<body>

<form action="ProjectModifyAction.pro" method="post" enctype="multipart/form-data" name="projectform">
	<input type="hidden" id="p_num" name="p_num" value="${projectdata.p_num }"/>
 	<main>
    	<div class="create_pj_content">
    	
      		<h1>프로젝트 수정</h1>
      
      		<div id="pj_upload" class="pj_upload">
        		<img class="pj_file" id="pj_file" name="pj_file" src="${projectdata.p2_file}" alt="">
      		</div> 

      		<div class="filebox bs3-primary">
        		&nbsp;&nbsp; 
        		<input id="filevalue" class="upload-name" value="파일선택" disabled="disabled">
        
        		<label>
        			업로드
        			<input type="file" class="upload-hidden" id="upfile" name="p_file">
        			<input type="hidden" name="check" value="${projectdata.p_file}">
        		</label> 
      		</div> 

      		<div class="edit">
      
        		<div class="pj_name">
          			<p>프로젝트명</p>
          			<input type="text" class="p_name" name="p_name" value="${projectdata.p_name}">
        		</div> 
        
       			<div class="pj_begin">
          			<p>프로젝트 시작일</p>
          			<input type="date" id="p_start" name="p_start" value="${projectdata.p_start}">
        		</div> 
        
        		<div class="pj_end">
          			<p>프로젝트 종료일</p>
          			<input type="date" id="p_closing" name="p_closing" value="${projectdata.p_closing}">
        		</div>
        
        		<div class="pj_submit">
          			<button type="submit" class="create_pj_btn" onclick="modifyProject();">수정하기</button>
        		</div> 
        		
        		<div class="pj_submit">
          			<button type="button" class="delete_pj_btn" onclick="deleteProject();">삭제하기</button>
        		</div> 
        		
    		</div> 
  		</div> 
 	</main>
</form>
</body>
</html>
