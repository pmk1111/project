package net.usr.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.usr.db.UsrDAO;

public class UsrDeleteAction implements Action {

	@Override
	
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		UsrDAO dao=new UsrDAO();
		String pass = request.getParameter("pass");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		int result = dao.usrDelete(pass);
		if(result == 1) {
			out.println("<script>");
			out.println("alert('삭제 성공입니다.');");
			out.println("location.href='main.net'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('회원 삭제 실패입니다.');");
			out.println("history.back()");
			out.println("</script>");
		}
		out.print(result);
		return null;
	}

}
