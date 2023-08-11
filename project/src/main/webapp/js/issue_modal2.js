$(document).ready(function () {
	
	  $('#summernote').summernote({
    height: 300,
    minHeight: null,
    maxHeight: null,
    focus: true,
    lang: "ko-KR",
    placeholder: '최대 2048자까지 쓸 수 있습니다'
  });
	
  $('#summernote').summernote();
  $('#summernote').summernote('codeview.set', '${issuedata.i_content}');

let isModalOpen = false; // Flag to track if the modal is open
	
  function resetModalScrollPosition() {
    const modal = $("#issue_modal");
    modal.find(".modal-content").scrollTop(0);
  }

  function showModal() {
    if (!isModalOpen) {
      const modal = $("#issue_modal");
      const modalOverlay = $("#modal_overlay");
      modal.css("display", "block");
      modalOverlay.css("display", "block");
      window.scrollTo(0, 0); // Scroll the page to the top
      isModalOpen = true; // Set the flag to true since the modal is open
    }
  }

  function hideModal() {
    const modal = $("#issue_modal");
    const modalOverlay = $("#modal_overlay");
    modal.css("display", "none");
    modalOverlay.css("display", "none");
    isModalOpen = false; // Set the flag to false since the modal is closed
  }

  const openModalBtn = $("#openModalBtn");
  openModalBtn.on("click", showModal);

  const closeModalBtn = $("#close_modal_btn");
  closeModalBtn.on("click", hideModal);

  const modalOverlay = $("#modal_overlay");
  modalOverlay.on("click", hideModal);

  const modal = $("#issue_modal");
  modal.on("click", function (event) {
    event.stopPropagation();
  });

  // Add event listeners for Bootstrap modal events
  modal.on("hidden.bs.modal", function () {
    resetModalScrollPosition();
  });

  modal.on("show.bs.modal", function () {
    isModalOpen = true;
  });

});