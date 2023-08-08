package net.usr.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.usr.db.Usr;
import net.usr.db.UsrDAO;

public class UsrEditAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id=(String) session.getAttribute("id");
		
		UsrDAO dao = new UsrDAO();
		Usr u = dao.usr_info(id);
		
		ActionForward forward = new ActionForward();
		forward.setPath("profile/editProfile.jsp");
		forward.setRedirect(false);
		session.setAttribute("usrinfo", u);
		return forward;
	}

}
