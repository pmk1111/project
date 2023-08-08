package net.usr.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.usr.db.Usr;
import net.usr.db.UsrDAO;

public class UsrEditProcess implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		String realFolder="";
		
		//webapp아래에 꼭 폴더 생성하세요
		String saveFolder="usrupload";
		
		int fileSize = 5*1024*1024; //업로드할 파일의 최대 사이즈 5MB
		
		//실제 저장 경로 지정
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder = " + realFolder);
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request,
					realFolder,
					fileSize,
					"utf-8",
					new DefaultFileRenamePolicy());
		
			
			String id = multi.getParameter("id");
			String pass = multi.getParameter("pass");
			String email = multi.getParameter("email");
			String name = multi.getParameter("name");
			String tel = multi.getParameter("tel");
			
			

   
			//시스템 상에 업로드된 실제 파일명을 얻어옵니다.
			String pic = multi.getFilesystemName("pic");
			System.out.println("pic=" + pic);
			
			Usr u = new Usr();
			u.setId(id);  u.setEmail(email); u.setPic(pic);
			u.setPass(pass); u.setName(name); u.setTel(tel);			
			
			if(pic !=null) {//파일을 선택한 경우
				u.setPic(pic);
			}
			//기존 파일 그대로 사용하는 경우
			else {
				u.setPic(multi.getParameter("check"));
			}
			
			UsrDAO dao = new UsrDAO();
			int result = dao.update(u);
			
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			//삽입이 된 경우
			if(result ==1) {
				out.println("alert('수정되었습니다.');");
				out.println("location.href='usrEdit.net';");
			}else {
				out.println("alert('회원 정보 수정에 실패했습니다.');");
				out.println("history.back()");//비밀번호를 제외한 다른 데이터는 유지되어 있습니다.
			}
			out.println("</script>");
			out.close();
			return null;
			}catch(IOException ex) {
				ex.printStackTrace();
				ActionForward forward=new ActionForward();
				forward.setPath("error/error.jsp");
				request.setAttribute("message", "프로필 사진 업로드 실패입니다.");
				forward.setRedirect(false);
				return forward;
			}
	
		
	}
}
