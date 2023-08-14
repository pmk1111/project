package net.issue.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class IssueDAO {
	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public IssueDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 :" + ex);
		}
	}
	
	public String getProjectName(int pnum) {
		String sql = "select p_name from project where p_num = "+ pnum;
		
		String x = "";
		
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getString(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount()에러 " + ex);
		}
		return x;
	}


	// 글의갯수 구하기
	public int getListCount(int pnum) {
		
		String sql = "select count(*) from issue where p_num = "+ pnum;
		
		int x = 0;
		
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					x = rs.getInt(1);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount()에러 " + ex);
		}
		return x;
	}// getListCount()end
	
	//게시글 조회수 업데이트
	public void setReadCountUpdate(int num) {
		String sql = "update issue "
				+ "set i_readcount = i_readcount+1 "
				+ "where i_seq = ?";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (SQLException ex) {
			System.out.println("setReadCountUpdate() 에러: " + ex);
		}
	}

	// 글 목록 보기
	public List<IssueBean> getIssueList(int pnum, int page, int limit) {

		// 프로젝트 넘버
		List<IssueBean> list = new ArrayList<IssueBean>();
		String issue_list_sql = "SELECT * "
							  + " FROM ( SELECT ROWNUM rnum, i.* "
							  + "		 FROM issue i "
							  + "    	 join project p on i.p_num = p.p_num "
							  + "		 where p.p_num = ?"
							  + "		 order by i.i_seq desc "
							  + "		) "
							  + "WHERE rnum BETWEEN ? AND ?";
		/*String issue_list_sql = " select * from issue order by issue_num desc ";*/
		int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호 (1 11 21 31 ...
		int endrow = startrow + limit - 1; // 읽을 마지막 row 번호 (10 20 30 40 ...
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(issue_list_sql);) {
			pstmt.setInt(1, pnum);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);

			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 issueBean에 담습니다.
				while (rs.next()) {
					IssueBean issue = new IssueBean();
					issue.setI_seq(rs.getInt("I_SEQ")); 
					issue.setI_id(rs.getString("I_id"));
					issue.setI_name(rs.getString("I_name"));
					issue.setI_type(rs.getString("I_TYPE"));					
					issue.setI_title(rs.getString("I_TITLE"));
					issue.setI_content(rs.getString("I_CONTENT"));
					issue.setI_status(rs.getString("I_STATUS"));
					issue.setI_file(rs.getString("I_FILE"));
					
					issue.setI_created(rs.getString("I_CREATED"));
					issue.setI_modified(rs.getString("I_MODIFIED"));
					issue.setI_reporter(rs.getString("I_NAME"));
					//우선 글 작성자가 담당자가 되도록 설정
					issue.setI_assign(rs.getString("I_ASSIGN"));
					issue.setI_related(rs.getString("I_RELATED"));
					issue.setI_readcount(rs.getInt("I_READCOUNT")); 

					list.add(issue); // 값을 담은 객체를 리스트에 저장합니다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount()에러 " + ex);
		}
		return list;
	}
	
	public List<IssueBean> getMainboardList(int pnum) {

		// 프로젝트 넘버
		List<IssueBean> list = new ArrayList<IssueBean>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		String issue_list_sql = "SELECT * "
							  + " FROM ( SELECT * "
							  + "		 FROM issue "
							  + "		 where p_num = ?"
							  + "		 order by i_seq desc"
							  + "		) "
							  + "where rownum <= 4";

		//해당 프로젝트의 글을 최신 순으로 4개를 가져오는 쿼리문 작성 
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(issue_list_sql);) {
			pstmt.setInt(1, pnum);

			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 issueBean에 담습니다.
				while (rs.next()) {
					IssueBean issue = new IssueBean();
					issue.setI_seq(rs.getInt("I_SEQ")); 
					issue.setI_id(rs.getString("I_id"));
					issue.setI_name(rs.getString("I_name"));
					issue.setI_type(rs.getString("I_TYPE"));	
					issue.setI_title(rs.getString("I_TITLE"));
					issue.setI_content(rs.getString("I_CONTENT"));
					issue.setI_status(rs.getString("I_STATUS"));
					issue.setI_file(rs.getString("I_FILE"));
					
					issue.setI_created(rs.getString("I_CREATED"));
					issue.setI_modified(rs.getString("I_MODIFIED"));
					issue.setI_reporter(rs.getString("I_NAME"));
					//우선 글 작성자가 담당자가 되도록 설정
					issue.setI_assign(rs.getString("I_ASSIGN"));
					issue.setI_related(rs.getString("I_RELATED"));
					issue.setI_readcount(rs.getInt("I_READCOUNT")); 

					list.add(issue); // 값을 담은 객체를 리스트에 저장합니다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount()에러 " + ex);
		}
		return list;
	}


	public List<IssueBean> getToDoList(String id, String usrname, int pnum) {
		
		String todo = "To Do";
		// 프로젝트 넘버
		List<IssueBean> list = new ArrayList<IssueBean>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		String issue_list_sql = "SELECT * "
							  + " FROM ( SELECT * "
							  + "		 FROM issue "
							  + "    	 where p_num = ?"
							  + "		 and i_id = ?"
							  + "		 and i_assign = ?"
							  + "		 and i_status = '"+ todo+ "'"
							  + "		 order by i_seq desc)"
							  + " where rownum <=3";
		//현재는 작성자 == 보고자이면서 담당자이기 때문에 해당 쿼리가 유효하지만
		//추후 담당자를 해당 프로젝트에 참여한 인원들 중 선택할 수 있게 된다면
		//동명이인이 나올 경우 이걸로는 구할 수 없다(i_id는 게시글 작성자 id이기 때문에)
		//결국 해당 쿼리의 값 + 중복되지 않는 값(usrid or usrnumber)과 비교해 
		//두 경우 모두 일치하는 경우의 값만 가져와야 한다

		/*String issue_list_sql = " select * from issue order by issue_num desc ";*/
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(issue_list_sql);) {
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			pstmt.setString(3, usrname);

			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 issueBean에 담습니다.
				while (rs.next()) {
					IssueBean issue = new IssueBean();
					issue.setI_seq(rs.getInt("I_SEQ")); 
					issue.setI_name(rs.getString("I_name"));
					issue.setI_id(rs.getString("I_id"));
					issue.setI_title(rs.getString("I_TITLE"));
					issue.setI_content(rs.getString("I_CONTENT"));
					issue.setI_status(rs.getString("I_STATUS"));
					issue.setI_file(rs.getString("I_FILE"));
					
					issue.setI_created(rs.getString("I_CREATED"));
					issue.setI_modified(rs.getString("I_MODIFIED"));
					issue.setI_reporter(rs.getString("I_NAME"));
					//우선 글 작성자가 담당자가 되도록 설정
					issue.setI_assign(rs.getString("I_ASSIGN"));
					issue.setI_related(rs.getString("I_RELATED"));
					issue.setI_readcount(rs.getInt("I_READCOUNT")); 

					list.add(issue); // 값을 담은 객체를 리스트에 저장합니다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getToDoList()에러 " + ex);
		}
		return list;
	} // getToDoList end
	
	public List<IssueBean> getInProgressList(String id, String usrname, int pnum) {

		// page : 페이지
		// limit : 페이지 당 목록의 수
		// issue_re_ref desc, issue_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.
		String progress = "In Progress";
		// 프로젝트 넘버
		List<IssueBean> list = new ArrayList<IssueBean>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		String issue_list_sql = "SELECT * "
				  		+ " FROM ( SELECT * "
				  		+ "		 FROM issue "
				  		+ "    	 where p_num = ?"
				  		+ "		 and i_id = ?"
				  		+ "		 and i_assign = ?"
				  		+ "		 and i_status = '"+ progress + "'"
				  		+ "		 order by i_seq desc)"
				  		+ " where rownum <=3";
		//해당 프로젝트에 해당하는 게시글만 가져오기 위해 p_num을 넣어야 하는데, 어디에 넣느냐

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(issue_list_sql);) {
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			pstmt.setString(3, usrname);

			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 issueBean에 담습니다.
				while (rs.next()) {
					IssueBean issue = new IssueBean();
					issue.setI_seq(rs.getInt("I_SEQ")); 
					issue.setI_name(rs.getString("I_name"));
					issue.setI_id(rs.getString("I_id"));
					issue.setI_title(rs.getString("I_TITLE"));
					issue.setI_content(rs.getString("I_CONTENT"));
					issue.setI_status(rs.getString("I_STATUS"));
					issue.setI_file(rs.getString("I_FILE"));
					
					issue.setI_created(rs.getString("I_CREATED"));
					issue.setI_modified(rs.getString("I_MODIFIED"));
					issue.setI_reporter(rs.getString("I_NAME"));
					//우선 글 작성자가 담당자가 되도록 설정
					issue.setI_assign(rs.getString("I_ASSIGN"));
					issue.setI_related(rs.getString("I_RELATED"));
					issue.setI_readcount(rs.getInt("I_READCOUNT")); 

					list.add(issue); // 값을 담은 객체를 리스트에 저장합니다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount()에러 " + ex);
		}
		return list;
	} // getInProgressList end
	
	public List<IssueBean> getDoneList(String id, String usrname, int pnum) {

		// page : 페이지
		// limit : 페이지 당 목록의 수
		// issue_re_ref desc, issue_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.
		String done = "Done";
		// 프로젝트 넘버
		List<IssueBean> list = new ArrayList<IssueBean>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		
		String issue_list_sql = "SELECT * "
		  				+ " FROM ( SELECT * "
		  				+ "		 FROM issue "
		  				+ "    	 where p_num = ?"
		  				+ "		 and i_id = ?"
		  				+ "		 and i_assign = ?"
		  				+ "		 and i_status = '"+ done + "'"
		  				+ "		 order by i_seq desc)"
		  				+ " where rownum <=3";

		/*String issue_list_sql = " select * from issue order by issue_num desc ";*/
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(issue_list_sql);) {
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			pstmt.setString(3, usrname);

			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 issueBean에 담습니다.
				while (rs.next()) {
					IssueBean issue = new IssueBean();
					issue.setI_seq(rs.getInt("I_SEQ")); 
					issue.setI_name(rs.getString("I_name"));
					issue.setI_id(rs.getString("I_id"));
					issue.setI_title(rs.getString("I_TITLE"));
					issue.setI_content(rs.getString("I_CONTENT"));
					issue.setI_status(rs.getString("I_STATUS"));
					issue.setI_file(rs.getString("I_FILE"));
					
					issue.setI_created(rs.getString("I_CREATED"));
					issue.setI_modified(rs.getString("I_MODIFIED"));
					issue.setI_reporter(rs.getString("I_NAME"));
					//우선 글 작성자가 담당자가 되도록 설정
					issue.setI_assign(rs.getString("I_ASSIGN"));
					issue.setI_related(rs.getString("I_RELATED"));
					issue.setI_readcount(rs.getInt("I_READCOUNT")); 

					list.add(issue); // 값을 담은 객체를 리스트에 저장합니다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCount()에러 " + ex);
		}
		return list;
	} // getDoneList end
	
	public boolean issueInsert(IssueBean issuedata, String name, int projectNum, String id) {
		
		String sql = "INSERT INTO issue "
		           + "(i_seq, i_NAME, i_title, i_CONTENT, i_readcount, p_num, i_status, i_type, i_reporter, i_assign, i_related, i_id)"
		           + " values(i_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		int result = 0;
		
		try {
		    Connection con = ds.getConnection();
		    PreparedStatement pstmt = con.prepareStatement(sql);

		    pstmt.setString(1, name);
		    pstmt.setString(2, issuedata.getI_title());
		    pstmt.setString(3, issuedata.getI_content());
		    pstmt.setInt(4, 0);
		    pstmt.setInt(5, projectNum);
		    pstmt.setString(6, issuedata.getI_status());
		    pstmt.setString(7, issuedata.getI_type());
		    pstmt.setString(8, issuedata.getI_reporter());
		    pstmt.setString(9, issuedata.getI_assign());
		    pstmt.setString(10, issuedata.getI_related());
		    pstmt.setString(11, id);

		    result = pstmt.executeUpdate();

		    if (result == 1) {
		        System.out.println("데이터 삽입이 모두 완료되었습니다.");
		        return true;
		    }
		} catch (Exception ex) {
		    System.out.println("IssueInsert()에러: " + ex);
		    ex.printStackTrace();
		}
		return false;

	}// issueInsert()메서드 end

	/*
	 * public void setReadCountUpdate(int num) { String sql = "update issue " +
	 * "set issue_readcount = issue_readcount+1 " + "where issue_num=?"; try
	 * (Connection con = ds.getConnection(); PreparedStatement pstmt =
	 * con.prepareStatement(sql);) { pstmt.setInt(1, num); pstmt.executeUpdate(); }
	 * catch (Exception ex) { System.out.println("setReadCountUpdate()에러: " + ex); }
	 * }
	 */

	public IssueBean getDetail(int num) {
		
		IssueBean issue =  new IssueBean();;
		String sql = "	select * from issue" 
				   + "	where i_seq =?";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 issueBean에 담습니다.
				if (rs.next()) {
					
					issue.setI_seq(rs.getInt("I_SEQ")); 
					issue.setP_num(rs.getInt("P_NUM"));
					issue.setI_id(rs.getString("I_ID"));
					issue.setI_type(rs.getString("I_type"));
					issue.setI_name(rs.getString("I_name"));
					issue.setI_title(rs.getString("I_TITLE"));
					issue.setI_content(rs.getString("i_content"));
					issue.setI_status(rs.getString("I_STATUS"));
					issue.setI_file(rs.getString("I_FILE"));
					
					issue.setI_created(rs.getString("I_CREATED"));
					issue.setI_modified(rs.getString("I_MODIFIED"));
					issue.setI_reporter(rs.getString("I_NAME"));
					//우선 글 작성자가 담당자가 되도록 설정
					issue.setI_assign(rs.getString("I_ASSIGN"));
					issue.setI_related(rs.getString("I_RELATED"));
					issue.setI_readcount(rs.getInt("I_READCOUNT")); 
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			System.out.println("getDetail()에러: " + ex);
		}
		return issue;
	}//getDetail()메서드 end

	
	public boolean issueModify(IssueBean issuedata) {
	      
	      String sql = "update issue "
	             + "set i_title=?, i_content=?, i_status=?, i_type=?, i_assign=?, i_related=?, i_created=sysdate "
	             + "where i_seq=?";


	      try(Connection con = ds.getConnection();
	            PreparedStatement pstmt = con.prepareStatement(sql);) {
	   
	         
	         
	         
	          pstmt.setString(1, issuedata.getI_title());
	          pstmt.setString(2, issuedata.getI_content());
	         pstmt.setString(3, issuedata.getI_status());
	          pstmt.setString(4, issuedata.getI_type());
	   
	      
	          pstmt.setString(5, issuedata.getI_assign());
	          pstmt.setString(6, issuedata.getI_related());
	          pstmt.setInt(7, issuedata.getI_seq());
	   
	         int result = pstmt.executeUpdate();
	         if(result==1) {
	            System.out.println("성공 업데이트");
	            return true;
	         }

	      }catch (Exception e) {
	         System.out.println("issueModift()에러: " + e);
	      }


	      return false;
	   }
	
	public int issueDelete(int num) {
        String issue_delete_sql = "DELETE FROM issue WHERE i_seq = ? ";
        
         
         int result_check = 0;

        
        try(Connection con = ds.getConnection();
           PreparedStatement pstmt = con.prepareStatement(issue_delete_sql);)
        { //1
           // issue 테이블에서 삭제
           
           pstmt.setInt(1, num);
         
           result_check = pstmt.executeUpdate();


           //삭제 성공 유무
           if(result_check == 0){
              System.out.println("삭제 실패");
           }else{
              System.out.println("삭제 성공");
           }

         } catch (Exception e) {
             System.out.println("issueDelete() 에러: " + e);
             e.printStackTrace();
         }
         
         return result_check;
  }

}//class end