package net.issue.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.issue.db.IssueDAO;

public class IssueDeleteProcess implements Action {
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int result = 0;

        int num = Integer.parseInt(request.getParameter("i_seq"));

        IssueDAO issuedao = new IssueDAO();

        result = issuedao.issueDelete(num);

        if (result == 0) {
            // 삭제 처리 실패 시 에러 페이지로 이동하거나 처리 방식을 정의하세요.
        	  System.out.println("게시판 삭제 실패");
              ActionForward forward = new ActionForward();
              forward.setRedirect(false);
              request.setAttribute("message", "데이터를 삭제하지 못했습니다.");
              forward.setPath("error/error.jsp");
              return forward;
        } else {
            // 삭제 처리 성공 시 필요한 작업을 여기에 추가하세요.
            System.out.println("게시판 삭제 성공");
            response.setContentType("text/html;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('삭제 되었습니다.');");
            out.println("location.href='IssueList.bo';");
            out.println("</script>");
            out.close();
        }

        return null;
    }
}
