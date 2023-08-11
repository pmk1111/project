package net.comment.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.comment.db.CommentDAO;
import net.issue.action.Action;
import net.issue.action.ActionForward;

public class CommentUpdate implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CommentDAO dao = new CommentDAO();
		
		net.comment.db.Comment co = new net.comment.db.Comment();
		co.setC_content(request.getParameter("content"));
		co.setComment_i_num(Integer.parseInt(request.getParameter("comment_i_num")));
		System.out.println("content="+co.getC_content());
	
		
		int ok = dao.commentsUpdate(co);
		response.getWriter().print(ok);
		return null;

	}
	
}
