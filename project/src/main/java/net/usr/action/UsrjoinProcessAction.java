package net.usr.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.usr.db.Usr;
import net.usr.db.UsrDAO;

public class UsrjoinProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String pass =request.getParameter("pass");
		String email =request.getParameter("email");
		String name =request.getParameter("name");
		String pic =request.getParameter("pic");
		String tel =request.getParameter("tel");
		String status =request.getParameter("status");
		 
	
		Usr u = new Usr ();
		u.setEmail(email);	u.setPic(pic);
		u.setId(id);	u.setName(name);	u.setPass(pass);
		u.setStatus(status); u.setTel(tel);
		
		UsrDAO udao= new UsrDAO();
		
		int result=udao.insert(u);
		
		//result=0;
		if(result==0) {
			System.out.println("회원 가입 실패입니다.");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message",  "회원 가입 실패입니다");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		if(result == 1) {
			out.println("alert('회원 가입을 축하합니다.');");
			out.println("location.href='login.net';");
		}
		out.println("</script>");
		out.close();
		return null;
	}

}