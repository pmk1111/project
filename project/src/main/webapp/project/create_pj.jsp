<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 생성하기</title>
<jsp:include page="header.jsp" />
<link rel="stylesheet" href="css/create_pj.css">
<script src="js/createform.js"></script>
<script>

function validateStartDate() {
  const startDateInput = document.getElementById('p_start');
  
  if (!startDateInput.value) {
    alert('프로젝트 시작일을 입력하세요.');
    return false;
  }
  
  return true;
}

function validateEndDate() {
  const endDateInput = document.getElementById('p_closing');
  
  if (!endDateInput.value) {
    alert('프로젝트 종료일을 입력하세요.');
    return false;
  }
  
  return true;
}

function validateForm() {
  const projectNameInput = document.querySelector('.p_name');
  
  if (!projectNameInput.value.trim()) {
    alert('프로젝트명을 입력하세요.');
    return false;
  }
  
  if (!validateStartDate() || !validateEndDate()) {
    return false;
  }
  
  return true;
}



</script>

</head>
<body>
		<form action="ProjectAddAction.pro" method="post"
      enctype="multipart/form-data" name="projectform" onsubmit="return validateForm();">

			<div class="create_pj_content">

				<h1>프로젝트 생성하기</h1>

				<div id="pj_upload" class="pj_upload">
					<img class="pj_file" id="pj_file" name="pj_file"
						src="img/pj_file.png" alt="">
				</div>
				<!-- 기본사진 -->

				<div class="filebox bs3-primary">
					&nbsp;&nbsp; <input id="filevalue" class="upload-name" value="파일선택"
						disabled="disabled"> <label style="margin-bottom: 0px; top:-0.5px;"> 업로드 <input
						type="file" class="upload-hidden" id="upfile" name="p_file">
					</label>
					<!-- 사진업로드 -->
				</div>
				<!-- filebox -->

				<div class="edit">

					<div class="pj_name">
						<p>프로젝트명</p>
						<input type="text" class="p_name" name="p_name">
					</div>
					<!-- p_name -->

					<div class="pj_begin">
						<p>프로젝트 시작일</p>
						<input type="date" id="p_start" name="p_start" onchange="updateEndDateMin()">
					</div>
					<!-- p_start -->

					<div class="pj_end">
						<p>프로젝트 종료일</p>
						<input type="date" id="p_closing" name="p_closing">
					</div>
					<!-- p_closing -->

					<div class="pj_submit">
						<button type="submit" class="create_pj_btn">생성하기</button>
					</div>
					<!-- submit -->

				</div>
				<!-- edit -->
			</div>
			<!-- create_pj_content -->
		</form>
<script>

const today = new Date().toISOString().split('T')[0];
document.getElementById('p_start').setAttribute('min', today);
document.getElementById('p_closing').setAttribute('min', today);

function updateEndDateMin() {
  const startDateInput = document.getElementById('p_start');
  const endDateInput = document.getElementById('p_closing');

  const selectedStartDate = new Date(startDateInput.value);
  endDateInput.setAttribute('min', selectedStartDate.toISOString().split('T')[0]);
}

function selectProjectStartDate() {
  const startDate = document.querySelector("#p_start").value;
  console.log(startDate);
}


  </script>


</body>
</html>