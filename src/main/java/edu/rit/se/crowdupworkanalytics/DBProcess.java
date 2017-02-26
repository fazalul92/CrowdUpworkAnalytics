package edu.rit.se.crowdupworkanalytics;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.Random;
import java.util.Date;

public class DBProcess {

	private final Properties mProps = new Properties();

	private Connection mConn = null;

	public DBProcess() throws IOException, SQLException, ClassNotFoundException {
		if (mConn == null) {
			try (InputStream inStream = DBProcess.class.getResourceAsStream("/application.properties")) {
				mProps.load(inStream);
				Class.forName(mProps.getProperty("jdbc.driverClassName"));

				mConn = DriverManager.getConnection(mProps.getProperty("jdbc.url") + "?user="
						+ mProps.getProperty("jdbc.username") + "&password=" + mProps.getProperty("jdbc.password"));
			}
		}
	}

	public void disConnect() throws SQLException {
		if (mConn != null) {
			mConn.close();
			mConn = null; // close() does not set to null
		}
	}

	private String currentDateTIme() {
		java.util.Date dt = new java.util.Date();
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(dt);
	}

	public String timeDifference(Date startDate, Date endDate) {
		long different = endDate.getTime() - startDate.getTime();
		long secondsInMilli = 1000;
		long minutesInMilli = secondsInMilli * 60;
		long hoursInMilli = minutesInMilli * 60;
		long daysInMilli = hoursInMilli * 24;
		long elapsedDays = different / daysInMilli;
		different = different % daysInMilli;
		long elapsedHours = different / hoursInMilli;
		different = different % hoursInMilli;
		long elapsedMinutes = different / minutesInMilli;
		/*
		 * different = different % minutesInMilli; long elapsedSeconds =
		 * different / secondsInMilli;
		 *
		 *
		 * if(elapsedDays>0) ret = elapsedDays+" days, "+elapsedHours+" hours, "
		 * +elapsedMinutes+" minutes, "+elapsedSeconds+" seconds"; else ret =
		 * elapsedHours+" hours, "+elapsedMinutes+" minutes, "
		 * +elapsedSeconds+" seconds";
		 */
		String ret = "";
		if (elapsedDays > 0)
			ret = elapsedDays + " days, " + elapsedHours + " hours, " + elapsedMinutes + " minutes";
		else
			ret = elapsedHours + " hours, " + elapsedMinutes + " minutes";
		return ret;
	}

	public String timeSinceLogin(String uid) throws SQLException {
		String ret = "";
		try {
			Statement st = mConn.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select created_at from users where id=" + uid);
			rs.next();
			Timestamp timestamp = rs.getTimestamp("created_at");
			java.util.Date startDate = new java.util.Date(timestamp.getTime());
			java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date endDate = dateFormat.parse(currentDateTIme());
			ret = timeDifference(startDate, endDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	public int registerUser(String username) throws ClassNotFoundException, IOException, SQLException {
		int count = 0;
		String dtime = currentDateTIme();
		try {
			PreparedStatement statement = mConn
					.prepareStatement("INSERT INTO `users`(`username`, `created_at`) VALUES ('"
							+ username + "','" + dtime + "')");
			statement.executeUpdate();
			statement.close();
			Statement st = mConn.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where username='" + username + "'");
			if (rs.next()) {
				PreparedStatement statement2 = mConn
						.prepareStatement("INSERT INTO `batch_info`(`bid`,`uid`,`progress`) VALUES (0,"
								+rs.getInt("id")+ ",0);");
				statement2.executeUpdate();
				statement2.close();
				count = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public int loginUser(String username) throws ClassNotFoundException, IOException, SQLException {
		try {
			Statement st = mConn.createStatement();
			ResultSet rs;
			rs = st.executeQuery("select * from users where username='" + username + "'");
			if (rs.next()) {
				return rs.getInt("id");
			} else {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int addLog(int uid, String message) {
		int ret = 0;
		String dtime = currentDateTIme();
		try {
			PreparedStatement statement = mConn
					.prepareStatement("INSERT INTO `logs`(`uid`, `message`, `created_at`) VALUES ('" + uid + "','"
							+ message + "','" + dtime + "')");
			ret = statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public ResultSet getUser(String uid) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from users where id='" + uid + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public String[] updateState(String uid, String state) throws ClassNotFoundException, IOException, SQLException {
		String NewState = "";
		String[] ReturnVal = new String[2];
		try {
			ResultSet rs = null;
			ResultSet rs1 = null;
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select next_seq from statuses where seq_no='" + state + "'");
			rs.next();
			NewState = rs.getString("next_seq");
			ReturnVal[0] = NewState;
			rs1 = st.executeQuery("select filename from statuses where seq_no='" + NewState + "'");
			rs1.next();
			ReturnVal[1] = rs1.getString("filename");
			st = mConn.createStatement();
			String sql = "UPDATE users SET state = '" + NewState + "' WHERE id='" + uid + "'";
			st.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ReturnVal;
	}
	
	public String[] goToPreviousState(String uid, int state) {
		String NewState = "";
		String[] ReturnVal = new String[2];
		try {
			ResultSet rs = null;
			ResultSet rs1 = null;
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from statuses where seq_no<" + state + " ORDER BY seq_no DESC LIMIT 1");
			rs.next();
			ReturnVal[0] = rs.getString("seq_no");
			ReturnVal[1] = rs.getString("filename");
			st = mConn.createStatement();
			String sql = "UPDATE users SET state = '" + ReturnVal[0] + "', bid=0 WHERE id='" + uid + "'";
			st.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return ReturnVal;
	}

//	public int testCaseCount(int uid) throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			rs = st.executeQuery("SELECT COUNT(*) as nos FROM testcases where uid=" + uid);
//			rs.next();
//			return rs.getInt("nos");
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return 0;
//	}

	public int preSurveyCount(int uid) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		int count = 0;
		try {
			String[] tables = { "presurvey_responses" };
			Statement st = mConn.createStatement();
			for (int i = 0; i < tables.length; i++) {
				rs = st.executeQuery("SELECT COUNT(*) as nos FROM " + tables[i] + " where user_id=" + uid);
				rs.next();
				if (rs.getInt("nos") > 0)
					count += 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public void updateCompletionState(String uid) throws ClassNotFoundException, IOException, SQLException {
		try {
			Statement st3 = mConn.createStatement();
			st3.executeUpdate("UPDATE users SET completion = 2 WHERE id='" + uid + "'");
			boolean uniq = true;
			Statement st = mConn.createStatement();
			ResultSet rs;
			String salt = "";
			while (uniq) {
				salt = getSaltString();
				rs = st.executeQuery("select id from users where completion_code = '" + salt + "'");
				if (!rs.isBeforeFirst())
					uniq = false;
			}
			st3.executeUpdate("UPDATE users SET completion_code = '" + salt + "' WHERE id='" + uid + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected String getSaltString() {
		String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
		StringBuilder salt = new StringBuilder();
		Random rnd = new Random();
		while (salt.length() < 10) {
			int index = (int) (rnd.nextFloat() * SALTCHARS.length());
			salt.append(SALTCHARS.charAt(index));
		}
		String saltStr = salt.toString();
		return saltStr;
	}

	public String getCompletionCode(String uid) throws ClassNotFoundException, IOException, SQLException {
		String salt = "";
		try {
			Statement st1 = mConn.createStatement();
			ResultSet rs1 = st1.executeQuery("select completion_code from users where id = '" + uid + "'");
			if(rs1.next()){
				if(rs1.getString("completion_code")!=null){
					return rs1.getString("completion_code");
				}
			}
			Statement st3 = mConn.createStatement();
			boolean uniq = true;
			Statement st = mConn.createStatement();
			ResultSet rs;
			while (uniq) {
				salt = getSaltString();
				rs = st.executeQuery("select id from users where completion_code = '" + salt + "'");
				if (!rs.isBeforeFirst())
					uniq = false;
			}
			st3.executeUpdate("UPDATE users SET completion_code = '" + salt + "' WHERE id='" + uid + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return salt;
	}

	public ResultSet getQuestions(String TableName) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from " + TableName);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public int responseData(String table, String uid, String parameterName, String parameterValue)
			throws ClassNotFoundException, IOException, SQLException {
		int count = 0;
		String dtime = currentDateTIme();
		try {
			PreparedStatement statement = mConn.prepareStatement(
					"INSERT INTO `" + table + "`(`question_id`, `user_id`, `description`, `created_at`) VALUES ('"
							+ parameterName + "','" + uid + "', ?, '" + dtime + "')");
			statement.setString(1, parameterValue);
			count += statement.executeUpdate();
			statement.close();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;

	}


	public ResultSet getRequirements() throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from requirements");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet getRequirement(String id) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from requirements where id=" + id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}

	public String getRequirementDescription(String id) throws ClassNotFoundException, IOException, SQLException {
		ResultSet rs = null;
		String description = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select description from requirements where id=" + id);
			description = rs.getString("description");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return description;
	}
//
//	public int addTestCase(String rid, String uid, String gid, String cont, String stim, String behv)
//			throws ClassNotFoundException, IOException, SQLException {
//		int count = 0;
//		String dtime = currentDateTIme();
//		try {
//			PreparedStatement statement = mConn.prepareStatement(
//					"INSERT INTO `testcases` (`rid`, `uid`, `gid`, `context`, `stimuli`, `behavior`, `created_at`) VALUES ("
//							+ rid + "," + uid + "," + gid + ",?,?,?,'" + dtime + "')");
//			statement.setString(1, cont);
//			statement.setString(2, stim);
//			statement.setString(3, behv);
//			count = statement.executeUpdate();
//			statement.close();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return count;
//
//	}
//
//	public ResultSet getTestCases(String rid, String gid, String uid, String gtype)
//			throws ClassNotFoundException, IOException, SQLException {
//		ResultSet rs = null;
//		try {
//			Statement st = mConn.createStatement();
//			if (Integer.parseInt(gtype) > 1) {
//				rs = st.executeQuery(
//						"select testcase.*, user.name from testcases testcase, users user where testcase.uid=user.id AND testcase.rid="
//								+ rid + " AND testcase.gid=" + gid + " AND testcase.published='1'");
//			} else {
//				rs = st.executeQuery(
//						"select testcase.*, user.name from testcases testcase, users user where testcase.uid=user.id AND testcase.rid="
//								+ rid + " AND testcase.uid=" + uid + " AND testcase.published='1'");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return rs;
//	}
//

	public ResultSet getMenu(String SeqNo) {
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("select * from statuses where seq_no = '" + SeqNo + "'");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public int selectBatch(String uid){
		int bid = 0;
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("SELECT bid, attempts FROM batch_info WHERE status=1 ORDER BY attempts ASC LIMIT 1");
			rs.next();
			bid = rs.getInt("bid");
			int attempts = rs.getInt("attempts");
			st.executeUpdate("UPDATE batch_info SET attempts = "+(attempts+1)+" WHERE bid='" + bid + "'");
			st.executeUpdate("UPDATE users SET bid = "+bid+" WHERE id='" + uid + "'");
			st.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bid;
	}
	
	public int getCurrentBatch(String uid){
		int bid=0;
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("SELECT bid FROM users WHERE id='"+uid+"'");
			rs.next();
			bid = rs.getInt("bid")==0 ? selectBatch(uid) : rs.getInt("bid");
		} catch(SQLException e){
			e.printStackTrace();
		}
		return bid;
	}
	
	public int getNextTestCaseId(int uid, int bid, int lastTid){
		int nextTid = 0;
		ResultSet rs = null;
		try {
			Statement st = mConn.createStatement();
			rs = st.executeQuery("SELECT id FROM testcases WHERE id NOT IN (SELECT id FROM reviewer_responses WHERE bid='"+bid+"' AND uid='"+uid+"');");
			rs.next();
			nextTid = rs.getInt("id");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return nextTid;
	}

	public ResultSet getTestCase(String uid) {
		int bid = 0;
		ResultSet rs1 = null;
		try {
			Statement st = mConn.createStatement();
			bid = getCurrentBatch(uid);
			rs1 = st.executeQuery("SELECT * FROM testcases WHERE id NOT IN (SELECT id FROM reviewer_responses WHERE bid='"+bid+"' AND uid='"+uid+"') LIMIT 1;");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs1;
	}

	public ResultSet getAllTestCases(String uid) {
		int bid = 0;
		ResultSet rs1 = null;
		try {
			Statement st = mConn.createStatement();
			bid = getCurrentBatch(uid);
			rs1 = st.executeQuery("SELECT * FROM testcases WHERE bid="+bid+" ORDER BY rid ASC;");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs1;
	}

	public int submitReviewerResponse(String uid, String tid, String qid, String value) {
		int count=0;
		try {
			PreparedStatement statement = mConn.prepareStatement(
					"INSERT INTO `reviewer_responses` (`uid`, `tid`, `qid`, `value`) VALUES (?,?,?,?)");
			statement.setString(1, uid);
			statement.setString(2, tid);
			statement.setString(3, qid);
			statement.setString(4, value);
			count = statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

}
