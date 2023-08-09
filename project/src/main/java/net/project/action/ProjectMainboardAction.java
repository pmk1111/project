package net.project.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProjectMainboardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
        HttpSession session = request.getSession();
        int p_num = Integer.parseInt(request.getParameter("num"));
        System.out.println("ProjectMainboardAction p_num = " + p_num);
        session.setAttribute("p_num", p_num);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("project/mainboard.jsp");
		return forward;
	
	}

}
