package net.comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.issue.action.Action;
import net.issue.action.ActionForward;
import net.issue.db.IssueDAO;
import net.comment.db.CommentDAO;

public class CommentDeleteAction implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		int c_num = Integer.parseInt(request.getParameter("c_num"));
		CommentDAO com = new CommentDAO();
		int result = com.commentsDelete(c_num);
		PrintWriter out = response.getWriter();
		out.print(result);

		return null;
	}
}
