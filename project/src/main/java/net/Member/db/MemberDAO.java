package net.Member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.usr.db.Usr;

public class MemberDAO {

	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public MemberDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}

	}

	public int getMemberListCount(int pnum) {
		
		int result = 0;

		String sql = "SELECT COUNT(*) " 
				   + "FROM member " 
				   + "WHERE p_num = ?";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setInt(1, pnum);

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

	public List<Member> getMemberList(int pnum, int page, int limit) {
		
		String sql = "SELECT * "
				   + "FROM ( "
				   + "		 SELECT ROWNUM rnum, m.* "
				   + "		 FROM member m " 
				   + "		 JOIN project p ON m.p_num = p.p_num "
				   + "		 WHERE p.p_num = ? "
				   + "		 ORDER BY m.num desc "
				   + "		) "
				   + "WHERE rnum BETWEEN ? AND ? ";

	List<Member> list = new ArrayList<Member>();

	int startrow = (page - 1) * limit + 1;
	int endrow = startrow + limit - 1;
	try (Connection con = ds.getConnection();
		 PreparedStatement pstmt = con.prepareStatement(sql);) {

		pstmt.setInt(1, pnum);
		pstmt.setInt(2, startrow);
		pstmt.setInt(3, endrow);

		try (ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				Member m = new Member();
				m.setP_num(rs.getInt("p_num"));
				m.setNum(rs.getInt("p_num"));
				m.setGrade(rs.getString("grade"));
				m.setM_id(rs.getString("M_id"));
				m.setM_name(rs.getString("M_name"));
				m.setM_pic(rs.getString("M_pic"));
				m.setM_tel(rs.getString("M_tel"));
				m.setM_email(rs.getString("M_email"));
				list.add(m);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	} catch (Exception ex) {
		ex.printStackTrace();
		System.out.println("getMemberList() 에러 : " + ex);
	}

	return list;
	}

	/* 혜원 */
	public int outproject(int userNum, int projectNum) {
	    int result = 0;
	    String sql = "DELETE FROM MEMBER WHERE num = ? AND p_num = ?";
	    try (Connection con = ds.getConnection();
	         PreparedStatement pstmt = con.prepareStatement(sql);) {
	         pstmt.setInt(1, userNum);
	         pstmt.setInt(2, projectNum);
	         result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	public List<Usr> searchid() {
		
		   String sql = "SELECT * FROM USR";
		    List<Usr> usrList = new ArrayList<>();
		    try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
		        try (ResultSet rs = pstmt.executeQuery()) {
		            while (rs.next()) {
		            	Usr m = new Usr();
		            	m.setNum(rs.getInt("num"));
		            	m.setId(rs.getString("id"));
		            	m.setName(rs.getString("name"));
		            	m.setEmail(rs.getString("email"));
		            	m.setPic(rs.getString("pic"));
		            	m.setTel(rs.getString("tel"));
		            	usrList.add(m);
		            }
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return usrList;
	}

	public int getUserNum(String uID) {
		
		int result = 0;

		String sql = "SELECT num " 
				   + "FROM usr " 
				   + "WHERE id = ?";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, uID);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					result = rs.getInt(1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println("getUserNum() 에러: " + ex);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getUserNum() 에러: " + e);
		}

		return result;
	}

	public int memInvite(int p_num, int uNum) {
		
		int result = 0;
		
		String sql = "INSERT INTO MEMBER "
				   + "(p_num, num, m_id, M_name, M_pic, M_tel, M_email) "
				   + "SELECT ?, ?, id, name, pic, tel, email FROM USR WHERE num=?";
		
		 try (Connection con = ds.getConnection();
		      PreparedStatement pstmt = con.prepareStatement(sql);) {
			 
			 pstmt.setInt(1, p_num);
			 pstmt.setInt(2, uNum);
			 pstmt.setInt(3, uNum);
			 
			 result = pstmt.executeUpdate();
			 
		 } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return result;
	}

	public boolean isUserInProject(int p_num, int num) {
		
	    boolean result = false;

	    String sql = "SELECT * FROM MEMBER WHERE p_num=? AND num=?";

	    try (Connection con = ds.getConnection();
	        PreparedStatement pstmt = con.prepareStatement(sql);) {

	        pstmt.setInt(1, p_num);
	        pstmt.setInt(2, num);

	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            result = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}
	
	
}
