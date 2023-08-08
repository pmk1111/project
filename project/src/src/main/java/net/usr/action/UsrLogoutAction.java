package net.usr.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class UsrLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	     // 세션을 가져오기
        HttpSession session = request.getSession(false);
        session.invalidate();
     

        // 로그인 페이지로 리다이렉트합니다.
        ActionForward forward = new ActionForward();
        forward.setRedirect(true);
        forward.setPath("login.net"); //이동할 주소는 login.net
        return forward;
	}

}