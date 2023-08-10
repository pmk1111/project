

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
				$(data.issuedlist).each(
					function(index,item){

						
						let title = item.i_title;
						if(title.length>=20){
							title=title.substr(0,20)+"....";
						}
						
						output +='<tr><td>' +item.i_name+'</td>'
						output += "<td>" +blank+img
						output += '<a href=IssueDetailAction.bo?num='+item.i_seq+'">'
             				   + title.replace(/</g,'&lt;').replace(/>/g,'&gt;')
             				   + '</a></td>';
						  		
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

//총 2페이지 페이징 처리된 경우
//이전 1 2 다음
//현재 페이지가 1페이지인 경우 아래와 같은 페이징 코드가 필요
//<li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
//<li class="page-item active"><a class="page-link">1</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(2)">2</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(2)">다음&nbsp;</a></li>

//현재 페이지가 2페이지인 경우 아래와 같은 페이징 코드가 필요
//<li class="page-item"><a class="page-link" href="javascript:go(1)">이전&nbsp;</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(1)">1</a></li>
//<li class="page-item active"><a class="page-link">2</a></li>
//<li class="page-item"><a class="page-link gray">다음&nbsp;</a></li>