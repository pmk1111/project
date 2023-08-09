package net.issue.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.issue.db.IssueDAO;

public class IssueModalAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		IssueDAO issuedao = new IssueDAO();
		
		// 세션에 저장된 projectNum
		HttpSession session = request.getSession();
		int pnum = (int) session.getAttribute("p_num");
		
		String usrname = (String) session.getAttribute("usrName");
		System.out.println("유저 이름: " + usrname);
		session.setAttribute("usrname", usrname);
		
		// 프로젝트 명을 세션에 저장합니다.
		String pname = issuedao.getProjectName(pnum);
		session.setAttribute("pname", pname);
			
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("issue/create_issue.jsp");
		return forward;
		
	}

}
