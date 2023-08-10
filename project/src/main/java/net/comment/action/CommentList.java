package net.comment.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import net.issue.action.Action;
import net.issue.action.ActionForward;

public class CommentList implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		net.comment.db.CommentDAO dao = new net.comment.db.CommentDAO();
		
		int comment_issue_num = Integer.parseInt(request.getParameter("c_num"));
		System.out.println(comment_issue_num);
		int state = Integer.parseInt(request.getParameter("state"));
		
		int listcount = dao.getListCount(comment_issue_num);
		JsonArray jarray = dao.getCommentList(comment_issue_num, state);
		
		JsonObject object = new JsonObject();
		object.addProperty("listcount", listcount);
		
		
		JsonElement je = new Gson().toJsonTree(jarray);
		object.add("issuelist", je);
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
	}

}
