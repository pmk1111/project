let option=1;

function getList(state){// 현재 정렬한 정렬방식 저장 1=등록순, 2=최신순
		option = state;
		$.ajax({
			type:"post",
			url:"CommentList.bo",
			data: {"comment_issue_num" : $("#comment_issue_num").val(), state:state},
			dataType:"Json",
			success:function(rdata){
				let red1 = 'red';
				let red2 = 'red';
				if(state==1){
					red2='gray'
				}else if(state==2){
					red1 = 'gray';
				}
				
				let output = "";
				
			if(rdata.issuelist.length>0){ //commentlist je에서 가져온 issuelist
				output +='<li class="reply-order-item ' + red1 + '" >'
				       +'  <a href="javascript:getList(1)" class="reply-order-button">등록순 </a>'
				       +' </li>'
				       +' <li class="reply-order-item ' + red2 + '" >'
				       +'  <a href="javascript:getList(2)" class="reply-order-button">최신순 </a>'
				       +' </li>'
				 $('.reply-order-list').html(output);
				 
				 output='';
				 $(rdata.issuelist).each(function(){
					 const lev = this.comment_re_lev;
					 let comment_reply='';
					 if(lev==1){
						 comment_reply=' reply-list-item--reply lev1';
						 
					 }else if(lev==2){
						 comment_reply=' reply-list-item--reply lev2';
					 }
					 const profile = this.usrflie;
					 let src = 'image/profile3.png';
					 if(profile){
						 src='usrupload/' + profile;
						 
					 }
					 
					 output += '<li id="' + this.num + '" class="reply-list-item' + comment_reply + '">'
							 + ' <div class="reply-nick-area">'
							 + ' <img src="' + src +'" alt="프로필 사진" width="36" height="36">'
							 + ' <div class="reply-box">'
							 + ' <div class="reply-nick-box">'
							 + ' <div class="reply-nick-info">'
							 + ' <div class="reply-nickname">' + this.id + '</div>'
							 + ' </div>' //reply-nick-info
							 + ' </div>' // reply-nick-box
							 + ' </div>' //reply-box
							 + ' <div class="reply-text-box">'
							 + ' <p class="reply-text-view">'
							 + ' <span class="text-comment">' + this.content + '</span>'
							 + ' </p>'
							 + ' </div>' //reply-text-box
							 + ' <div class="reply-info-box">'
							 + ' <span class="reply-info-date">' + this.reg_date + '</span>';
						if(lev<2){
						 	 output += ' <a href="javascript:replyform(' + this.num +','
						 	 + lev + ',' + this.comment_re_seq +','
						 	 + this.comment_re_ref +')" class="reply-info-button">답글쓰기</a>'
						 }
						output += ' </div>' //comment-info-box;
							
					 if($("#loginid").val()==this.id){
						 output += '<div class="comment-tool">'
							 + ' <div title="더보기" class="reply-tool-button">'
							 + ' <div>&#46;&#46;&#46;</div>'
							 + ' </div>'
							 + ' <div id="reply-list-item-layer' + this.num + '" class="LayerMore">' //스타일에서 display:none; 설정함
							 + ' <ul class="layer-list">'							
							 + ' <li class="layer-item">'
							 + ' <a href="javascript:updateForm(' + this.num + ')"'
							 + ' class="layer-button">수정</a>&nbsp;&nbsp;'
							 + ' <a href="javascript:del(' + this.num + ')"'
							 + ' class="layer-button">삭제</a></li></ul>'
							 + ' </div>'//LayerMore
							 + ' </div>'//comment-tool
					 }
							
						output += '</div>'// comment-nick-area
							 + '</li>'//li.comment-list-item
					})//each end

				$('.reply-list').html(output);
				 }//if end
			else{
				$('.reply-list').empty();
				$('.reply-order-list').empty();
			}	       
			}//success end
		});//ajax end
	}//function(getList) end

$(function(){
	
	//댓글 글자수 확인
	$('.reply-area').on('keyup','#summernote_comm',function(){
		const length = $(this).val().length;
		$(this).prev().text(length+'/200');
	})//.reply-area end
	
	//댓글 등록
	$('ul+.reply-write .re_submit').click(function(){
		const content=$('#summernote_comm').val();
		if(!content){//내용없이 등록 클릭시
			alert("댓글을 입력하세요");
			return;
	}
	
	$.ajax({
		url : 'CommentAdd.bo',
		data : {
			id : $("#loginid").val(),
			content : content,
			reply_issue_num : $("#reply_issue_num").val()
		},
		type:'post',
		success : function(rdata){
			if(rdata ==1){
				getList(option);
			}
		}
	})//ajax end
	
	$('.reply-write-area-text').val(''); //textarea 초기화
	$('.reply-write-area-count').text('0/200'); //입력한 글 카운트 초기화
	
	})//댓글등록 function end
	
})