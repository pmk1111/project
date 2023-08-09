package net.project.action;

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

import net.project.db.Project;
import net.project.db.ProjectDAO;

public class ProjectListAction implements Action {
	
	public ActionForward execute(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{

		ProjectDAO pdao = new ProjectDAO();
		List<Project> projectlist = new ArrayList<Project>();
		  
		int page = 1;
		int limit = 8;
		  
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		 
		if (request.getParameter("limit") != null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		  
		// 세션에있는 유저 넘버
		HttpSession session = request.getSession();
		int usrnum = (int) session.getAttribute("usrNum");
		
		// 임시 번호
//		int usrnum = 1;
		
		int listcount = pdao.getListCount(usrnum);
		System.out.println("넘어온 listcount : " + listcount);
		  
		projectlist = pdao.getProjectList(usrnum, page, limit);
		  
		int maxpage = (listcount + limit - 1) / limit;
		System.out.println("총 페이지수 =" + maxpage);
		  
	    int startpage = ((page - 1) / 10) * 10 + 1;
	    System.out.println("현재 페이지에 보여줄 시작 페이지 수 : " + startpage);
	         
	    int endpage = startpage+ 10 - 1;
	    System.out.println("현재 페이지에 보여줄 마지막 페이지 수  " + endpage);
	      
	    if (endpage > maxpage)
	        endpage = maxpage;
		  
	    String state = request.getParameter("state");
	      
	    if (state == null) {
	    	System.out.println("state==null");
	          
	    	request.setAttribute("page", page);
	          
	        request.setAttribute("maxpage", maxpage);
	          
	        request.setAttribute("startpage", startpage);
	          
	        request.setAttribute("endpage", endpage);
	          
	        request.setAttribute("listcount", listcount);
	          
	        request.setAttribute("projectlist", projectlist);
	          
	        request.setAttribute("limit", limit);
	          
	        ActionForward forward = new ActionForward();
	        forward.setRedirect(false);
	          
	        forward.setPath("project/ProjectList.jsp");
	        return forward;
	          
	    } else {
	    
	    	System.out.println("state = ajax");
	    	
	    	JsonObject object = new JsonObject();
	    	object.addProperty("page", page);
	    	object.addProperty("maxpage", maxpage);
	    	object.addProperty("startpage", startpage);
	    	object.addProperty("endpage", endpage);
	    	object.addProperty("listcount", listcount);
	    	object.addProperty("limit", limit);
	    	
	    	JsonElement je = new Gson().toJsonTree(projectlist);
	    	System.out.println("projectlist=" + je.toString());
	    	object.add("projectlist", je);
	    	
	        response.setContentType("application/json;charset=utf-8");
	        response.getWriter().print(object);
	        System.out.println(object.toString());
	        return null;
	    	
	    }
	}
}
