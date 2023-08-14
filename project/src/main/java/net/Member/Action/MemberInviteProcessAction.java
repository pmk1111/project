package net.Member.Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.Member.db.MemberDAO;

public class MemberInviteProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MemberDAO mdao = new MemberDAO();

		String uID = request.getParameter("user_ID");
		System.out.println("uID : " + uID);
		
		int uNum = mdao.getUserNum(uID);
		System.out.println("invite uNum : " + uNum);
		
		HttpSession session = request.getSession();
		int pnum = (int) session.getAttribute("p_num");
		System.out.println("inviteAction : " + pnum);	
		
		int result = mdao.memInvite(pnum, uNum);
		
		if(result == 0) {
			System.out.println("멤버 초대 실패입니다.");
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			request.setAttribute("message", "멤버 초대 실패입니다.");
			forward.setPath("error/error.jsp");
			return forward;
		}
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<script>");
		if(result == 1) {
			out.println("alert('멤버가 초대되었습니다..');");
			out.println("location.href='MemberList.mem';");
		}
		out.println("</script>");
		out.close();
		return null;
		
		
		
	
	}

}
