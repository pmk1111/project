function ajax(sdata){
	console.log(sdata)
	
	$.ajax({
		type : "POST",
		data : sdata,
		url : "BoardList.bo",
		dataType : "json",
		cache : false,
		success : function(data){
			$('viewcount').val(data.limit);
			$("thead").find("span").text("글 개수 : " + data.listcount);
			
			if(data.listcount > 0){ // 글 개수가 0보다 클 경우
				$("tbody").remove(); // 기존의 tbody 내용을 다 지워버린다
				let num = data.listcount - (data.page - 1) * data.limit;
				console.log(num)
				let output = "<tbody>";
				$(data.boardlist).each(
					function(index, item){
						output += '<tr><td>' + (num--) + '</td>'
						const blank_count = item.board_re_lev *2 + 1;
						let blank = '&nbsp';
						for(let i=0;i<blank_count;i++){
							blank += '&nbsp;&nbsp;';
						}
						
						let img = "";
						if(item.board_re_lev > 0){
							img = "<img src='image/line.gif'>";
						}
						
						let subject = item.board_subject;
						if(subject.length>=20){
							subject = subject.substr(0,20) + "...";
						}
						output += '<td>' + item.board_name + '</td>'
						output += "<td>" + blank + img
						output += '<a href="BoardDetailAction.bo?num=' + item.board_num + '">'
						output += subject.replace(/</g, '&lt;').replace(/>/g, '&gt;')
								+ '</td>'
						output += '<td><' + item.board_date + '</td>'
						output += '<td>' + item.board_readcount + '</td></tr>'
					})
					output += "</tbody>"
					$('.brief').append(output) // table 완성
					
					
			} // if(data.listcount)>0 end
		}, //success end
		error : function(){
			
		}
	}) // ajax end
} // function end