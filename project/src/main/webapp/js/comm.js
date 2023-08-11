$(document).ready(function () {
  //여기 아래 부분
  $('#summernote_comm').summernote({

    height: 100,                 // 에디터 높이
    minHeight: null,             // 최소 높이
    maxHeight: null,             // 최대 높이
    focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
    lang: "ko-KR",					// 한글 설정
    placeholder: '최대 200자까지 쓸 수 있습니다'	//placeholder 설정

  });

  // 서머노트에 text 쓰기
  // $('#summernote_comm').summernote('insertText', '');

  // 서머노트 쓰기 비활성화
  $('#summernote_comm').summernote('disable');

  // 서머노트 쓰기 활성화
  $('#summernote_comm').summernote('enable');

  // 서머노트 리셋
  $('#summernote_comm').summernote('reset');

  // 마지막으로 한 행동 취소 ( 뒤로가기 )
  $('#summernote_comm').summernote('undo');
  // 앞으로가기
  $('#summernote_comm').summernote('redo');

  //필요없는 서머노트 기능 및 디자인 제거, 변경
  $('.note-view').remove();
  $('.note-insert').remove();
  $('.note-resizebar').remove();
  $('.note-statusbar').remove();
  $('.note-editable').css('height', '100px');


});



let option=1;

function getList(state){// 현재 정렬한 정렬방식 저장 1=등록순, 2=최신순
		option = state;
		$.ajax({
			type:"post",
			url:"CommentList.bo",
			data: {"comment_i_num" : $("#comment_i_num").val(), state:state},
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
            
          if(rdata.issuelist.length>0){
             
                  output += '<li class="reply-order-item ' + red1 + '" >'
                        +  '   <a href="javascript:getList(1)" class="reply-order-button">등록순</a>'
                        +  '</li>'
                        +  '<li class="reply-order-item ' + red2 + '" >'
                        +  '   <a href="javascript:getList(2)" class="reply-order-button">최신순</a>'
                        +  '</li>';
                        
                  $('.reply-order-list').html(output);
                   
                output='';
                
               $(rdata.issuelist).each(function(){
                  
                  const lev = this.comment_re_lev;
                  let comment_reply='';
                  if(lev==1){
                     comment_reply = ' reply-list-item--reply lev1';
                  } else if (lev==2) {
                     comment_reply = ' reply-list-itme--reply lev2';
                  }
                  
                  const profile = this.pic;
					 let src = 'img/profile3.png';
					 if(profile){
						 src='usrupload/' + profile;
						 
					 }
					 
					 
					 
				 //게시글 작성 시간 구하기
  				const createdAt = new Date(this.reg_date);
  				function displayedAt(createdAt) {
    				const milliSeconds = new Date() - createdAt
    				const seconds = milliSeconds / 1000
    				if (seconds < 60) return `방금 전`
    				const minutes = seconds / 60
    				if (minutes < 60) return `${Math.floor(minutes)}분 전`
    				const hours = minutes / 60
    				if (hours < 24) return `${Math.floor(hours)}시간 전`
    				const days = hours / 24
    				if (days < 7) return `${Math.floor(days)}일 전`
    				const weeks = days / 7
    				if (weeks < 5) return `${Math.floor(weeks)}주 전`
    				const months = days / 30
    				if (months < 12) return `${Math.floor(months)}개월 전`
    				const years = days / 365
    				return `${Math.floor(years)}년 전`
  				}
  				const timeAgo = displayedAt(createdAt);
  				console.log(timeAgo);
  				//$('.re-create').text(timeAgo);
					 
					 
					 
					 
					 
                  
                  output += '<li id="' + this.c_num + '" class="reply-list-item' + comment_reply + '">'
                        + '   <div class="reply-nick-area">'
                        + '    <img class="usr_img" src="' + src +'" alt="프로필 사진" width="36" height="36">'
                        + '    <div class="reply-box">'
                        + '      <div class="reply-nick-box">'
                        + '            <div class="reply-nick-info">'
                        + '               <div class="reply-nickname">' + this.c_id + '<span class="reply-info-date">' + timeAgo + '</span></div>'
                        + '            </div>' //comment-nick-info                  
                        + '       </div>'  // comment-nick-box
                        + '    </div>'   //comment-box
                        + '    <div class="reply-text-box">'
                        + '       <p class="reply-text-view">'
                        + '         <span class="text-comment">' + this.c_content + '</span>'
                        + '       </p>'
                        + '    </div>' //comment-text-box
                        + '    <div class="reply-info-box">';
                  
                  // 원문글에서 2레벨까지만 답글쓰기가 가능함.
                  if(lev<2){
                          output += '  <a href="javascript:replyform(' + this.c_num +',' 
                                 + lev + ',' + this.comment_re_seq +',' 
                                 + this.comment_re_ref +')"  class="reply-info-button">답글쓰기&nbsp;&nbsp</a>'
                        }
                  output += '   </div>' //comment-info-box;
                  
                  // 글쓴사람에게만 수정과 삭제 권한을 줌. // 어드민을 제외해두었으니 필요하면 추가      
                   if($("#loginid").val()==this.c_id){  
                   output +=  '<div class="comment-tool">'
                        + '    <div title="더보기" class="reply-tool-button">' 
                        + '    </div>'
                        + '    <div id="reply-list-item-layer' +  this.c_num + '"  class="LayerMore">' //스타일에서 display:none; 설정함
                  
                        + '       <a href="javascript:updateForm(' + this.c_num + ')"'
                        + '          class="layer-button">수정</a>&nbsp;&nbsp;'
                        + '       <a href="javascript:del(' + this.c_num + ')"'
                        + '          class="layer-button">삭제</a>'
                        + '    </div>'//LayerMore
                        + '   </div>'//comment-tool
                    }
                        
                  output += '</div>'// comment-nick-area
                        + '</li>'// li.comment-list-item
               })//each end
               
                $('.reply-list').html(output);
          }//if(rdata.boardlist.length>0)
          
          else{ 
             
             //댓글 1개가 있는 상태에서 삭제하는 경우 갯수는 0이라  if문을 수행하지 않고 이곳으로 옵니다.
             //이곳에서 아래의 두 영역을 없앱니다.
             $('.reply-list').empty();
             $('.reply-order-list').empty();
             
          }
         }//success end
      });//ajax end
   }//function(getList) end
   
   
//더보기-수정 클릭한 경우에 수정 폼을 보여줍니다.
function updateForm(c_num){ //num : 수정할 댓글 글번호

    //수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
   $(".comment-tool").hide();
   
   //수정 삭제 영역도 숨겨요
   $(".LayerMore").hide(); // 수정 삭제 영역도 숨겨요
   
   let $c_num = $('#'+c_num);
   
   //선택한 내용을 구합니다.
   const content = $c_num.find('.text-comment').text();
   
   const selector = '#'+c_num + '> .comment-nick-area'
   //selector 영역 숨겨요-수정에서 취소를 선택하면 보여줄 예정입니다.
   $(selector).hide();
   
   //$('.comment-list+.comment-write').clone() : 기본 글쓰기 영역 복사합니다.
   //글이 있던 영역에 글을 수정할 수 있는 폼으로 바꿉니다.
   $c_num.append($('.comment-list+.comment-write').clone());
   
   
   //수정 폼의 <textarea>에 내용을 나타냅니다.
   $c_num.find('textarea').val(content);
   
   //'.btn-register' 영역에 수정할 글 번호를 속성 'data-id'에 나타내고 클래스 'update'를 추가합니다.
   $c_num.find('.re_submit').attr('data-id', c_num).addClass('update').text('수정완료');
   
   //폼에서 취소를 사용할 수 있도록 보이게 합니다.
   $c_num.find('.re_cancel').css('display', 'block');
   
   const count=content.length;
   $c_num.find('.comment-write-area-count').text(count+"/200");
   
}//function(updateForm) end

   
   
//더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(c_num){//num : 댓글 번호
     if(!confirm('정말 삭제하시겠습니까')){
        $('#comment-list-item-layer' + c_num).hide(); //'수정 삭제' 영역 숨겨요
        return;
     }
        
        $.ajax({
           url:'CommentDelete.bo',
           data:{c_num:c_num},
            success:function(rdata){
               if(rdata==1){
            getList(option);   
            }
               
            }
        })
}//function(del) end


//답글 달기 폼
function replyform(c_num,lev,seq,ref){
   //수정 삭제 영역 선택 후 답글쓰기를 클릭한 경우
   $(".LayerMore").hide(); //수정 삭제 영역 숨겨요
   
   let output = '<li class="comment-list-item comment-list-item--reply lev'  +  lev + '"></li>' 
   const $c_num =    $('#'+c_num);            
   //선택한 글 뒤에 답글 폼을 추가합니다.
   $c_num.after(output);
   
   //글쓰기 영역 복사합니다.
   output=$('.comment-list+.comment-write').clone();
   
   const $c_num_next = $c_num.next();
   //선택한 글 뒤에 답글 폼 생성합니다.
   $c_num_next.html(output);
   
   //답글 폼의  <textarea>의 속성 'placeholder'를 '답글을 남겨보세요'로 바꾸어 줍니다.
   $c_num_next.find('textarea').attr('placeholder', '답글을 남겨보세요');
   
   //답글 폼의  '.btn-cancel'을 보여주고 클래스 'reply-cancel'를 추가합니다.
   $c_num_next.find('.re_cancel').css('display', 'block').addClass('reply-cancel');
   
   //답글 폼의 '.btn-register'에  클래스 'reply' 추가합니다.
   //속성 'data-ref'에 ref, 'data-lev'에 lev, 'data-seq'에 seq값을 설정합니다.
   //등록을 답글 완료로 변경합니다.
   $c_num_next.find('.re_submit').addClass('reply')
               .attr('data-ref', ref).attr('data-lev', lev).attr('data-seq', seq).text('답글완료');

}//function(replyform) end

// 시작
$(function() {
   getList(option);  //처음 로드 될때는 등록순 정렬
   
   $('form[name="deleteForm"]').submit(function() {
      if ($("#board_pass").val() == '') {
         alert("비밀번호를 입력하세요");
         $("#board_pass").focus();
         return false;
      }
   })// form
   
   $('.reply_textarea').on('keyup','.comment-write-area-text', function() {
      const length=$(this).val().length;
      $(this).prev().text(length+'/200');
   });// keyup','.comment-write-area-text', function() {
   
   //댓글 등록을 클릭하면 데이터베이스에 저장 -> 저장 성공 후에 리스트 불러옵니다.
   //상속 영역 수정
   $('.re_sub_cancel .re_submit').click(function() {
      const content=$('div.note-editable').html();
      console.log(content)
      if(!content){//내용없이 등록 클릭한 경우
         alert("댓글을 입력하세요");
         return;
      }
      
     $.ajax({
		url : 'CommentAdd.bo',
		data : {
			id : $("#loginid").val(),
			content : content,
			comment_i_num : $("#comment_i_num").val()
		},
		type:'post',
		success : function(rdata){
			if(rdata ==1){
				getList(option);
			}
		}
	})//ajax end
      
    $('div.note-editable').text(''); //textarea 초기화
	$('.reply-write-area-count').text('0/200'); //입력한 글 카운트 초기화
      
   })// $('.btn-register').click(function(){
   
   
   //더보기를 클릭한 경우
   $(".comment-list").on('click', '.comment-tool-button', function() {              
   //더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라져요
      $(this).next().toggle();
      
      //클릭 한 곳만 수정 삭제 영역이 나타나도록 합니다.
      $(".comment-tool-button").not(this).next().hide(); 
   })
   
   //수정 후 수정완료를 클릭한 경우
   $('.reply_textarea').on('click','.update',function(){
      const content = $(this).parent().parent().find('textarea').val();
      if(!content){//내용없이 등록 클릭한 경우
         alert("수정할 글을 입력하세요");
         return;
      }   
      
      const c_num = $(this).attr('data-id');
      
      $.ajax({
         url:'CommentUpdate.bo',
         data:{ c_num:c_num, content:content },
         success:function(rdata){
            if(rdata==1){
               getList(option);
            }//if
         }//success
      });//ajax
   })//수정 후 수정완료를 클릭한 경우
   
   
   //수정 후 취소 버튼을 클릭한 경우
   $('.reply_textarea').on('click','.re_cancel',function(){
      
      //댓글 번호를 구합니다.
      const c_num = $(this).next().attr('data-id');
      const selector='#' +c_num;  
      
      //.comment-write 영역 삭제 합니다.
      $(selector + ' .comment-write').remove();
      
      //숨겨두었던 .comment-nick-area 영역 보여줍니다.
      $(selector + '>.comment-nick-area').css('display','block');   
            
      
      //수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겼는데 취소를 선택하면 보여주도록 합니다.
       $(".comment-tool").show();
   })//수정 후 취소 버튼을 클릭한 경우
   
   
   
   //답글완료 클릭한 경우
   $('.reply_textarea').on('click','.reply',function(){
      
      const content=$(this).parent().parent().find('.comment-write-area-text').val();
      if(!content){//내용없이 답글완료 클릭한 경우
         alert("답글을 입력하세요");
         return;
      }   
         
      const comment_re_ref = $(this).attr('data-ref');
      const lev = $(this).attr('data-lev');
      const seq = $(this).attr('data-seq');
      
      $.ajax({
         url : 'CommentReply.bo',  
         data : {
            id : $("#loginid").val(),
            content : content,
            comment_board_num : $("#comment_board_num").val(), 
            comment_re_lev : lev,
            comment_re_ref : comment_re_ref,
            comment_re_seq : seq
         },
         type : 'post',
         success : function(rdata) {
            if (rdata == 1) {
               getList(option);
            }
         }
      })//ajax
      
   })//답글완료 클릭한 경우
   
   
   //답글쓰기 후 취소 버튼을 클릭한 경우
   $('.reply_textarea').on('click','.reply-cancel',function(){
      $(this).parent().parent().parent().remove();
      $(".comment-tool").show(); //더 보기 영역 보이도록 합니다.
   })//답글쓰기  후 취소 버튼을 클릭한 경우
   
   
   
   //답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
   $('.reply_textarea').on('click','.comment-info-button',function(event){
      //답변쓰기 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
      $(".comment-tool").hide();
      
      //답글쓰기 폼의 갯수를 구합니다.
      const length=$(".reply_textarea .re_submit.reply").length
      
      if(length==1){  //답글쓰기 폼이 한 개가 존재하면 anchor 태그(<a>)의 기본 이벤트를 막아 
                      //또 다른 답글쓰기 폼이 나타나지 않도록 합니다.
         event.preventDefault();         
      }
   })//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
})//ready