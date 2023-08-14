package net.project.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProjectDAO {

	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public ProjectDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}

	}

	public boolean projectInsert(Project pdata, int num) {

		int result = 0;

		String seq = " SELECT PRO_SEQ.NEXTVAL FROM DUAL";

		int seqnum = 0;

		try (Connection con = ds.getConnection(); PreparedStatement pstmtseq = con.prepareStatement(seq);) {

			try (ResultSet rs = pstmtseq.executeQuery()) {

				if (rs.next()) {

					seqnum = rs.getInt(1);

					String projectsql = " INSERT INTO PROJECT " 
									  + " (P_NUM, P_NAME, P_START, P_CLOSING, P_FILE) "
									  + " VALUES (" + seqnum + ", ?, ?, ?, ?)";

					String membersql = "INSERT INTO MEMBER "
					          + "(p_num, num, grade, m_id, M_name, M_pic, M_tel, M_email) "
					          + "SELECT " + seqnum + ", ?, 'master', id, name, pic, tel, email FROM USR WHERE num = ? ";

					try (PreparedStatement pstmtProject = con.prepareStatement(projectsql);
						 PreparedStatement pstmtMember = con.prepareStatement(membersql);) {

						con.setAutoCommit(false); // 트랜잭션 시작

						pstmtProject.setString(1, pdata.getP_name());
						pstmtProject.setString(2, pdata.getP_start());
						pstmtProject.setString(3, pdata.getP_closing());
						pstmtProject.setString(4, pdata.getP_file());

						result = pstmtProject.executeUpdate();

						pstmtMember.setInt(1, num);
						pstmtMember.setInt(2, num);
						int memberResult = pstmtMember.executeUpdate();

						if (result == 1 && memberResult == 1) {
							con.commit();
							System.out.println("프로젝트 및 회원 데이터 삽입이 완료되었습니다.");
							return true;

						} else {
							con.rollback();
							System.out.println("프로젝트 및 회원 데이터 삽입 중 오류가 발생했습니다.");
						}
					}

				}
			}

		} catch (Exception ex) {
			System.out.println("projectInsert() 에러 : " + ex);
			ex.printStackTrace();
		}

		return false;
	}

	public int getListCount(int usrnum) {

		int result = 0;

		String sql = "SELECT COUNT(*) " + "FROM member " + "WHERE num = ?";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, usrnum);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					result = rs.getInt(1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getListCountByUser() 에러: " + ex);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getListCountByUser() 에러: " + e);
		}

		return result;
	}

	public List<Project> getProjectList(int usrnum, int page, int limit) {

		String sql = "SELECT * " 
					+ "FROM (" 
					+ "      SELECT ROWNUM rnum, p.* " 
					+ "      FROM project p "
					+ "      JOIN member m ON p.p_num = m.p_num " 
					+ "      WHERE m.num = ? "
					+ "      ORDER BY p.p_num DESC " 
					+ "     ) " 
					+ "WHERE rnum BETWEEN ? AND ?";

		List<Project> list = new ArrayList<Project>();

		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		try (Connection con = ds.getConnection();

				PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, usrnum);
			pstmt.setInt(2, startrow);
			pstmt.setInt(3, endrow);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {
					Project project = new Project();
					project.setP_num(rs.getInt("P_NUM"));
					project.setP_name(rs.getString("P_NAME"));
//					project.setP_status(rs.getString("P_STATUS"));
					project.setP_start(rs.getString("P_START"));
					project.setP_closing(rs.getString("P_CLOSING"));
//					project.setP_created(rs.getString("P_CREATED"));
					project.setP_file(rs.getString("P_FILE"));
					list.add(project);
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("getListCoutn() 에러 : " + ex);
		}

		return list;
	}
	
	public String getProjectName(int pnum) {
		String sql = "select p_name from project where p_num = ?";
		
		String result = "";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, pnum);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					result = rs.getString(1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getListCountByUser() 에러: " + ex);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getListCountByUser() 에러: " + e);
		}

		return result;
	}

	
	public Project getDetail(int p_num) {
	    String sql = "SELECT P_NUM, P_NAME, P_STATUS, P_START, P_CLOSING, P_CREATED, P_FILE FROM PROJECT WHERE P_NUM = ?";

	    Project project = null;

	    try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
	        pstmt.setInt(1, p_num);

	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) {
	                project = new Project();
	                project.setP_num(rs.getInt("P_NUM"));
	                project.setP_name(rs.getString("P_NAME"));
	                project.setP_status(rs.getString("P_STATUS"));
	                project.setP_start(rs.getString("P_START"));
	                project.setP_closing(rs.getString("P_CLOSING"));
	                project.setP_created(rs.getString("P_CREATED"));
	                project.setP_file(rs.getString("P_FILE"));
	            }
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	    } catch (Exception ex) {
	        System.out.println("getDetail() 에러:" + ex);
	    }
	    return project;
	}

	public int update(Project p) {
	    int result = 0;
	    String sql = "UPDATE project SET p_name = ? , p_start = ? , p_closing = ?, p_file = ?  WHERE p_num = ? ";
 
	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql);) {
	        pstmt.setString(1, p.getP_name());
	        pstmt.setString(2, p.getP_start());
	        pstmt.setString(3, p.getP_closing());
	        pstmt.setString(4, p.getP_file());
	        pstmt.setInt(5, p.getP_num());

	        result = pstmt.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}

	public int delete(int p_num) {
	    
		int EU1 = 0;
		int EU2 = 0;
		
		int result = 0;
	    
		String sql = "DELETE FROM project WHERE p_num = ?";
	    
	    String memsql = "DELETE FROM MEMBER WHERE P_NUM = ?";
	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql);
	    	 PreparedStatement mempstmt = con.prepareStatement(memsql);) {
	    	
	    	 pstmt.setInt(1, p_num);
	    	 EU1 = pstmt.executeUpdate();
	    	 
	    	 mempstmt.setInt(1, p_num);
	    	 EU2 = mempstmt.executeUpdate();
	    	 
	    	 if(EU1 == 1 && EU2 == 1 ) {
	    		 result = 1;
	    	 }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}




}
