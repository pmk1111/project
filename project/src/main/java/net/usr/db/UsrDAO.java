package net.usr.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UsrDAO {
	private DataSource ds;

	public UsrDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");

		} catch (Exception ex) {
			System.out.println("DB연결 실패 : " + ex);
		}
	}

	public Usr usr_info(String id) {
		Usr u = null;
		String sql = "select * from usr where id = ? ";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					u = new Usr();
					u.setNum(rs.getInt(1));
					u.setId(rs.getString(2));
					u.setPass(rs.getString(3));
					u.setEmail(rs.getString(4));
					u.setName(rs.getString(5));
					u.setPic(rs.getString(6));
					u.setTel(rs.getString(7));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u;
	}

	public int update(Usr u) {
		int result = 0;
		String sql = "update usr " 
		           + "set pic = ?, pass = ?, email = ? , name = ?, tel = ? " 
				   + "where id = ? ";

		try (Connection con = ds.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, u.getPic());
			pstmt.setString(2, u.getPass());
			pstmt.setString(3, u.getEmail());
			pstmt.setString(4, u.getName());
			pstmt.setString(5, u.getTel());
			pstmt.setString(6, u.getId());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		}
		return result;
	}

	public int isId(String id) {
		int result = -1; // DB에 해당 id가 없습니다.
		String sql = "select id from usr where id= ? ";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					result = 0; // DB에 해당 id가 있습니다.
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	} // isId end

	public int insert(Usr u) {

		int result = 0; // DB에 해당 id가 없습니다.
		String sql = "INSERT INTO usr (num, id, pass, email, name, pic, tel, status) "
				+ " VALUES(usr_seq.nextval, ?, ?, ?, ?, ?, ?, 0)";

		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {

			pstmt.setString(1, u.getId());
			pstmt.setString(2, u.getPass());
			pstmt.setString(3, u.getEmail());
			pstmt.setString(4, u.getName());
			pstmt.setString(5, u.getPic());
			pstmt.setString(6, u.getTel());

			result = pstmt.executeUpdate(); // 삽입성공시 result는 1

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int isId(String id, String pass) {
		int result = -1;// 아이디가 존재하지 않습니다.
		String sql = "select id, pass from usr where id = ? ";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					if (rs.getString(2).equals(pass)) {
						result = 1; // 아이디와 비밀번호가 일치하지 않는 경우
					} else {
						result = 0; // 비밀번호가 일치하지 않는 경우
					}
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	} // isId end

	public int deleteId(String id) {
	    
		int result = 0;

	    String sql = "delete from usr where id = ? ";
	    try (Connection con = ds.getConnection(); 
	    		PreparedStatement pstmt = con.prepareStatement(sql);) {
	        pstmt.setString(1, id);
	        try (ResultSet rs = pstmt.executeQuery()) {
	        	if(rs.next()) {
		              result = 1;
	                    }
	        }catch(SQLException e) {
	        	e.printStackTrace();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}//deleteId



}
