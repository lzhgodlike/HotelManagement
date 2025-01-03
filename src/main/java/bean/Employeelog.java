package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class Employeelog {
	private String account;
	private String password;
	private String role;
	private int id;
	private String name;
	private String gender;
	private String idcard;
	private String logtime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getLogtime() {
		return logtime;
	}
	public void setLogtime() {
		this.logtime = logtime;
	}
	public Employeelog() {

	}
	public Employeelog(int id,String account, String password, String role, String name, String idcard, String gender,String logtime) {
		super();
		this.id = id;
		this.account = account;
		this.password = password;
		this.role = role;
		this.name = name;
		this.idcard = idcard;
		this.gender = gender;
		this.logtime = logtime;
	}
	public Employeelog(String account,String password,String role){
		this.account = account;
		this.password = password;
		this.role = role;
	}
	public String check()throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `user` where `user_account` = ? and `password` = ? and `role` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.account);
			ps.setString(2, this.password);
			ps.setString(3, this.role);
			rs = ps.executeQuery();
			if(rs.next()==false){
				return "error";
			}else{
				this.idcard = rs.getString("user_idcard");
				this.name = rs.getString("username");
				this.id = rs.getInt("user_id");
				return "pass";
			}
		}finally{
			conn.close();
		}
	}
//	public static List<User> getUsers() throws SQLException{
//		Connection conn = null;
//		ResultSet rs = null;
//		List<User> allusers = new ArrayList<User>();
//		try{
//			conn = DBConnection.getConnection();
//			String sql = "select * from `user`";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			rs = ps.executeQuery();
//			while(rs.next()){
//				User temp = new User(rs.getInt("user_id"),rs.getString("user_account"),rs.getString("password"),rs.getString("role"),rs.getString("username"),rs.getString("user_idcard"),rs.getString("gender"));
//				allusers.add(temp);
//			}
//			//System.out.println(rs.next());
//		}finally{
//			conn.close();
//		}
//		return allusers;
//	}
	public static List<Employeelog> getEmployeelog() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<Employeelog> userlogs = new ArrayList<Employeelog>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `employeelog`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				Employeelog temp = new Employeelog(rs.getInt("user_id"),rs.getString("user_account"),rs.getString("password"),rs.getString("role"),rs.getString("username"),rs.getString("user_idcard"),rs.getString("gender"),rs.getString("logtime"));
				userlogs.add(temp);
			}
		}finally{
			conn.close();
		}
		return userlogs;
	}
//	public boolean addUser() throws SQLException{
//		Connection conn = null;
//		int rs = 0;
//		try{
//			conn = DBConnection.getConnection();
//			String sql = "insert into `user` (user_account,password,username,user_idcard,gender,role) values(?,?,?,?,?,?)";
//			PreparedStatement ps = conn.prepareStatement(sql);
//			ps.setString(1, this.account);
//			String psw = this.idcard.substring(this.idcard.length()-6);
//			this.password = psw;
//			System.out.println(psw);
//			ps.setString(2, psw);
//			ps.setString(3, this.name);
//			ps.setString(4, this.idcard);
//			ps.setString(5, gender);
//			ps.setString(6, role);
//			rs = ps.executeUpdate();
//			System.out.println(rs);
//			if(rs==1){
//				return true;
//			}else{
//				return false;
//			}
//			//System.out.println(rs.next());
//		}finally{
//			conn.close();
//		}
//	}
	public boolean deleteEmployeelog() throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "delete from `employeelog` where `user_id` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, this.id);
			rs = ps.executeUpdate();
			System.out.println(rs);
			if(rs==1){
				return true;
			}else{
				return false;
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
	}
	public boolean recoverEmployeelog()throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `employeelog` where `user_id` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, this.id);
			rs = ps.executeQuery();
			if (rs.next()) {
				//获取数据
				int user_id = rs.getInt("user_id");
				String user_idcard = rs.getString("user_idcard");
				String username = rs.getString("username");
				String gender = rs.getString("gender");
				String user_account = rs.getString("user_account");
				String password = rs.getString("password");
				String role = rs.getString("role");
				//将数据插入到user表中
				String insertSql = "insert into `user` (user_id, user_account, password, role, username, user_idcard, gender) VALUES (?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement insertPs = conn.prepareStatement(insertSql);
				insertPs.setInt(1, user_id);
				insertPs.setString(2, user_idcard);
				insertPs.setString(3, username);
				insertPs.setString(4, gender);
				insertPs.setString(5, user_account);
				insertPs.setString(6, password);
				insertPs.setString(7, role);
				insertPs.executeUpdate();
				//删除employeelog表中对应数据
				String deleteSql = "delete from `employeelog` where `user_id` = ?";
				PreparedStatement deletePs = conn.prepareStatement(deleteSql);
				deletePs.setInt(1, user_id);
				deletePs.executeUpdate();
				return true;
			}
			else {
				return false;
			}
			
//			ps.setString(1, this.account);
//			ps.setString(2, this.password);
//			ps.setString(3, this.name);
//			ps.setString(4, this.idcard);
//			ps.setString(5, gender);
//			ps.setString(6, this.role);
//			ps.setInt(7, this.id);
//			rs = ps.executeUpdate();
			//System.out.println(rs.next());
		}finally{
			if (rs != null) {
				rs.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
	}
}
