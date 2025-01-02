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

public class pick {
	private int pick_id;
	private String customer_idcard;
	private String customer_name;
	private String car_number;
	private String pick_time;
	private String return_time;
	private String car_model;
	private float plan_rent;
	private float deposit;
	private String rent_type;
	private int sub_id;
	private String pick_status;
	public String getPick_status() {
		return pick_status;
	}
	public void setPick_status(String pick_status) {
		this.pick_status = pick_status;
	}
	public int getPick_id() {
		return pick_id;
	}
	public void setPick_id(int pick_id) {
		this.pick_id = pick_id;
	}
	public String getCustomer_idcard() {
		return customer_idcard;
	}
	public void setCustomer_idcard(String customer_idcard) {
		this.customer_idcard = customer_idcard;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getCar_number() {
		return car_number;
	}
	public void setCar_number(String car_number) {
		this.car_number = car_number;
	}
	public String getPick_time() {
		return pick_time;
	}
	public void setPick_time(String pick_time) {
		this.pick_time = pick_time;
	}
	public String getReturn_time() {
		return return_time;
	}
	public void setReturn_time(String return_time) {
		this.return_time = return_time;
	}
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public float getPlan_rent() {
		return plan_rent;
	}
	public void setPlan_rent(float plan_rent) {
		this.plan_rent = plan_rent;
	}
	public float getDeposit() {
		return deposit;
	}
	public void setDeposit(float deposit) {
		this.deposit = deposit;
	}
	public String getRent_type() {
		return rent_type;
	}
	public void setRent_type(String rent_type) {
		this.rent_type = rent_type;
	}
	public int getSub_id() {
		return sub_id;
	}
	public void setSub_id(int sub_id) {
		this.sub_id = sub_id;
	}
	public pick(int pick_id, String customer_idcard, String customer_name, String car_number, String pick_time,
			String return_time, String car_model, float plan_rent, float deposit, String rent_type, int sub_id,String pick_status) {
		super();
		this.pick_id = pick_id;
		this.customer_idcard = customer_idcard;
		this.customer_name = customer_name;
		this.car_number = car_number;
		this.pick_time = pick_time;
		this.return_time = return_time;
		this.car_model = car_model;
		this.plan_rent = plan_rent;
		this.deposit = deposit;
		this.rent_type = rent_type;
		this.sub_id = sub_id;
		this.pick_status = pick_status;
	}
	public pick(){
		
	}
	public boolean addPick() throws SQLException, ParseException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `pick_car` (customer_idcard,customer_name,car_number,pick_time,return_time,car_model,plan_rent,deposit,sub_id,rent_type,pick_status) values(?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.customer_idcard);
			ps.setString(2, this.customer_name);
			ps.setString(3, this.car_number);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
	        java.util.Date pickdate = simpleDateFormat.parse(this.pick_time);
			ps.setDate(4, new java.sql.Date (pickdate.getTime()));
			java.sql.Date returndate = java.sql.Date.valueOf(this.return_time); //(Date) simpleDateFormat.parse(this.sub_get_date);
			ps.setDate(5, returndate);
			ps.setString(6, this.car_model);
			ps.setFloat(7, this.plan_rent);
			ps.setFloat(8, this.deposit);
			ps.setInt(9, this.sub_id);
			ps.setString(10, this.rent_type);
			this.pick_status = "在租";
			ps.setString(11, this.pick_status);
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
	public static List<pick> getPicks() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<pick> allpicks = new ArrayList<pick>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `pick_car`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				pick temp = new pick(rs.getInt("pick_id"),rs.getString("customer_idcard"),rs.getString("customer_name"),rs.getString("car_number"),String.valueOf(rs.getDate("pick_time")),String.valueOf(rs.getDate("return_time")),rs.getString("car_model"),rs.getFloat("plan_rent"),rs.getFloat("deposit"),rs.getString("rent_type"),rs.getInt("sub_id"),rs.getString("pick_status"));
				allpicks.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
		return allpicks;
		
	}
}
