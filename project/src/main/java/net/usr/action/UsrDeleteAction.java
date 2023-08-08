package net.usr.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.usr.db.UsrDAO;

public class UsrDeleteAction implements Action {


	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		
        String id = (String) session.getAttribute("id");
       // String pass = request.getParameter("pass");
		UsrDAO dao = new UsrDAO();
		int result = dao.deleteId(id);
		
		response.setContentType("text/html;charset=utf-8");
	
	
		//삭제 성공
		if(result == 1) {
			
			session.invalidate(); // 세선 정보 삭제
			response.sendRedirect("home.net");
		} else {
			response.sendRedirect("history.back()");
		};
		return null;
	}

}
