package net.comment.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.comment.db.Comment;
import net.comment.db.CommentDAO;
import net.issue.action.Action;
import net.issue.action.ActionForward;

public class CommentAdd implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		
		Comment co = new Comment();
		co.setC_id(request.getParameter("c_id"));
		co.setC_content(request.getParameter("c_content"));
		co.setComment_i_num(Integer.parseInt(request.getParameter("comment_i_num")));
		//co.setComment_p_num(Integer.parseInt(request.getParameter("comment_p_num")));
		
		System.out.println("content="+co.getC_content());
		
		int ok = dao.commentsInsert(co);
		response.getWriter().print(ok);
		return null;
		
	}

}
