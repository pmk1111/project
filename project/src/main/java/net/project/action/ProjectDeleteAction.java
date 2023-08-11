package net.project.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.project.db.ProjectDAO;

public class ProjectDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProjectDAO pdao = new ProjectDAO();
		String p_num = request.getParameter("p_num");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		int result = pdao.delete(p_num);
		if(result == 1) {
			out.println("<script>");
			out.println("alert('프로젝트가 삭제 되었습니다.');");
			out.println("location.href='ProjectList.pro'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('프로젝트 삭제에 실패했습니다.');");
			out.println("history.back()");
			out.println("</script>");
			
		}
		out.close();
		return null;
	}

}
