package net.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class CommentDAO {
	private DataSource ds;

	public CommentDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 : " + ex);
		}

	}
	public int commentsInsert(Comment co) {
		int result = 0;
		String sql = "insert into comm "
				+ "(c_num, c_id, c_content, reg_date, comment_i_num, "
				+ "comment_re_lev, comment_re_seq, comment_re_ref)"
				+ " values(com_seq.nextval,?,?,sysdate,?,0,0,com_seq.nextval)";

		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){

			//			pstmt.setInt(1, co.getNum());
			pstmt.setString(1, co.getC_id());
			pstmt.setString(2, co.getC_content());
			pstmt.setInt(3, co.getComment_i_num());
			//			pstmt.setInt(4, co.getComment_p_num());
			result = pstmt.executeUpdate();
			if(result ==1) {
				System.out.println("데이터 삽입 완료");
			}

		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	} //commentsInsert end


	public int getListCount(int comment_i_num) {
		int x = 0;
		String sql = "select count(*) "
				+ "from comm "
				+ "where comment_i_num = ? ";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){

			pstmt.setInt(1,comment_i_num);

			try(ResultSet rs= pstmt.executeQuery()){
				if(rs.next()) {
					x = rs.getInt(1);
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();

		}
		return x;
	}

	public JsonArray getCommentList(int comment_i_num, int state) {
		String sort="asc"; //등록순
		if(state==2) {//최신순
			sort = "desc";
		}
		String sql = " select c_num, comm.c_id, comm.c_content, reg_date, comment_i_num, comment_re_lev, "
				+ "		  comment_re_seq,"
				+ "		  comment_re_ref, usr.pic"
				+ "	from  comm join usr"
				+ "	on    comm.c_id=usr.id "
				+ " where comment_i_num = ?"
				+ " order by comment_re_ref " + sort + " , "
				+ "	 	  comment_re_seq asc";
		JsonArray array = new JsonArray();
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){

			pstmt.setInt(1,  comment_i_num);
			try(ResultSet rs = pstmt.executeQuery()){

				while(rs.next()) {
					JsonObject object = new JsonObject();
					object.addProperty("c_num", rs.getInt(1));
					//					object.addProperty("num", rs.getInt(2));
					object.addProperty("c_id", rs.getString(2));
					object.addProperty("c_content", rs.getString(3));
					object.addProperty("reg_date", rs.getString(4));
					object.addProperty("comment_i_num", rs.getInt(5));
					object.addProperty("comment_re_lev", rs.getInt(6));
					object.addProperty("comment_re_seq", rs.getInt(7));
					object.addProperty("comment_re_ref", rs.getInt(8));
					object.addProperty("pic", rs.getString(9));
					array.add(object);
				}
			}
		}catch(Exception ex) {
			System.out.println("getCommentList()에러 " + ex);
		}
		return array;
	}//getCommentList()메서드 end

	public int commentsUpdate(Comment co) {
		int result =0;
		String sql = "update comm "
				   + " set c_content= ? "
				   + "where comment_i_num =? ";
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, co.getC_content());
			pstmt.setInt(2, co.getComment_i_num());
			
			result = pstmt.executeUpdate();
			if(result == 1)
				System.out.println("데이터 수정 되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}//commentsUpdate()메서드
	
	public int commentsReply(Comment co) {
		int result =0;
		
		try(Connection con = ds.getConnection();){
			con.setAutoCommit(false);
			
			try { 
				reply_update(con, co.getComment_re_ref(), co.getComment_re_seq());
				result=reply_insert(con, co);
				con.commit();
				con.setAutoCommit(true);
			}
			catch(Exception e) {
				if(con !=null) {
					try {
						con.rollback();//rollback합니다
					} catch(SQLException ex) {
						ex.printStackTrace();
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}
	
	private int reply_insert(Connection con, Comment co) throws Exception {
		int result = 0;
		String sql = "insert into comm "
				   + " values(com_seq.nextval, ?, ?, sysdate, ?,?,?,?)";
		try(PreparedStatement pstmt = con.prepareStatement(sql);){
			pstmt.setString(1, co.getC_id());
			pstmt.setString(2, co.getC_content());
			pstmt.setInt(3, co.getComment_i_num());
			pstmt.setInt(4, co.getComment_re_lev()+1);
			pstmt.setInt(5, co.getComment_re_seq()+1);
			pstmt.setInt(6, co.getComment_re_ref());
			result = pstmt.executeUpdate();
		}
		return result;
	}
	
	private void reply_update(Connection con, int comment_re_ref, int comment_re_seq)throws Exception {
		String update_sql = "update comm "
		          + "set     comment_re_seq=comment_re_seq+1 "
		          + "where   comment_re_ref = ? "
		          + "and     comment_re_seq > ? ";
		try(PreparedStatement pstmt = con.prepareStatement(update_sql);){
			pstmt.setInt(1, comment_re_ref);
			pstmt.setInt(2, comment_re_seq);
			pstmt.executeUpdate();
		}
		
	}

	public int commentsDelete(int c_num) {
		int result = 0;

		String sql = "delete comm where c_num = ?";
		try (Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){

			pstmt.setInt(1, c_num);
			result = pstmt.executeUpdate();
			if(result == 1) System.out.println("댓글 삭제 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}
}