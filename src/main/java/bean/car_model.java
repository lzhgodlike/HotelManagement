package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class car_model {
	private String car_model;
	private float rent_day;
	private float rent_month;
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public float getRent_day() {
		return rent_day;
	}
	public void setRent_day(float rent_day) {
		this.rent_day = rent_day;
	}
	public float getRent_month() {
		return rent_month;
	}
	public void setRent_month(float rent_month) {
		this.rent_month = rent_month;
	}
	public car_model(){
		
	}
	public car_model(String car_model, float rent_day, float rent_month) {
		super();
		this.car_model = car_model;
		this.rent_day = rent_day;
		this.rent_month = rent_month;
	}
	public static void addmodel(){
		
	}
	//向数据库查询获取所有车辆型号信息
	public static List<car_model> getModels() throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		List<car_model> allmodels = new ArrayList<car_model>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `car_model_rent`";
			 ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				car_model temp = new car_model(rs.getString("car_model"),rs.getFloat("rent_day"),rs.getFloat("rent_month"));
				allmodels.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			ps.close();
			rs.close();
			conn.close();
		}
		return allmodels;
	}
	//向数据库查询获得某一车辆型号的所有车辆信息
	public static List<car> getCars(String mode)throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps  = null;
		List<car> allcars = new ArrayList<car>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `car` where `car_model` = ?";
			 ps = conn.prepareStatement(sql);
			ps.setString(1, mode);
			rs = ps.executeQuery();
			while(rs.next()){
				SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd");
				String date = fo.format(rs.getDate("bought_time"));
				car temp = new car(rs.getInt("car_id"),rs.getString("car_number"),rs.getString("car_model"),date,rs.getString("current_status"),rs.getString("car_img"));
				allcars.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			ps.close();
			rs.close();
			conn.close();
		}
		return allcars;
	}
	
	public static car getCar(String num)throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps  = null;
		car tcar = new car();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `car` where `car_number` = ?";
			 ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			while(rs.next()){
				SimpleDateFormat fo = new SimpleDateFormat("YYYY-MM-dd");
				String date = fo.format(rs.getDate("bought_time"));
				//car temp = new car(rs.getInt("car_id"),rs.getString("car_number"),rs.getString("car_model"),date,rs.getString("current_status"),rs.getString("car_img"));
				tcar.setCar_id(rs.getInt("car_id"));
				tcar.setCar_number(rs.getString("car_number"));
				tcar.setCar_model(rs.getString("car_model"));
				tcar.setBought_time(date);
				tcar.setCurrent_status(rs.getString("current_status"));
				tcar.setCar_img(rs.getString("car_img"));
			}
			//System.out.println(rs.next());
		}finally{
			ps.close();
			rs.close();
			conn.close();
		}
		return tcar;
	}
	public boolean addCar_model() throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `car_model_rent` (car_model,rent_day,rent_month) values(?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.car_model);
			ps.setFloat(2, this.rent_day);
			ps.setFloat(3, this.rent_month);
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
	public boolean updateCar_model()throws SQLException{
		Connection conn = null;
		int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "update `car_model_rent` set `rent_day`=?,`rent_month`=?where `car_model` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setFloat(1, this.rent_day);
			ps.setFloat(2, this.rent_month);
			ps.setString(3, this.car_model);
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
