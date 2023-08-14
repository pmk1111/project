package net.comment.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.comment.db.Comment;
import net.comment.db.CommentDAO;
import net.issue.action.Action;
import net.issue.action.ActionForward;

public class CommentUpdate implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CommentDAO dao = new CommentDAO();
		
		Comment co = new Comment();
		co.setC_content(request.getParameter("content"));
		co.setC_num(Integer.parseInt(request.getParameter("num")));
		System.out.println("content="+co.getC_content());
	
		request.setCharacterEncoding("UTF-8");


		int ok = dao.commentsUpdate(co);
		response.getWriter().print(ok);
		return null;

	}
	
}
