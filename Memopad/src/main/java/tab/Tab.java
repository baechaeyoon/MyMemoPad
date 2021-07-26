package tab;

public class Tab {
	String userID;
	String tabName;
	
	public Tab() {
	}
	
	public Tab(String userID, String tabName) {
		super();
		this.userID = userID;
		this.tabName = tabName;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getTabName() {
		return tabName;
	}

	public void setTabName(String tabName) {
		this.tabName = tabName;
	}
}