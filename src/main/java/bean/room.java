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

public class room {

	private String room_id;               //房间号码
	private int Room_total_number;      //房间总数量
	private int Room_s_number;          //房间剩余数量
	private String room_model;         //房间类型
	private String current_status;       //房间状态
	private String room_img;            //房间照片
	
	

    
   
	
	public String getRoom_id() {
		return room_id;
	}
	public void setRoom_id(String room_id) {
		this.room_id = room_id;
	}
	public int getRoom_total_number() {
		return Room_total_number;
	}
	public void setRoom_total_number(int room_total_number) {
		Room_total_number = room_total_number;
	}
	public int getRoom_s_number() {
		return Room_s_number;
	}
	public void setRoom_s_number(int room_s_number) {
		Room_s_number = room_s_number;
	}
	public String getRoom_model() {
		return room_model;
	}
	public void setRoom_model(String room_model) {
		this.room_model = room_model;
	}
	public String getCurrent_status() {
		return current_status;
	}
	public void setCurrent_status(String current_status) {
		this.current_status = current_status;
	}
	public String getRoom_img() {
		return room_img;
	}
	public void setRoom_img(String room_img) {
		this.room_img = room_img;
	}
	public room() {
		super();
		// TODO Auto-generated constructor stub
	}
	public room(String room_id, int room_total_number, int room_s_number, String room_model, String current_status,
			String room_img) {
		super();
		this.room_id = room_id;
		Room_total_number = room_total_number;
		Room_s_number = room_s_number;
		this.room_model = room_model;
		this.current_status = current_status;
		this.room_img = room_img;
	}
	
	//查询所有房间信息
	public static List<room> getRooms() throws SQLException {
		Connection conn = null;
		ResultSet rs = null;
		List<room> allRooms = new ArrayList<room>();
		PreparedStatement ps = null;
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `room`";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()){
				room temp = new room(rs.getString("room_id"),rs.getInt("Room_total_number"),rs.getInt("Room_s_number"),rs.getString("room_model"),rs.getString("current_status"),rs.getString("room_img"));
				allRooms.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
			ps.close();
			rs.close();
		}
		return allRooms;
	}
	
	//新增房间
	public boolean addRoom() throws SQLException, ParseException{
		Connection conn = null;
		int rs = 0;
		PreparedStatement ps = null;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `room` (room_id,Room_total_number,Room_s_number,room_model,current_status,room_img) values(?,?,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, this.room_id);
			ps.setInt(2, this.Room_total_number);
			ps.setInt(3, this.Room_s_number);
			ps.setString(4, this.room_model);
			ps.setString(5, this.current_status);
			ps.setString(6, this.room_img);
			rs = ps.executeUpdate();
			System.out.println(rs);
			if(rs==1){
				return true;
			}else{
				return false;
			}
		}finally{
			conn.close();
			ps.close();
		}
	}
	
	
	//删除房间信息
	public static boolean deleteRoom(int id) throws SQLException, ParseException{
		Connection conn = null;
		int rs = 0;
		System.out.println(id);
		PreparedStatement ps = null;
		try{
			conn = DBConnection.getConnection();
			String sql = "delete from `room` where `room_id` = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeUpdate();
			System.out.println(rs);
			if(rs==1){
				return true;
			}else{
				return false;
			}
		}finally{
			conn.close();
			ps.close();
		}
	}
}
