package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

//房间预约
public class sub1 {
	private String sub_id;
	private String customer_idcard;
	private String customer_name;
	private String car_model;
	private Date sub_date;
	private Date sub_get_date;
	private Date sub_return_date;
	private String sub_status;

	public String getSub_id() {
		return sub_id;
	}
	public void setSub_id(String sub_id) {
		this.sub_id = sub_id;
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
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public Date getSub_date() {
		return sub_date;
	}
	public void setSub_date(Date sub_date) {
		this.sub_date = sub_date;
	}
	public Date getSub_get_date() {
		return sub_get_date;
	}
	public void setSub_get_date(Date sub_get_date) {
		this.sub_get_date = sub_get_date;
	}
	public Date getSub_return_date() {
		return sub_return_date;
	}
	public void setSub_return_date(Date sub_return_date) {
		this.sub_return_date = sub_return_date;
	}
	public String getSub_status() {
		return sub_status;
	}
	public void setSub_status(String sub_status) {
		this.sub_status = sub_status;
	}
//	public String getCar_number() {
//		return car_number;
//	}
//	public void setCar_number(String car_number) {
//		this.car_number = car_number;
//	}
//	public String getRent_type() {
//		return rent_type;
//	}
//	public void setRent_type(String rent_type) {
//		this.rent_type = rent_type;
//	}
	public sub1(){}
	public sub1(String sub_id, String customer_idcard, String customer_name, String car_model, Date sub_date,
			Date sub_get_date, Date sub_return_date, String sub_status) {
		super();
		this.sub_id = sub_id;
		this.customer_idcard = customer_idcard;
		this.customer_name = customer_name;
		this.car_model = car_model;
		this.sub_date = sub_date;
		this.sub_get_date = sub_get_date;
		this.sub_return_date = sub_return_date;
		this.sub_status = sub_status;
//		this.car_number = car_number;
//		this.rent_type = rent_type;
	}
	
	//�������ԤԼ��Ϣ
	public static List<sub1> getSubs() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<sub1> allsubs = new ArrayList<sub1>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `room_reservation`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				sub1 temp = new sub1(rs.getString("sub_id"),rs.getString("customer_idcard"),rs.getString("customer_name"),rs.getString("car_model"),rs.getDate("sub_date"),rs.getDate("sub_get_date"),rs.getDate("sub_return_date"),rs.getString("sub_status"));
				allsubs.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
		return allsubs;
		
	}
	//��ԤԼ���в�����Ϣ
	public boolean add() throws ParseException, SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `room_reservation` (customer_idcard,customer_name,car_model,sub_date,sub_get_date,sub_return_date,sub_status) values(?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.customer_idcard);
			ps.setString(2, this.customer_name);
			ps.setString(3, this.car_model);
//			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//ע���·���MM
//	        java.util.Date subdate = simpleDateFormat.parse(this.sub_date);
//			ps.setDate(4, new java.sql.Date (subdate.getTime()));
//			java.sql.Date sub_get_date = java.sql.Date.valueOf(this.sub_get_date); //(Date) simpleDateFormat.parse(this.sub_get_date);
//			ps.setDate(5, sub_get_date);
//			java.sql.Date sub_return_date = java.sql.Date.valueOf(this.sub_return_date); //(Date) simpleDateFormat.parse(this.sub_return_date);
//			ps.setDate(6, sub_return_date);
			ps.setDate(4, sub_date);
			ps.setDate(5, sub_get_date);
			ps.setDate(6, sub_return_date);
			ps.setString(7, this.sub_status);
//			ps.setString(8, this.car_number);
//			ps.setString(9, this.rent_type);
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
	//��ԤԼ����ɾ����Ϣ
	public boolean deleteSub() throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "delete from `room_reservation` where `sub_id` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.sub_id);
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
