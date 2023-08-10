package net.comment.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.google.gson.JsonArray;

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
				   + " values(com_seq.nextval,?,?,?,sysdate,?,?,0,0,com_seq.nextval)";
		
		try(Connection con = ds.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, co.getNum());
			pstmt.setString(2, co.getC_id());
			pstmt.setString(3, co.getC_content());
			pstmt.setInt(4, co.getComment_i_num());
			pstmt.setInt(5, co.getComment_p_num());
			result = pstmt.executeUpdate();
			if(result ==1) {
				System.out.println("데이터 삽입 완료");
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	} //commentsInsert end
	
	
	public int getListCount(int repy_issue_num) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	public JsonArray getCommentList(int comment_issue_num, int state) {
		// TODO Auto-generated method stub
		return null;
	}

}
