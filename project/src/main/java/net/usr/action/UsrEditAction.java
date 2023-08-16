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
		
		// 세션에있는 프로젝트 num, id 삭제
		session.removeAttribute("pname"); 
		session.removeAttribute("p_num"); 
		
		ActionForward forward = new ActionForward();
		forward.setPath("profile/editProfile.jsp");
		forward.setRedirect(false);
		session.setAttribute("usrinfo", u);
		return forward;
	}

}
