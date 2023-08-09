package net.usr.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.net")
public class UsrFrontController extends javax.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI = " + RequestURI);
		
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath = " + contextPath);
		
		
		String command = RequestURI.substring(contextPath.length());
		System.out.println("command="+command);
		
		String uri = request.getRequestURI();
		String conPath = request.getContextPath();
		
		
		ActionForward forward = null;
		Action action = null;
		
		switch (command) {
	      case "/home.net":
	         action = new UsrHomeAction();
	         break;
	      case "/login.net":
	         action = new UsrLoginAction();
	         break;
	      case "/join.net":
	         action = new UsrJoinAction();
	         break;
	      case "/idcheck.net":
	         action = new UsrIdcheckAction();
	         break;
	      case "/joinProcess.net":
	         action = new UsrjoinProcessAction();
	         break;
	      case "/loginProcess.net":
	         action = new UsrloginProcessAction();
	         break;
	      case "/logout.net":
	      action = new UsrLogoutAction();
	         break;
		 case "/usrEdit.net":
	 		action = new UsrEditAction();
			break;
		case "/usrEditProcess.net":
			action = new UsrEditProcess();
			break;
		case "/usrDelete.net":
			action = new UsrDeleteAction();
			break;
		case "/usrInfo.net":
			action = new UsrInfoAction();
			break;
		case "/confirmEmail.net":
			action = new ConfirmEmailAction();
			break;
		
		}//switch end
		forward = action.execute(request, response);
		
		if(forward !=null) {
			if(forward.isRedirect()) {//리다이렉트 됩니다.
				response.sendRedirect(forward.getPath());
			}else {//포워딩됩니다.
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}//doProcess() end
	
	//doProcess(request,response)메서드를 구현하여 요청이 GET방시이든
	//POST방식으로 전송되어 오든 같은 메서드에서 요청을 처리할 수 있도록 하였습니다.
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doProcess(request, response);
	}
	
}

