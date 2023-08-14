package net.Member.Action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.Member.db.MemberDAO;
import net.usr.db.Usr;

public class MemberInviteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      
		ActionForward forward = new ActionForward();
	      int p_num = Integer.parseInt(request.getParameter("num"));
	      request.setAttribute("num", p_num);

	      // SchoolDAO를 사용하여 학교 리스트를 가져옴
	        MemberDAO mdao = new MemberDAO();
	        List<Usr> userList = mdao.searchid(); 

	        // JSP 페이지로 데이터를 전달하기 위해 request 객체에 속성으로 저장합니다.
	        request.setAttribute("userList", userList);
	      
	      forward.setRedirect(false); // 주소 변경없이 jsp페이지의 내용을 보여줍니다.
	      forward.setPath("member/findUsr.jsp");
	      return forward;
		
	}

}
