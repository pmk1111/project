package net.issue.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IssueDeleteAction implements Action {
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int num = Integer.parseInt(request.getParameter("num"));

        // JavaScript로 확인 창을 생성
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.println("<script>");
        out.println("var answer = confirm('정말로 삭제하시겠습니까?');");
        out.println("if (answer) {");
        out.println("    location.href='IssueDeleteProcess.bo?i_seq=" + num + "';"); // 삭제 처리 액션으로 이동
        out.println("} else {");
        out.println("    history.go(-1);"); // 이전 페이지로 돌아가기
        out.println("}");
        out.println("</script>");
        out.close();

        return null;
    }
}    //삭제이슈