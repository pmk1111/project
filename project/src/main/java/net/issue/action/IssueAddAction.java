package net.issue.action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.issue.db.IssueBean;
import net.issue.db.IssueDAO;

public class IssueAddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		IssueDAO issuedao = new IssueDAO();
		IssueBean issuedata = new IssueBean();
		ActionForward forward = new ActionForward();
		
		String realFolder="";
		
		//webapp아래에 꼭 폴더 생성하세요
		String saveFolder="issueupload";
		
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
			
			//BoardBean 객체에 글 등록 폼에서 입력 받은 정보들을 저장합니다.
			issuedata.setI_name(multi.getParameter("i_name"));
			//issuedata.setBoard_pass(multi.getParameter("board_pass"));
			issuedata.setI_title(multi.getParameter("i_title"));
			issuedata.setI_content(multi.getParameter("editordata"));
			
			//시스템 상에 업로드된 실제 파일명을 얻어옵니다.
		//	String filename=multi.getFilesystemName("board_file");
		//	issuedata.setBoard_file(filename);
			
			//글 등록 처리를 위해 DAO의 boardInsert()메서드를 호출합니다.
			//글 등록 폼에서 입력한 정보가 저장되어 있는 issuedata객체를 전달합니다.
			
			// 세션에있는 유저 이름
			HttpSession session = request.getSession();
			String usrname = (String) session.getAttribute("usrName");
			
			// 해당 프로젝트 넘버
			int projectNum = Integer.parseInt(request.getParameter("p_num"));
			
			
			result=issuedao.issueInsert(issuedata, usrname, projectNum);
			
			//글 등록에 실패한 경우 false 반환합니다.
			if(result==false) {
				System.out.println("게시판 등록 실패");
				forward.setPath("error/error.jsp");
				request.setAttribute("message", "게시판 등록 실패입니다.");
				forward.setRedirect(false);
				return forward;
			}
			System.out.println("게시판 등록 완료");
			
			//글 등록이 완료되면 글 목록을 보여주기 위해 "BoardList.bo"로 이동합니다.
			//Redirect여부를 true로 설정합니다.
			forward.setRedirect(true);
			forward.setPath("IssueList.bo");//이동할 경로를 지정합니다.
			return forward;
		}catch(IOException ex) {
			ex.printStackTrace();
			forward.setPath("error/error.jsp");
			request.setAttribute("message", "게시판 등록 실패입니다.");
			forward.setRedirect(false);
		}
		return forward;
	}

}
