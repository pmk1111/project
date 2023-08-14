package net.comment.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.comment.db.Comment;
import net.comment.db.CommentDAO;
import net.issue.action.Action;
import net.issue.action.ActionForward;

public class CommentReply  implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CommentDAO dao = new CommentDAO();
		Comment co = new Comment();
		co.setC_id(request.getParameter("id"));
		co.setC_content(request.getParameter("content"));
		co.setComment_i_num(Integer.parseInt(request.getParameter("comment_i_num")));
		co.setComment_re_lev(Integer.parseInt(request.getParameter("comment_re_lev")));
		co.setComment_re_ref(Integer.parseInt(request.getParameter("comment_re_ref")));	
		co.setComment_re_seq(Integer.parseInt(request.getParameter("comment_re_seq")));
		
		int ok = dao.commentsReply(co);
		response.getWriter().print(ok);
		return null;
		
	
	}

}
