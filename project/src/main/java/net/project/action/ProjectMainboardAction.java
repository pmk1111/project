package net.project.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.issue.db.IssueBean;
import net.issue.db.IssueDAO;

public class ProjectMainboardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		IssueDAO issuedao =new IssueDAO();
		//1번: 메인보드에서 전체 이슈 요약
		List<IssueBean> issuelist1 = new ArrayList<IssueBean>();

		List<IssueBean> issuelist2= new ArrayList<IssueBean>();
		List<IssueBean> issuelist3 = new ArrayList<IssueBean>();
		List<IssueBean> issuelist4 = new ArrayList<IssueBean>();

		HttpSession session = request.getSession();
		//요청으로부터 프로젝트 넘버를 가져온 후 세션에 저장
		int p_num = Integer.parseInt(request.getParameter("num"));
		session.setAttribute("p_num", p_num);
		System.out.println("ProjectMainboardAction p_num = " + p_num);

		//저장한 프로젝트 넘버를 가져온다
		int pnum = (int) session.getAttribute("p_num");

		//세션을 통해 유저아이디를 가져온다
		String id = (String) session.getAttribute("id");
		System.out.println("유저 아이디: " + id);
		session.setAttribute("id", id);

		//세션을 통해 유저명을 가져온다
		String usrname = (String) session.getAttribute("usrName");
		System.out.println("유저 이름: " + usrname);
		session.setAttribute("usrname", usrname);

		//모든 이슈를 가져오는 작업
		issuelist1 = issuedao.getMainboardList(pnum);

		//본인이 담당자인 이슈를 status 별로 가져온다.
		issuelist2 = issuedao.getToDoList(id, usrname, pnum);
		issuelist3 = issuedao.getInProgressList(id, usrname, pnum);
		issuelist4 = issuedao.getDoneList(id, usrname, pnum);


		request.setAttribute("issuelist1",issuelist1);
		request.setAttribute("issuelist2",issuelist2);
		request.setAttribute("issuelist3",issuelist3);
		request.setAttribute("issuelist4",issuelist4);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("project/mainboard.jsp");
		return forward;

	}

}
