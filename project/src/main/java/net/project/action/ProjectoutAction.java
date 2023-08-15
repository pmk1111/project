package net.project.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.Member.db.MemberDAO;

public class ProjectoutAction implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	MemberDAO mdao = new MemberDAO();

        // String p_num = request.getParameter("p_num");
        HttpSession session = request.getSession();
        // 세션에서 현재 로그인한 사용자의 member 정보를 가져옵니다.
        
	    int usrNum = (int) session.getAttribute("usrNum");
	    System.out.println("usrNum : " + usrNum);
		int p_num = (int) session.getAttribute("p_num");
	    System.out.println("p_num : " + p_num);
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        int result = mdao.outproject(usrNum, p_num);
        
        if (result == 1) {
            out.println("<script>");
            out.println("alert('해당 프로젝트를 나갔습니다.');");
            out.println("location.href='ProjectList.pro'");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('해당 프로젝트를 나가지 못했습니다.');");
            out.println("history.back()");
            out.println("</script>");

        }
        out.close();
        return null;
    }

}

