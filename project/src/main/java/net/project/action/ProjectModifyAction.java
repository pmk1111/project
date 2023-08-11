package net.project.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.project.db.Project;
import net.project.db.ProjectDAO;

public class ProjectModifyAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String realFolder ="";
		
		String savfolder = "projectupload";
		
		int fileSize = 5*1024*1024; // 업로드할 파일의 최대 사이즈입니다.5BM
		
		//실제 저장 경로를 지정합니다
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(savfolder);
		System.out.println("realFolder= "+realFolder);
		try {
			MultipartRequest multi = new MultipartRequest(request,realFolder, fileSize,"utf-8",
					new DefaultFileRenamePolicy());
			
			String p_name=multi.getParameter("p_name");
			String p_start=multi.getParameter("p_start");
			String p_closing=multi.getParameter("p_closing");
			String p_file = multi.getFilesystemName("p_file");
			System.out.println("넘어온 p_file =>  "+p_file);
			String p_num = multi.getParameter("p_num");
			
			Project p = new Project();
			
			p.setP_name(p_name); p.setP_start(p_start); p.setP_closing(p_closing); p.setP_num(Integer.parseInt(p_num));
			
			if(p_file !=null) { //파일을 선택한 경우
				p.setP_file(p_file);
			}
			
			//기존파일 그대로 사용하는경우
			else {
				p.setP_file(multi.getParameter("check"));
			}
			ProjectDAO pdao = new ProjectDAO();
			int result = pdao.update(p);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			// 삽입이 된 경우
			if(result ==1) {
				out.println("alert('수정되었습니다.');");
				out.println("location.href='ProjectList.pro';");
			}else {
				out.println("alert('프로젝트 수정에 실패했습니다.');");
				out.println("history.back()");//비밀번호를 제외한 다른 데이터는 유지되어 있습니다.
			}
			out.println("</script>");
			out.close();
			return null;
		}catch(IOException ex) {
			ex.printStackTrace();
			ActionForward forward = new ActionForward();
			forward.setPath("error/error.jsp");
			forward.setRedirect(false);
			request.setAttribute("message","사진 업로드 실패했습니다");
			return forward;
		}
		
	}

}
