function go(page){
	const limit = $('#viewcount').val(5);
	/*const data = 'limit = ${limit}&state=ajax&page=${page}';*/
	const data = {limit:limit, state:"ajax", page: page}
	ajax(data);
	
}

function ajax(sdata){
	console.log(sdata)
	
	$.ajax({
		type : "POST",
		data : sdata,
		url : "ProjectMainboard.pro",
		dataType : "json",
		cache : false,
		success : function(data){
			
			if(data.listcount >0){
				
				$("tbody").remove();
				let num = data.listcount - (data.page -1) * data.limit;
				console.log(num)
				let output = "<tbody>";
				$(data.issuelist).each(
					function(index,item){

						
						let title = item.i_title;
						if(title.length>=10){
							title=title.substr(0,10)+"....";
						}
						
						output +='<tr><td>'
						output += '<a href=IssueDetailAction.bo?num='+item.i_seq+'">'
             				   + title.replace(/</g,'&lt;').replace(/>/g,'&gt;')
             				   + '</a></td></tr>';

					})
					output +="</tbody>"
					$('.progress_item').append(output)//table 완성
				
			}//if
		}, //success end
		error : function(){
			
		}
	}) // ajax end
} // function end

/*$(function(){
	
	$("#viewcount").change(function(){
		go(1);
	});
	
})*/