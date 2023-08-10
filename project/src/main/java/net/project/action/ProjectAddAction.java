package net.project.action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.project.db.Project;
import net.project.db.ProjectDAO;

public class ProjectAddAction implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ProjectDAO pdao = new ProjectDAO();
		Project pdata = new Project();
		ActionForward forward = new ActionForward();
		
		String realFolder = "";
		
		String saveFolder = "projectupload";
				
		int fileSize = 5 * 1024 * 1024;
		
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		boolean result = false;
		
		try {
			MultipartRequest multi = new MultipartRequest (
					request, realFolder, fileSize, "utf-8", new DefaultFileRenamePolicy());
			
			pdata.setP_name(multi.getParameter("p_name"));
			pdata.setP_start(multi.getParameter("p_start"));
			pdata.setP_closing(multi.getParameter("p_closing"));
			
			String filename = multi.getFilesystemName("p_file");
			pdata.setP_file(filename);
			
//			 세션에있는 유저 넘버
			HttpSession session = request.getSession();
			int usrnum = (int) session.getAttribute("usrNum");
			
			// 임시 번호
//			int usrnum = 1;
			
			result = pdao.projectInsert(pdata, usrnum);
			
	         if(result == false) {
	             System.out.println("프로젝트 등록 실패");
	             forward.setPath("error/error.jsp");
	             request.setAttribute("message", "프로젝트 등록 실패입니다.");
	             forward.setRedirect(false);
	             return forward;
	          }
	          System.out.println("프로젝트 등록 완료");
	          
	          forward.setRedirect(true);
	          forward.setPath("ProjectList.pro");
	          return forward;
			
		} catch (IOException ex) {
	         ex.printStackTrace();
	         forward.setPath("error/error.jsp");
	         request.setAttribute("message", "게시판 업로드 실패입니다.");
	         forward.setRedirect(false);
	         return forward;
	      }
	}
}
