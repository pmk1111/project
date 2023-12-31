package net.usr.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.usr.db.UsrDAO;

public class UsrloginProcessAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 ActionForward forward = new ActionForward();
	      String id = request.getParameter("id");
	      String pass = request.getParameter("pass");
	      UsrDAO mdao = new UsrDAO();
	      int result = mdao.isId(id, pass);
	      System.out.println("결과는 " + result);
	      
	      //로그인 성공
	      if(result ==1) {
	    	  
	         HttpSession session = request.getSession();
	         session.setAttribute("id", id);
	         
	         
	         
	         
	         String IDStore = request.getParameter("remember");
				Cookie cookie = new Cookie("id", id);
				
				//id 기억하기 체크 시
				if(IDStore != null && IDStore.equals("store")) {
					cookie.setMaxAge(60*60);
					response.addCookie(cookie);
					System.out.println("쿠키 확인");
				} else {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
	         
	         
	         
	         
	         
	         
	 		// UserDao를 사용하여 사용자의 num 값을 가져옵니다.
	 		UsrDAO dao = new UsrDAO();
	 			
	 		// 세션에 usrnum 저장
	 		int usrNum = dao.getUserNum(id);
	 		System.out.println("usrNum = " + usrNum);
	 		session.setAttribute("usrNum", usrNum);
	 		
	 		// 세션에 usrname 저장
	 		String usrName = dao.getUserName(id);
	 		System.out.println("usrName = " + usrName);
	 		session.setAttribute("usrName", usrName);
	         
	         forward.setRedirect(true);
	         forward.setPath("ProjectList.pro");
	         return forward;
	         
	      } else {
	         String message = "비밀번호가 일치하지 않습니다.";
	         if(result ==-1)
	            message = "아이디가 존재하지 않습니다.";
	         
	         response.setContentType("text/html;charset=utf-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>");
	         out.println("alert('"+message+"');");
	         out.println("location.href='login.net';");
	         out.println("</script>");
	         out.close();
	         return null;
	      }
	   }

}