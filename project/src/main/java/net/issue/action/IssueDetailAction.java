package net.issue.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.issue.db.IssueBean;
import net.issue.db.IssueDAO;

public class IssueDetailAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		IssueDAO issuedao = new IssueDAO();
		IssueBean issuedata = new IssueBean();
		
		//글번호 파라미터 값을 num변수에 저장합니다.
		int num = Integer.parseInt(request.getParameter("num"));
		
		/*
		 * //내용을 확인할 글의 조회수를 증가시킵니다. boarddao.setReadCountUpdate(num);
		 */
		
		// 세션에있는 유저 이름을 request로 jsp에 넘겨줌
		HttpSession session = request.getSession();
		String usrname = (String) session.getAttribute("usrName");
		request.setAttribute("usrname", usrname);
		
		// 세션에 있는 프로젝트 명을 request로 jsp에 넘겨줌
		String projectname = (String) session.getAttribute("pname");
		request.setAttribute("pName", projectname);

		//글의 내용을 DAO에서 읽은 후 얻은 결과를 boarddata 객체에 저장합니다.
		issuedata=issuedao.getDetail(num);
		
		//boarddata=null;//error테스트를 위한 값 설정
		//DAO에서 글의 내용을 읽지 못했을 경우 null을 반환합니다.
		
		if(issuedata==null) {
			System.out.println("상세보기 실패");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message","데이터를 읽지 못했습니다.");
			forward.setPath("error/error.jsp");
			return forward;
	}
		System.out.println("상세보기 성공");
		
		//boarddata 객체를 request객체에 저장합니다.
		request.setAttribute("issuedata", issuedata);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("issue/issue_detail.jsp"); //글 내용 보기 페이지로 이동하기 위해 경로를 설정합니다.
		return forward;
		
	}
}
