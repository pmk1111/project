$(document).ready(function() {

	$('input[type=file]').change(function(event) {
		// 파일명 기재
		console.log($(this).val()); // C:\fakepath\upload.png
		const inputfile = $(this).val().split('\\');
		$('#filevalue').val(inputfile[inputfile.length - 1]);
		
		
		// 미리보기 사진
		const filename = inputfile[inputfile.length - 1];

		const pattern = /(gif|jpg|jpeg|png)$/i;
		
		if (pattern.test(filename)) {
			$('#pj_file').text(filename);

			const reader = new FileReader(); // 파일을 읽기 위한 객체 생성
			reader.readAsDataURL(event.target.files[0]);

			reader.onload = function() { //읽기에 성공했을 때 실행되는 이벤트 핸들러
				$('#pj_file').attr('src', this.result);
			};
		} else {
			alert('이미지 파일(gif,jpg,jpeg,png)이 아닌 경우는 무시됩니다.');
			$(this).val('')
		}
	});

});
