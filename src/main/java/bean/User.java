package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class User {
	private String account;
	private String password;
	private String role;
	private int id;
	private String name;
	private String idcard;
	
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
	public User() {

	}
	public User(int id,String account, String password, String role, String name, String idcard) {
		super();
		this.id = id;
		this.account = account;
		this.password = password;
		this.role = role;
		this.name = name;
		this.idcard = idcard;
	}
	public User(String account,String password,String role){
		this.account = account;
		this.password = password;
		this.role = role;
	}
	public String check()throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `user` where `user_account` = ? and `user_password` = ? and `role` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.account);
			ps.setString(2, this.password);
			ps.setString(3, this.role);
			rs = ps.executeQuery();
			if(rs.next()==false){
				return "error";
			}else{
				this.idcard = rs.getString("user_idcard");
				this.name = rs.getString("user_name");
				this.id = rs.getInt("user_id");
				return "pass";
			}
		}finally{
			conn.close();
		}
	}
	public static List<User> getUsers() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<User> allusers = new ArrayList<User>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `user`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				User temp = new User(rs.getInt("user_id"),rs.getString("user_account"),rs.getString("user_password"),rs.getString("role"),rs.getString("user_name"),rs.getString("user_idcard"));
				allusers.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
		return allusers;
		
	}
	public boolean addUser() throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `user` (user_account,user_password,user_name,user_idcard,role) values(?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.account);
			String psw = this.idcard.substring(this.idcard.length()-6);
			this.password = psw;
			System.out.println(psw);
			ps.setString(2, psw);
			ps.setString(3, this.name);
			ps.setString(4, this.idcard);
			ps.setString(5, role);
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
	public boolean deleteUser() throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "delete from `user` where `user_id` = ?";
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
	public boolean updateUser()throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "update `user` set `user_account`=?,`user_password`=?,`user_name`=?,`user_idcard`=?,`role`=? where `user_id` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.account);
			ps.setString(2, this.password);
			ps.setString(3, this.name);
			ps.setString(4, this.idcard);
			ps.setString(5, this.role);
			ps.setInt(6, this.id);
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
}
