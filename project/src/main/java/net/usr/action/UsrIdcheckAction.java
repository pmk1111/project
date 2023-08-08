package net.usr.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.usr.db.UsrDAO;


public class UsrIdcheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UsrDAO dao = new UsrDAO();
		int result = dao.isId(request.getParameter("id"));
		response.getWriter().print(result); //이미 response에 실어서 id를 보냈기때문에 return이 null이다
		System.out.println(result);
		return null; //액션forward x 바로 DAO호출해서 처리
	}

}