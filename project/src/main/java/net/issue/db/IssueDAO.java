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

   // 글 목록 보기
   public List<IssueBean> getIssuedList(int pnum, int page, int limit) {

      // page : 페이지
      // limit : 페이지 당 목록의 수
      // issue_re_ref desc, issue_re_seq asc에 의해 정렬한 것을
      // 조건절에 맞는 rnum의 범위 만큼 가져오는 쿼리문입니다.

      // 프로젝트 넘버
      List<IssueBean> list = new ArrayList<IssueBean>();
      // 한 페이지당 10개씩 목록인 경우 1페이지, 2페이지, 3페이지, 4페이지...
      String issue_list_sql = "SELECT * "
                       + " FROM ( SELECT ROWNUM rnum, i.* "
                       + "       FROM issue i "
                       + "        join project p on i.p_num = p.p_num "
                       + "       where p.p_num = ?"
                       + "       order by i.i_seq desc "
                       + "      ) "
                       + "WHERE rnum BETWEEN ? AND ?";
      //해당 프로젝트에 해당하는 게시글만 가져오기 위해 p_num을 넣어야 하는데, 어디에 넣느냐

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
               issue.setI_name(rs.getString("I_name"));
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

   public boolean issueInsert(IssueBean issuedata, String name, int projectNum) {
      
      String sql = "INSERT INTO issue "
                 + "(i_seq, i_NAME, i_title, i_CONTENT, i_readcount, p_num)"
                 + " values(i_seq.nextval, ?, ?, ?, ?, ?)";

      int result = 0;
      
      try {
          Connection con = ds.getConnection();
          PreparedStatement pstmt = con.prepareStatement(sql);

          pstmt.setString(1, name);
          pstmt.setString(2, issuedata.getI_title());
          pstmt.setString(3, issuedata.getI_content());
          pstmt.setInt(4, 0);
          pstmt.setInt(5, projectNum);

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
      String sql = "   select * from issue" 
               + "   where i_seq =?";
      try (Connection con = ds.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
         pstmt.setInt(1, num);
         try (ResultSet rs = pstmt.executeQuery()) {

            // DB에서 가져온 데이터를 issueBean에 담습니다.
            if (rs.next()) {
               
               issue.setI_seq(rs.getInt("I_SEQ")); 
               issue.setI_name(rs.getString("I_name"));
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
            }

         } catch (SQLException e) {
            e.printStackTrace();
         }
      } catch (Exception ex) {
         System.out.println("getDetail()에러: " + ex);
      }
      return issue;
   }//getDetail()메서드 end

   //   public boolean isissueWriter(int num, String pass) {
   //      boolean result = false;
   //      String issue_sql = "select issue_pass from issue where issue_num=?";
   //      try(Connection con = ds.getConnection();
   //         PreparedStatement pstmt = con.prepareStatement(issue_sql);) {
   //         pstmt.setInt(1, num);
   //         try (ResultSet rs = pstmt.executeQuery()){
   //            if(rs.next()) {
   //               if(pass.equals(rs.getString("issue_pass"))) {
   //               result=true;
   //            }
   //            }
   //         }catch (SQLException e) {
   //            e.printStackTrace();
   //         }
   //      }catch(SQLException ex) {
   //         System.out.println("isissueWriter()에러 : " + ex);
   //      }
   //      return result;
   //   }//isissueWriter end
   //
   public boolean issueModify(IssueBean modifyissue) {
      /*
       * String sql = "update issue " +
       * "set issue_subject=?, issue_content=?, issue_file=? " + "where issue_num=? ";
       */

      String sql = "update issue "
            + "set issue_subject=?, issue_content=? "
            + "where issue_num=? ";
      try(Connection con = ds.getConnection();
            PreparedStatement pstmt = con.prepareStatement(sql);) {
         pstmt.setString(1, modifyissue.getI_title());
         pstmt.setString(2, modifyissue.getI_content());
         /* pstmt.setString(3, modifyissue.getissue_file()); */
         pstmt.setInt(3, modifyissue.getI_seq());
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
      String select_sql = "select * from issue "
            + " where I_NUM=? and p_num = ?";

      String issue_delete_sql = "delete from issue " 
            + " where issue_NUM=? and p_num = ?";
      //답글이 없으니, issue num에 해당하는 값과, 해당 글이 속한 프로젝트에 있는 게시글을 지운다
      int result_check = 0;

      try(Connection con = ds.getConnection();
            PreparedStatement pstmt = con.prepareStatement(select_sql);){ //1

         pstmt.setInt(1, num);
         try(ResultSet rs = pstmt.executeQuery();){//2
            if(rs.next()) {
               try(PreparedStatement pstmt2 = con.prepareStatement(issue_delete_sql)){//3
                  pstmt2.setInt(1, rs.getInt("I_num"));
                  pstmt2.setInt(2, rs.getInt("p_num"));
                  pstmt2.setInt(3, rs.getInt("I_num"));
                  pstmt2.setInt(4, rs.getInt("p_num"));
                  
                  int count = pstmt2.executeUpdate();
                  if(count >=1)
                     result_check = 1; //삭제가 안될 경우 false 반환

               }//try 3
            }//if (rs.next()) {
         }//try 2

      }catch(Exception e){
         System.out.println("issueDelete()에러 : " +  e);
         e.printStackTrace();
      }
      return result_check;
   }//issueDelete()메서드 end

}//class end