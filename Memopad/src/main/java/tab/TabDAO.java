package tab;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import memo.Memo;
import user.User;
import util.DatabaseUtil;


public class TabDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// 옵션 값으로 불러올 탭 리스트
	public ArrayList<Tab> getList(String userID, String tabName) {	
		ArrayList<Tab> tabList = null;
		String sql = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, tabName);
			rs = pstmt.executeQuery();
			tabList = new ArrayList<Tab>();
			while(rs.next()) {
				Tab tab = new Tab(
						rs.getString(1),
						rs.getString(2)
				);
				tabList.add(tab);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return tabList;	// DB 오류
	}
	
	public void tabList(String userID) {
	      // db에서 정보 얻어와 테이블에 출력하기
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      try {
				conn = DatabaseUtil.getConnection();
			    String sql = "SELECT tabName FROM TAB WHERE userID = ? GROUP BY tabName ORDER BY tabName;";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
	       while (rs.next()) {
	    	   String tabName = rs.getString("tabName");
	        }
	      } catch (Exception e) {
	    	  System.out.println(e.getMessage());
	      } finally {
	       try {
	        if (rs != null)
	        	rs.close();
	        if (pstmt != null)
	        	pstmt.close();
	        if (con != null)
	        	con.close();
	       } catch (Exception e) {
	    	   System.out.println(e.getMessage());
	       }

	      }
	}
	
	// 카테고리 추가 함수
	public int add (String userID, String tabName) {	
		String sql = "INSERT INTO TAB VALUES(?, ?);";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, tabName);
			return pstmt.executeUpdate();
		} catch(Exception e) {	// 예외 처리
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1;	// DB 오류
	}
	
	// 카테고리 삭제 함수
	public int delete(String userID, String tabName) {	
		String sql = "DELETE FROM TAB WHERE userID = ? AND tabName = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, tabName);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return -1; 
	}
	
	// 카테고리 이름 불러오는 함수
	public ArrayList<Tab> getTabNameList(String userID) {	
		ArrayList<Tab> tabList = new ArrayList<Tab>();
		String sql = "SELECT tabName FROM tab WHERE userID=?;";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Tab tab = new Tab();
				tab.setTabName(rs.getString(1));
				
				tabList.add(tab);
			}
			
			
		} catch(Exception e) {	// 예외 처리
			e.printStackTrace();
		} finally {
			try { if(conn != null) conn.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(pstmt != null) pstmt.close(); }
			catch (Exception e) { e.printStackTrace(); }
			try { if(rs != null) rs.close(); }
			catch (Exception e) { e.printStackTrace(); }
		}
		return tabList; 
	}
	
}