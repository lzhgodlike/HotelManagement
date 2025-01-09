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
	public Employeelog() {

	}
	public Employeelog(int id,String account, String password, String role, String name, String idcard, String gender) {
		super();
		this.id = id;
		this.account = account;
		this.password = password;
		this.role = role;
		this.name = name;
		this.idcard = idcard;
		this.gender = gender;
	}
	public Employeelog(String account,String password,String role){
		this.account = account;
		this.password = password;
		this.role = role;
	}
	public static List<Employeelog> getEmployeelog() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<Employeelog> userlogs = new ArrayList<Employeelog>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `inactiveusers`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				Employeelog temp = new Employeelog(rs.getInt("user_id"),rs.getString("user_account"),rs.getString("password"),rs.getString("role"),rs.getString("username"),rs.getString("user_idcard"),rs.getString("gender"));
				userlogs.add(temp);
			}
		}finally{
			conn.close();
		}
		return userlogs;
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
		}finally{
			conn.close();
		}
	}
}
