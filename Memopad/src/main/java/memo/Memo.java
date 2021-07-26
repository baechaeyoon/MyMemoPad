package memo;

public class Memo {
	int memoID;
	String userID;	// 사용자 아이디
	String memoDivide;	// 그룹 분류
	String memoTitle;	// 메모 제목
	String memoContent;	// 메모 내용
	String totalScore;	// 점수
	String importantScore;	// 중요도
	String memoURL;
	String memoImg;
	
	public Memo() {
		
	}
	
	public Memo(int memoID, String userID, String memoDivide, String memoTitle, String memoContent,
			String totalScore, String importantScore, String memoURL, String memoImg) {
		super();
		this.memoID = memoID;
		this.userID = userID;
		this.memoDivide = memoDivide;
		this.memoTitle = memoTitle;
		this.memoContent = memoContent;
		this.totalScore = totalScore;
		this.importantScore = importantScore;
		this.memoURL = memoURL;
		this.memoImg = memoImg;
	}
	
	public Memo(String userID) {
		this.userID = userID;
	}
	
	public int getMemoID() {
		return memoID;
	}

	public void setMemoID(int memoID) {
		this.memoID = memoID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getMemoDivide() {
		return memoDivide;
	}

	public void setMemoDivide(String memoDivide) {
		this.memoDivide = memoDivide;
	}

	public String getMemoTitle() {
		return memoTitle;
	}

	public void setMemoTitle(String memoTitle) {
		this.memoTitle = memoTitle;
	}

	public String getMemoContent() {
		return memoContent;
	}

	public void setMemoContent(String memoContent) {
		this.memoContent = memoContent;
	}

	public String getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}

	public String getImportantScore() {
		return importantScore;
	}

	public void setImportantScore(String importantScore) {
		this.importantScore = importantScore;
	}
	
	public String getMemoURL() {
		return memoURL;
	}

	public void setMemoURL(String memoURL) {
		this.memoURL = memoURL;
	}
	
	public String getMemoImg() {
		return memoImg;
	}

	public void setMemoImg(String memoImg) {
		this.memoImg = memoImg;
	}
}