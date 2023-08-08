package net.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	private DataSource ds;

	// 생성자에서 JNDI 리소스를 참조하여 Connection 객체를 얻어옵니다.
	public BoardDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		} catch (Exception ex) {
			System.out.println("DB 연결 실패 :" + ex);
		}
	}

	// 글의갯수 구하기
	public int getListCount() {
		String sql = "select count(*) from board";
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

	// 글 목록 보기
	public List<BoardBean> getBoardList(int page, int limit) {

		// page : 페이지
		// limit : 페이지 당 목록의 수
		// board_re_ref desc, board_re_seq asc에 의해 정렬한 것을
		// 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.


	
		
		List<BoardBean> list = new ArrayList<BoardBean>();
		// 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
		String board_list_sql = "SELECT * FROM (" 
		                       + "SELECT ROWNUM rnum, j.* FROM ("
		                       + "    SELECT board.*, NVL(cnt, 0) cnt "
		                       + "    FROM board "
		                       + "    LEFT OUTER JOIN ("
		                       + "        SELECT comment_board_num, COUNT(*) cnt " 
		                       + "        FROM comm "
		                       + "        GROUP BY comment_board_num"
		                       + "    ) ON board_num = comment_board_num "
		                       + "    ORDER BY board_re_ref DESC, board_re_seq ASC" 
		                       + ") j WHERE ROWNUM <= ?"
		                       + ") WHERE rnum >= ? AND rnum <= ?";
		/*
		 * String board_list_sql = "SELECT * FROM (" + "SELECT ROWNUM rnum, j.* FROM ("
		 * + "    SELECT board.*, NVL(cnt, 0) cnt " + "    FROM board " +
		 * " WHERE rnum >= ? AND rnum <= ?";
		 */
		
		/*String board_list_sql = " select * from board order by board_num desc ";*/
	int startrow = (page - 1) * limit + 1; // 읽기 시작할 row 번호 (1 11 21 31 ...
	int endrow = startrow + limit - 1; // 읽을 마지막 row 번호 (10 20 30 40 ...
	try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(board_list_sql);) {
		pstmt.setInt(1, endrow);
		pstmt.setInt(2, startrow);
		pstmt.setInt(3, endrow);

			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 BoardBean에 담습니다.
				while (rs.next()) {
					BoardBean board = new BoardBean();
					 board.setBoard_num(rs.getInt("BOARD_NUM")); 
					board.setBoard_name(rs.getString("BOARD_NAME"));
					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
					board.setBoard_content(rs.getString("BOARD_CONTENT"));
					
					
					  board.setBoard_file(rs.getString("BOARD_FILE"));
					  board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
					  board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
					  board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
					 
					  board.setBoard_date(rs.getString("BOARD_DATE"));
					  board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
						 board.setCnt(rs.getInt("cnt")); 
					 
					list.add(board); // 값을 담은 객체를 리스트에 저장합니다.
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

	public boolean boardInsert(BoardBean boarddata) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
	String max_sql = "(select nvl(max(board_num),0)+1 from board)";

	
	  String sql = "INSERT INTO board " + "(BOARD_NUM, BOARD_NAME, BOARD_SUBJECT,"
	  + " BOARD_CONTENT, BOARD_RE_REF," +
	  " BOARD_RE_LEV, BOARD_RE_SEQ,BOARD_READCOUNT)" + " values(" + max_sql +
	  ",?,?," + "        ?," + max_sql + "," + "		   ?,?,?)";
	 
	
	
		//String sql="INSERT INTO testBoard (BOARD_TITLE) VALUES(?)";
		/*
		 * String sql = "INSERT INTO ISSUE "
		 * +"(I_NUM,I_TITLE,WRITER,I_CONTENT,I_STATUS,"
		 */
				
	try {
		con = ds.getConnection();

		pstmt = con.prepareStatement(sql);
		
		

			pstmt.setString(1, boarddata.getBoard_name());
			pstmt.setString(2, boarddata.getBoard_subject());
			pstmt.setString(3, boarddata.getBoard_content());
			//pstmt.setString(5, boarddata.getBoard_file());
			pstmt.setInt(4, 0);
			pstmt.setInt(5, 0);
			pstmt.setInt(6, 0);
			

			result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("데이터 삽입이 모두 완료되었습니다.");
				return true;
			}
		} catch (Exception ex) {
			System.out.println("boardInsert()에러: " + ex);
			ex.printStackTrace();
		}
		return false;

	}// boardInsert()메서드 end

	/*
	 * public void setReadCountUpdate(int num) { String sql = "update board " +
	 * "set board_readcount = board_readcount+1 " + "where board_num=?"; try
	 * (Connection con = ds.getConnection(); PreparedStatement pstmt =
	 * con.prepareStatement(sql);) { pstmt.setInt(1, num); pstmt.executeUpdate(); }
	 * catch (Exception ex) { System.out.println("setReadCountUpdate()에러: " + ex); }
	 * }
	 */

	public BoardBean getDetail(int num) {
		BoardBean board = null;
		String sql = "	select * from board" 
					+ "		where board_num =?";
		try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setInt(1, num);
			try (ResultSet rs = pstmt.executeQuery()) {

				// DB에서 가져온 데이터를 BoardBean에 담습니다.
				if (rs.next()) {
					board = new BoardBean();
					board.setBoard_num(rs.getInt("BOARD_NUM"));
					board.setBoard_name(rs.getString("BOARD_NAME"));
					board.setBoard_subject(rs.getString("BOARD_SUBJECT"));
					board.setBoard_content(rs.getString("BOARD_CONTENT"));
					board.setBoard_file(rs.getString("BOARD_FILE"));
					board.setBoard_re_ref(rs.getInt("BOARD_RE_REF"));
					board.setBoard_re_lev(rs.getInt("BOARD_RE_LEV"));
					board.setBoard_re_seq(rs.getInt("BOARD_RE_SEQ"));
					board.setBoard_readcount(rs.getInt("BOARD_READCOUNT"));
					board.setBoard_date(rs.getString("BOARD_DATE"));
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (Exception ex) {
			System.out.println("getDetail()에러: " + ex);
		}
		return board;
	}//getDetail()메서드 end

//	public boolean isBoardWriter(int num, String pass) {
//		boolean result = false;
//		String board_sql = "select board_pass from board where board_num=?";
//		try(Connection con = ds.getConnection();
//			PreparedStatement pstmt = con.prepareStatement(board_sql);) {
//			pstmt.setInt(1, num);
//		   try (ResultSet rs = pstmt.executeQuery()){
//			   if(rs.next()) {
//				   if(pass.equals(rs.getString("board_pass"))) {
//				   result=true;
//			   }
//		   	}
//		   }catch (SQLException e) {
//			   e.printStackTrace();
//		   }
//		}catch(SQLException ex) {
//			System.out.println("isBoardWriter()에러 : " + ex);
//		}
//		return result;
//	}//isBoardWriter end
//
	public boolean boardModify(BoardBean modifyboard) {
		/*
		 * String sql = "update board " +
		 * "set board_subject=?, board_content=?, board_file=? " + "where board_num=? ";
		 */
		
		String sql = "update board "
				 + "set board_subject=?, board_content=? "
				 + "where board_num=? ";
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, modifyboard.getBoard_subject());
			pstmt.setString(2, modifyboard.getBoard_content());
			/* pstmt.setString(3, modifyboard.getBoard_file()); */
			pstmt.setInt(3, modifyboard.getBoard_num());
				int result = pstmt.executeUpdate();
				   if(result==1) {
					   System.out.println("성공 업데이트");
					   return true;
				   }
			   
			   }catch (Exception e) {
				  System.out.println("boardModift()에러: " + e);
			   }
			
			
			return false;
	}//boardModify()메서드 end
//
//	public int boardReply(BoardBean boarddata) {
//		int num = 0;
//		
//		/*
//		 * 답변을 달 원문 글 그룹 번호
//		 * 답변을 달게 되면 답변 글은 이 번호와 같은 관련글 번호를 갖게 처리되면서 같은 그룹에 속하게 됨
//		 * 글 목록에서 보여줄 때 하나의 그룹으로 묶여서 출력
//		 */
//		int re_ref = boarddata.getBoard_re_ref();
//		
//		/*
//		 * 답글의 깊이 의미
//		 * 원문에 대한 답글이 출력될 때 한 번 들여쓰기 처리가 되고 답글에 대한 답글은 들여쓰기가 두 번 처리되게 함
//		 * 원문인 경우에는 이 값이 0이고 원문의 답글은 1, 답글의 답글은 2가 됨
//		 */
//		int re_lev = boarddata.getBoard_re_lev();
//		
//		//같은 관련 글 중에서 해당 글이 출력되는 순서
//		int re_seq = boarddata.getBoard_re_seq();
//		try(Connection con = ds.getConnection();){
//			
//			//트랜잭션을 이용하기 위해 setAutoCommit을 false로 설정합니다.
//			con.setAutoCommit(false);
//			
//			try {
//				reply_update(con,re_ref,re_seq);
//				
//				//등록할 답변 글의 BOARD_RE_LEV, BOARD_RE_SEQ 값을 원문 글보다 1씩 증가시킵니다.
//				num = reply_insert(con, boarddata, re_ref, re_lev+1, re_seq+1);
//				con.commit();
//				con.setAutoCommit(true);
//			}
//			catch(Exception e) {
//				
//				if(con !=null) {
//					try {
//						con.rollback();//rollback합니다.
//					} catch (Exception ex) {
//						ex.printStackTrace();
//						
//					}
//				}
//			}
//		} catch(Exception ex) {
//			ex.printStackTrace();
//			System.out.println("boardReply()에러 : " + ex);
//		}
//		return num;
//		
//	}//boardReply() end
//
//	private void reply_update(Connection con, int re_ref, int re_seq) throws Exception {
//		// BOARD_RE_REF, BOARD_RE_SEQ 값을 확인하여 원문 글에 답글이 달려있다면
//		// 달린 답글들의 BOARD_RE_SEQ값을 1씩 증가시킵니다.
//		// 현재 글을 이미 달린 답글보다 앞에 출력되게 하기 위해서 입니다.
//		
//		String sql = "update board "
//				   + "set board_re_seq = board_re_seq+1 "
//				   + "where board_re_ref = ? "
//				   + "and board_re_seq > ? ";
//		
//		try(PreparedStatement pstmt = con.prepareStatement(sql);){
//			pstmt.setInt(1, re_ref);
//			pstmt.setInt(2, re_seq);
//			pstmt.executeUpdate();
//		}
//		
//	}//reply_update end
//	private int reply_insert(Connection con, BoardBean boarddata, 
//							int re_ref, int re_lev, int re_seq) throws Exception {
//		int num = 0;
//		String board_max_sql = "(select max(board_num)+1 from board)";
//		try(PreparedStatement pstmt = con.prepareStatement(board_max_sql);){
//			try(ResultSet rs = pstmt.executeQuery()){
//				if(rs.next()) {
//					num=rs.getInt(1);
//				}
//			}
//		}
//		
//		String sql = "insert into board "
//				   + "(board_num, board_name, board_pass, board_subject, "
//				   + "board_content, board_file, board_re_ref, "
//				   + "board_re_lev, board_re_seq, board_readcount) "
//				   + "values(?,?,?,?,"
//				   + "   ?,?,?,"
//				   + "   ?,?,?)";
//		try(PreparedStatement pstmt = con.prepareStatement(sql);){
//			pstmt.setInt(1, num);
//			pstmt.setString(2, boarddata.getBoard_name());
//			pstmt.setString(3, boarddata.getBoard_pass());
//			pstmt.setString(4, boarddata.getBoard_subject());
//			pstmt.setString(5, boarddata.getBoard_content());
//			pstmt.setString(6, ""); //답변에는 파일을 업로드하지 않음
//			pstmt.setInt(7, re_ref); //원문의 글번호
//			pstmt.setInt(8, re_lev);
//			pstmt.setInt(9, re_seq);
//			pstmt.setInt(10,0);// BOARD_READCOUNT(조회수)는 0
//			pstmt.executeUpdate();
//		}
//		return num;
//	}
//
	public int boardDelete(int num) {
		String select_sql = "select BOARD_RE_REF, BOARD_RE_LEV, BOARD_RE_SEQ "
						  + " from board "
						  + " where BOARD_NUM=?";
		
		String board_delete_sql = "delete from board " 
				+ "				where BOARD_RE_REF = ? " 
				+ "				and BOARD_RE_LEV >=? "
				+ "				and BOARD_RE_SEQ >=? " 
				+ "				and BOARD_RE_SEQ <= ( nvl((select min(board_re_seq)-1 " 
				+ 							"				from board "
				+ 							"				where BOARD_RE_REF=? " 
				+ 							"				and BOARD_RE_LEV =? " 
				+ 							"				and BOARD_RE_SEQ >?), "
				+ 							"				(select max(board_re_seq) " 
				+							"				from board " 
				+ 							"				where board_re_ref = ?)) " 
				+ 							"				)";
		int result_check = 0;
		
		try(Connection con = ds.getConnection();
			PreparedStatement pstmt = con.prepareStatement(select_sql);){ //1
			
			pstmt.setInt(1, num);
			try(ResultSet rs = pstmt.executeQuery();){//2
				if(rs.next()) {
					try(PreparedStatement pstmt2 = con.prepareStatement(board_delete_sql)){//3
						pstmt2.setInt(1, rs.getInt("BOARD_RE_REF"));
						pstmt2.setInt(2, rs.getInt("BOARD_RE_LEV"));
						pstmt2.setInt(3, rs.getInt("BOARD_RE_SEQ"));
						pstmt2.setInt(4, rs.getInt("BOARD_RE_REF"));
						pstmt2.setInt(5, rs.getInt("BOARD_RE_LEV"));
						pstmt2.setInt(6, rs.getInt("BOARD_RE_SEQ"));
						pstmt2.setInt(7, rs.getInt("BOARD_RE_REF"));
						int count = pstmt2.executeUpdate();
						if(count >=1)
							result_check = 1; //삭제가 안될 경우 false 반환
						
					}//try 3
				}//if (rs.next()) {
			}//try 2
			
		}catch(Exception e){
			System.out.println("boardDelete()에러 : " +  e);
			e.printStackTrace();
			}
		return result_check;
	}//boardDelete()메서드 end
	
}//class end
