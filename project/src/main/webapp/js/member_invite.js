$(document).ready(function() {

		$(".SearchedMemberInfo tr").hide(); // 초기 테이블 셀 값을 숨긴다 

		$("input[name='user_ID']").on("keyup", function() {
			const searchValue = $(this).val().toLowerCase();

			// 다시 검색 값이 없을 경우, 테이블 셀을 숨긴다
			if (!searchValue) {
				$(".SearchedMemberInfo tr").hide();
				return;
			}

			// 검색 내용과 관련있는 table 셀 값을 보여준다
			$(".SearchedMemberInfo tr").each(function() {
				const rowText = $(this).text().toLowerCase();

				if (rowText.indexOf(searchValue) > -1) {
					$(this).show();
				} else {
					$(this).hide();
				}
			});
		});

		$(".SearchedMemberInfo td a").on("click", function(e) {
			e.preventDefault();

			const selectedUserId = $(this).text();
			$("input[name='user_ID']").val(selectedUserId);

			$(".SearchedMemberInfo tr").hide(); //user id를 선택하면 다시 테이블 값을 숨긴다
		});
		
		//사원 번호 표시 방식 설정
		$(".employeeNum").each(function() {
			const userNum = $(this).text();
			const formattedNum = userNum.padStart(6, '0');
			$(this).text('@' + formattedNum);
		});

		$("form").on("submit", function(e) {
			let isValid = true;

			if (!$("input[name='user_ID']").val()) {
				alert("유저 ID를 입력하세요");
				isValid = false;
			}

			if (!isValid) {
				e.preventDefault();
			}
		});
	});