//글 수정 처리
package net.issue.action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.issue.db.IssueBean;
import net.issue.db.IssueDAO;

public class IssueModifyAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		IssueDAO boarddao = new IssueDAO();
		IssueBean boarddata = new IssueBean();
		ActionForward forward = new ActionForward();
		String realFolder = "";
		
		String saveFolder="boardupload";
		
		int fileSize = 5*1024*1024; //업로드할 파일의 최대 사이즈 5MB
		
		//실제 저장 경로 지정
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		boolean result = false;
		try {
			MultipartRequest multi = new MultipartRequest(
									request,
									realFolder,
									fileSize,
									"utf-8",
									new DefaultFileRenamePolicy());
			
			  int seq = Integer.parseInt(multi.getParameter("i_seq"));
			 
		/* String pass=multi.getParameter("board_pass"); */
		
		//글쓴이 인지 확인하기 위해 저장된 비밀번호와 입력한 비밀번호를 비교
		/* boolean usercheck = boarddao.isBoardWriter(num,pass); */
		
		//비밀번호 다른경우
//		if (usercheck == false) {
//			response.setContentType("text/html;charset=utf-8");
//			PrintWriter out = response.getWriter();
//			out.println("<script>");
//			out.println("alert('비밀번호가 다릅니다.');");
//			out.println("history.back();");
//			out.println("</script>");
//			out.close();
//			return null;
//		}
		
		//비밀번호가 일치하는 경우 수정 내용을 설정합니다.
		//BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.
		boarddata.setI_seq(seq); 
	
		boarddata.setI_name(multi.getParameter("i_reporter"));
	
		boarddata.setI_title(multi.getParameter("i_title"));
		boarddata.setI_content(multi.getParameter("editordata"));
		
		/*
		 * String check = multi.getParameter("check"); System.out.println("check= " +
		 * check); if(check !=null) {//파일 첨부를 변경하지 않으면 boarddata.setBoard_file(check); }
		 * else { //업로드된 파일의 시스템 상에 업로드된 시제 파일명을 얻어옵니다. String filename =
		 * multi.getFilesystemName("board_file"); boarddata.setBoard_file(filename); }
		 */
		
		//DAO에서 수정 메서드 호출하여 수정합니다.
		result = boarddao.issueModify(boarddata);
		
		//수정에 실패한 경우
		if(result == false) {
			System.out.println("게시판 수정 실패");
			forward.setRedirect(false);
			request.setAttribute("message", "게시판 수정이 되지 않았습니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		// 수정 성공의 경우
		System.out.println("게시판 수정 완료");
		
		forward.setRedirect(true);
		//수정한 글 내용을 보여주기 위해 글 내용 보기 페이지로 이동하기위해 경로를 설정합니다.
		forward.setPath("BoardDetailAction.bo?num=" + boarddata.getI_seq());
		return forward;
		
		}catch (IOException e) {
			   e.printStackTrace();
			   forward.setPath("error/error.jsp");
			   request.setAttribute("message","게시판 업로드 중 실패입니다.");
			   forward.setRedirect(false);
			   return forward;
		}
		
	}
}


