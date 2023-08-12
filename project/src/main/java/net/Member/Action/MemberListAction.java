package net.Member.Action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import net.Member.db.Member;
import net.Member.db.MemberDAO;

public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MemberDAO mdao =new MemberDAO();
		List<Member> memberlist = new ArrayList<Member>();
		
		//로그인 성공시 파라미터 page가 없음. 그래서 초기값 필요
		int page = 1; //보여줄 page
		int limit = 10; //한 페이지에 보여줄 게시판 목록의 수
		
		if (request.getParameter("page") !=null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 ="+page);
		
		//추가
		if(request.getParameter("limit")!=null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		
		// 세션에 저장된 projectNum
		HttpSession session = request.getSession();
		int pnum = (int) session.getAttribute("p_num");
		
		int listcount = mdao.getMemberListCount(pnum);
		System.out.println("MemberListCount : " + listcount);
		
		// 멤버 리스트 가져오기
		memberlist = mdao.getMemberList(pnum, page, limit);

		int maxpage = (listcount + limit -1 )/limit;
		System.out.println("총 페이지수 =" + maxpage);
		
		int startpage = ((page-1)/10) * 10 +1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수:"+ startpage);
		
		int endpage = startpage + 10 -1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수:" + endpage);
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		String state = request.getParameter("state");
		
		if(state == null) {
			System.out.println("state==null");
			request.setAttribute("page", page); //현재 페이지 수
			request.setAttribute("maxpage", maxpage); //최대 페이지 수
			
			//현재 페이지에 표시할 첫 페이지 수
			request.setAttribute("startpage",startpage);
			
			//현재 페이지에 표시할 끝 페이지 수
			request.setAttribute("endpage", endpage);
			
			request.setAttribute("listcount",listcount); //총 글의 수
			
			//해당 페이지의 글 목록을 갖고 있는 리스트
			request.setAttribute("memberlist",memberlist);
			
			request.setAttribute("limit",limit);
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			//글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("member/memberList.jsp");
			return forward; //issueFrontController.java로 리턴합니다.
			
			
		}else {
			System.out.println("state=ajax");
		
			//위에서 request로 담았던 것을 JsonObject에 담습니다.
			JsonObject object = new JsonObject();
			object.addProperty("page", page); //{"page":변수 page의 값} 형식으로 저장
			object.addProperty("maxpage", maxpage);
			object.addProperty("startpage", startpage);
			object.addProperty("endpage", endpage);
			object.addProperty("listcount", listcount);
			object.addProperty("limit", limit);
			
			//JsonObject에 List 형식을 담을 수 있는 addProperty() 존재하지 않습니다.
			//void com.google.gson.JsonObject.add(String property, JsonElement value)메서드를 통해서 저장합니다.
			//List형식을 JsonElement로 바꾸어 주어야 object에 저장할 수 있습니다.
			
			//list => JsonElement
			JsonElement je = new Gson().toJsonTree(memberlist);
			System.out.println("issuelist="+je.toString());
			object.add("issuelist",je);
			
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(object);
			System.out.println(object.toString());
			return null;
			
		}//else end
		
	}

}
