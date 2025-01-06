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

//刘子涵
public class car {
	private int car_id;
	private String car_number;
	private String car_model;
	private String bought_time;
	private String current_status;
	private String car_img;
	
	public int getCar_id() {
		return car_id;
	}
	public void setCar_id(int car_id) {
		this.car_id = car_id;
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
	public String getBought_time() {
		return bought_time;
	}
	public void setBought_time(String bought_time) {
		this.bought_time = bought_time;
	}
	public String getCurrent_status() {
		return current_status;
	}
	public void setCurrent_status(String current_status) {
		this.current_status = current_status;
	}
	public car(int id, String number, String model, String bought_time, String current_status, String car_img) {
		super();
		this.car_id = id;
		this.car_number = number;
		this.car_model = model;
		this.bought_time = bought_time;
		this.current_status = current_status;
		this.car_img = car_img;
	}
	public String getCar_img() {
		return car_img;
	}
	public void setCar_img(String car_img) {
		this.car_img = car_img;
	}
	public car(){
		
	}
	public static List<car> getCars() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<car> allcars = new ArrayList<car>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `car`";
			PreparedStatement ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd");
				String date = fo.format(rs.getDate("bought_time"));
				car temp = new car(rs.getInt("car_id"),rs.getString("car_number"),rs.getString("car_model"),date,rs.getString("current_status"),rs.getString("car_img"));
				allcars.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
		return allcars;
	}
	public boolean addCar() throws SQLException, ParseException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `car` (car_number,car_model,bought_time,current_status,car_img) values(?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date bought_time = simpleDateFormat.parse(this.bought_time);
			ps.setString(1, this.car_number);
			ps.setString(2, this.car_model);
			ps.setDate(3, new java.sql.Date (bought_time.getTime()));
			ps.setString(4, this.current_status);
			ps.setString(5, this.car_img);
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
	public static boolean deleteCar(int i) throws SQLException, ParseException{
		Connection conn = null;
		int rs = 0;
		System.out.println(i);
		try{
			conn = DBConnection.getConnection();
			String sql = "delete from `car` where `car_id` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, i);
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
