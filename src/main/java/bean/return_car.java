package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class return_car {
	private int return_id;
	private String customer_idcard;
	private String car_number;
	private String car_model;
	private String return_date;
	private int pick_id;
	private String rent_type;
	public int getReturn_id() {
		return return_id;
	}
	public void setReturn_id(int return_id) {
		this.return_id = return_id;
	}
	public String getCustomer_idcard() {
		return customer_idcard;
	}
	public void setCustomer_idcard(String customer_idcard) {
		this.customer_idcard = customer_idcard;
	}
	public String getCar_number() {
		return car_number;
	}
	public void setCar_number(String car_number) {
		this.car_number = car_number;
	}
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public String getReturn_date() {
		return return_date;
	}
	public void setReturn_date(String return_date) {
		this.return_date = return_date;
	}
	public int getPick_id() {
		return pick_id;
	}
	public void setPick_id(int pick_id) {
		this.pick_id = pick_id;
	}
	public String getRent_type() {
		return rent_type;
	}
	public void setRent_type(String rent_type) {
		this.rent_type = rent_type;
	}
	public return_car(String customer_idcard, String car_number, String car_model, String return_date,
			int pick_id, String rent_type) {
		super();
		this.customer_idcard = customer_idcard;
		this.car_number = car_number;
		this.car_model = car_model;
		this.return_date = return_date;
		this.pick_id = pick_id;
		this.rent_type = rent_type;
	}
	public return_car(int id,String customer_idcard, String car_number, String car_model, String return_date,
			int pick_id, String rent_type) {
		super();
		this.return_id = id;
		this.customer_idcard = customer_idcard;
		this.car_number = car_number;
		this.car_model = car_model;
		this.return_date = return_date;
		this.pick_id = pick_id;
		this.rent_type = rent_type;
	}
	public return_car(){
		
	}
	public static List<return_car> getReturns() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<return_car> allreturns = new ArrayList<return_car>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `return_car`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				return_car temp = new return_car(rs.getInt("return_id"),rs.getString("customer_idcard"),rs.getString("car_number"),rs.getString("car_model"),String.valueOf(rs.getDate("return_date")),rs.getInt("pick_id"),rs.getString("rent_type"));
				allreturns.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
		return allreturns;
		
	}
	public boolean addReturn() throws SQLException, ParseException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `return_car` (customer_idcard,car_number,car_model,return_date,pick_id,rent_type) values(?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.customer_idcard);
			ps.setString(2, this.car_number);
			ps.setString(3, this.car_model);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
	        java.util.Date returndate = simpleDateFormat.parse(this.return_date);
	        ps.setDate(4, new java.sql.Date (returndate.getTime()));
	        ps.setInt(5, this.pick_id);
	        ps.setString(6,this.rent_type);
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
