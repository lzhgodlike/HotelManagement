package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.CallableStatement;
//import com.mysql.cj.jdbc.CallableStatement;

import util.DBConnection;

public class User {
	private String account;
	private String password;
	private String role;
	private int id;
	private String name;
	private String gender;
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public User() {

	}
	public User(int id,String account, String password, String role, String name, String idcard, String gender) {
		super();
		this.id = id;
		this.account = account;
		this.password = password;
		this.role = role;
		this.name = name;
		this.idcard = idcard;
		this.gender = gender;
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
			String sql = "select * from `user` where `user_account` = ? and `password` = ? and `role` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.account);
			ps.setString(2, this.password);
			ps.setString(3, this.role);
			rs = ps.executeQuery(); //查询数据库结果存到rs里
			if(!rs.next() || !rs.getBoolean("flag_state")){
				return "error";
			}else{
				this.idcard = rs.getString("user_idcard");
				this.name = rs.getString("username");
				this.id = rs.getInt("user_id");
				return "pass";
			}
		}finally{
			if (conn != null) {
			    try {
			        conn.close();
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }
			}

		}
	}
	public static List<User> getUsers() throws SQLException {
	    Connection conn = null;
	    ResultSet rs = null;
	    List<User> allusers = new ArrayList<User>();
	    try {
	        conn = DBConnection.getConnection();
	        String sql = "SELECT * FROM ActiveUsers";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            User temp = new User(
	                rs.getInt("user_id"),
	                rs.getString("user_account"),
	                rs.getString("password"),
	                rs.getString("role"),
	                rs.getString("username"),
	                rs.getString("user_idcard"),
	                rs.getString("gender")
	            );
	            allusers.add(temp);
	        }
	    } finally {
	        if (rs != null) {
	            rs.close();
	        }
	        if (conn != null) {
	            conn.close();
	        }
	    }
	    return allusers;
	}
	public boolean addUser() throws SQLException {
	    Connection conn = null;
	    int rs = 0;
	    try {
	        conn = DBConnection.getConnection();
	        String sql = "{CALL AddEmployeeWithDefaultPassword(?, ?, ?, ?, ?, ?)}";
	        CallableStatement cs = conn.prepareCall(sql);
	        cs.setString(1, this.idcard);
	        cs.setString(2, this.name);
	        cs.setString(3, this.gender);
	        cs.setString(4, this.account);
	        cs.setString(5, this.password);
	        cs.setString(6, this.role);
	        rs = cs.executeUpdate();
	        System.out.println(rs);
	        return rs == 1;
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }
	}

	public boolean deleteUser() throws SQLException {
	    Connection conn = null;
	    int rs = 0;
	    try {
	        conn = DBConnection.getConnection();
	        String sql = "UPDATE `user` SET flag_state = 0 WHERE user_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, this.id);
	        rs = ps.executeUpdate();
	        System.out.println(rs);
	        return rs == 1;
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }
	}
	
	public boolean recoverUser() throws SQLException {
	    Connection conn = null;
	    int rs = 0;
	    try {
	        conn = DBConnection.getConnection();
	        String sql = "UPDATE `user` SET flag_state = 1 WHERE user_id = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setInt(1, this.id);
	        rs = ps.executeUpdate();
	        System.out.println(rs);
	        return rs == 1;
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }
	}

	public boolean updateUser()throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "update `user` set `user_account`=?,`password`=?,`username`=?,`user_idcard`=?,`gender`=?,`role`=? where `user_id` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.account);
			ps.setString(2, this.password);
			ps.setString(3, this.name);
			ps.setString(4, this.idcard);
			ps.setString(5, gender);
			ps.setString(6, this.role);
			ps.setInt(7, this.id);
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
