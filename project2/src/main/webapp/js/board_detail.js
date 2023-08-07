$(document).ready(function () {
  //여기 아래 부분
  $('#summernote_comm').summernote({

    height: 100,                 // 에디터 높이
    minHeight: null,             // 최소 높이
    maxHeight: null,             // 최대 높이
    focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
    lang: "ko-KR",					// 한글 설정
    placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정

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

  //게시글 작성 시간 구하기
  const createdAt = new Date('2023-07-29T12:00:00');
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
  $('.re-create').text(timeAgo);
});