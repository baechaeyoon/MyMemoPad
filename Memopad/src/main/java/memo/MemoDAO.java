package memo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class MemoDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 메모 쓴 것 DB에 저장하는 함수
	public int write (Memo memo) {	
		String sql = "INSERT INTO MEMOTABLE VALUES(NULL, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, memo.getMemoDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, memo.getMemoTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(4, memo.getMemoContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			pstmt.setString(5, memo.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, memo.getImportantScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, memo.getMemoURL().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
			pstmt.setString(8, memo.getMemoImg().replaceAll("<", "&lt;").replaceAll(">", "&gt;"));
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
	
	// DB에서 화면으로 메모 목록 띄우는 함수
	public ArrayList<Memo> getList(String memoDivide, String userID, String searchType, String search, int pageNumber) {	
		if(memoDivide.equals("전체") ) 
			memoDivide = "";
		ArrayList<Memo> memoList = null;
		String sql = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("최신순")) {
				sql = "SELECT * FROM MEMOTABLE WHERE userID = ? AND memoDivide LIKE ? AND CONCAT(memoTitle, memoContent) LIKE ? ORDER BY memoID DESC;";
			} else if (searchType.equals("중요도순")) {
				sql = "SELECT * FROM MEMOTABLE WHERE userID = ? AND memoDivide LIKE ? AND CONCAT(memoTitle, memoContent) LIKE ? ORDER BY importantScore DESC;";
			} else if (searchType.equals("평가점수순")) {
				sql = "SELECT * FROM MEMOTABLE WHERE userID = ? AND memoDivide LIKE ? AND CONCAT(memoTitle, memoContent) LIKE ? ORDER BY totalScore DESC;";
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, "%" + memoDivide + "%");
			pstmt.setString(3, "%" + search + "%");
			rs = pstmt.executeQuery();
			memoList = new ArrayList<Memo>();
			while(rs.next()) {
				Memo memo = new Memo(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getString(7),
						rs.getString(8),
						rs.getString(9)
					);
				memoList.add(memo);
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
		return memoList;	// DB 오류
	}
	
	// DB에서 메모 삭제 함수
	public int delete(String memoID) {	
		String sql = "DELETE FROM MEMOTABLE WHERE memoID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(memoID));
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
	
	public String getUserID(String memoID) {	// 사용자 아이디 읽어오는 함수
		String sql = "SELECT userID FROM MEMOTABLE WHERE memoID = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(memoID));
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getString(1);
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
		return null; 
	}
	
	public Memo getBBS(int MemoID) {	
		String SQL = "SELECT * FROM MEMOTABLE WHERE memoID = ? ";
		Memo memo = new Memo();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try { 
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, MemoID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				memo.setMemoID(rs.getInt(1));
				memo.setUserID(rs.getString(2));
				memo.setMemoDivide(rs.getString(3));
				memo.setMemoTitle(rs.getString(4));
				memo.setMemoContent(rs.getString(5));
				memo.setTotalScore(rs.getString(6));
				memo.setImportantScore(rs.getString(7));
				memo.setMemoURL(rs.getString(8));
				memo.setMemoImg(rs.getString(9));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memo;
	}
	
	// 수정할 때 유저와 메모 아이디 비교하기 위한 함수
	public Memo WriterCheck(int memoID) {
		String sql = "SELECT userID FROM MEMOTABLE WHERE memoID = ?";
		Memo memo = new Memo();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,memoID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				memo = new Memo(rs.getString(1));
				return memo;
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
		return null; 
	}
	
	// 수정 함수
	public int update(Memo memo) {
		// 특정 memoID에 해당하는 내용 바꾸기
		String sql = "UPDATE MEMOTABLE SET memoTitle = ?, memoContent = ?, memoDivide = ?, totalScore = ?, importantScore = ?, memoURL = ?, memoImg = ? WHERE memoID = ?;";
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memo.getMemoTitle()); // 게시글 제목
			pstmt.setString(2, memo.getMemoContent()); // 게시글 내용
			pstmt.setString(3, memo.getMemoDivide()); // 게시글 분류
			pstmt.setString(4, memo.getTotalScore()); 
			pstmt.setString(5, memo.getImportantScore());
			pstmt.setString(6, memo.getMemoURL());
			pstmt.setString(7, memo.getMemoImg());
			pstmt.setInt(8, memo.getMemoID()); // 게시글 번호
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류발생
	}
	
	// 구분별 갯수 구하기
	public int countDivide(String divide) {
		String sql = "SELECT COUNT(*) FROM memotable WHERE memoDivide = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, divide);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류발생
	}
}