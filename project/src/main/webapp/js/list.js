

function go(page){
	const limit = $('#viewcount').val(10);
	/*const data = 'limit = ${limit}&state=ajax&page=${page}';*/
	const data = {limit:limit, state:"ajax", page: page}
	ajax(data);
	
}


function ajax(sdata){
	console.log(sdata)
	$.ajax({
		type:"post",
		data:sdata,
        url:"IssueList.bo",
        dataType:"json",
        cache:false,
        success : function(data){
			/*$("#viewcount").val(data.limit);
		*/
			if(data.listcount >0){
				
				$("tbody").remove();
				let num = data.listcount - (data.page -1) * data.limit;
				console.log(num)
				let output = "<tbody>";
				let imgSrc = ""
				$(data.issuelist).each(
					function(index,item){

						
						let title = item.i_title;
						if(title.length>=30){
							title=title.substr(0,30)+"....";
						}
						
						let imgSrc = "";
                    	if (item.i_type === "작업") {
                        	imgSrc = "img/task.svg";
                    	} else if (item.i_type === "하위작업") {
                        	imgSrc = "img/subtasks.svg";
                    	} else if (item.i_type === "버그") {
                        	imgSrc = "img/bug.svg";
                    	}
							
						output +='<tr><td>' +item.i_name+'</td>'
						output += "<td>" +blank+img
						output += '<a href=IssueDetailAction.bo?num='+item.i_seq+'">'
             				   + title.replace(/</g,'&lt;').replace(/>/g,'&gt;')
             				   + '</a></td>';
             				   
						$('.issue_type_img').eq(index).attr('src', imgSrc);
                   	 	output += '<td><img class="issue_type_img" src="' + imgSrc + '">' + item.i_type + '</td>';
						output +='<td>'+item.i_date+'</td>'
						output += '</tr>'
					})
					output +="</tbody>"
					$('table').append(output)//table 완성
					
					$(".issue_page").empty();
					output="";
					
					let digit='&lt;'
					let href="";
					if(data.page>1){
						href = 'href=javascript:go('+(data.page -1)+')';
						
					}
					output +=setPaging(href,digit);
					
					for(let i = data.startpage; i<=data.endpage; i++){
						digit = i;
						href="";
						if(i != data.page){
							href = 'href=javascript:go('+i+')';
							
						}
					
						
					
					}
					digit ='&gt;';
					href="";
					if(data.page < data.maxpage){
						href = 'href=javascript:go('+(data.page+1)+')';
					}
					$('.issue_page').append(output)
				
			}//if
			
				
			},
			error : function(){
				
			}
			
		
		
	})//ajax end
}//function

$(function(){

	$("#viewcount").change(function(){
		go(1);
	});
	
})
