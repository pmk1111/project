package net.project.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.project.db.Project;
import net.project.db.ProjectDAO;

public class ProjectModifyView implements Action {

    @Override
    public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProjectDAO projectdao = new ProjectDAO();
        Project projectdata = new Project();
        ActionForward forward = new ActionForward();

        int p_num = Integer.parseInt(request.getParameter("p_num"));

        projectdata = projectdao.getDetail(p_num);

        if (projectdata == null) {
            System.out.println("(수정)상세보기 실패");
            forward = new ActionForward();
            forward.setRedirect(false);
            forward.setPath("error/error.jsp");
            request.setAttribute("message", "프로젝트 수정 상세 보기 실패입니다.");
            return forward;
        }

        System.out.println("(수정)상세보기 성공");

        request.setAttribute("projectdata", projectdata);
        forward.setRedirect(false);
        forward.setPath("project/modifypj.jsp");
        return forward;
    }
}
