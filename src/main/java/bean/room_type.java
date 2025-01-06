package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

//111211
public class room_type {
    private String room_model;       //房间类型
    private float one_night_rent;     //一晚租金
    private float one_month_rent;     //一月租金
    public String getRoom_model() {
        return room_model;
    }
    public void setRoom_model(String room_model) {
        this.room_model = room_model;
    }
    public float getOne_night_rent() {
        return one_night_rent;
    }
    public void setOne_night_rent(float one_night_rent) {
        this.one_night_rent = one_night_rent;
    }
    public float getOne_month_rent() {
        return one_month_rent;
    }
    public void setOne_month_rent(float one_month_rent) {
        this.one_month_rent = one_month_rent;
    }
    public room_type(String room_model, float one_night_rent, float one_month_rent) {
        super();
        this.room_model = room_model;
        this.one_night_rent = one_night_rent;
        this.one_month_rent = one_month_rent;
    }
    
    public static void addtype() {
        
    }
    
    
    //查询所有的房间类型信息
    public static List<room_type> getTypes() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        List<room_type> allmodels = new ArrayList<room_type>();
        
        try {
            conn = DBConnection.getConnection();
            String sql = "select * from `room_type`";
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                room_type temp = new room_type(rs.getString("room_model"),rs.getFloat("one_night_rent"),rs.getFloat("one_month_rent"));
                allmodels.add(temp);
            }
        }finally {
            conn.close();
        }
        return allmodels;
    }
    
    
    //查询某一个房间类型的所有信息
    public static List<room> getRooms(String mode)throws SQLException{
		Connection conn = null;
		ResultSet rs = null;
		List<room> allRooms = new ArrayList<room>();
		try{
			conn = DBConnection.getConnection();
			String sql = "select * from `room` where `room_model` = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, mode);
			rs = ps.executeQuery();
			while(rs.next()){
				room temp = new room(rs.getString("room_id"),rs.getInt("Room_total_number"),rs.getInt("Room_s_number"),rs.getString("room_model"),rs.getString("current_status"),rs.getString("room_img"));
				allRooms.add(temp);
			}
			//System.out.println(rs.next());
		}finally{
			conn.close();
		}
		return allRooms;
	}
    
    
    //根据房间号码查询某个房间的信息
    public static room getRoomByRoomId(String id) throws SQLException {
    	Connection conn = null;
    	ResultSet rs = null;
    	room troom = new room();
    	try {
    		conn = DBConnection.getConnection();
    		String sql = "select * from `room` where `room_id` = ?";
    		PreparedStatement ps = conn.prepareStatement(sql);
    		ps.setString(1, id);
    		rs = ps.executeQuery();
    		while (rs.next()) {
    			troom.setRoom_id(rs.getString("room_id"));
				troom.setRoom_total_number(rs.getInt("Room_total_number"));
				troom.setRoom_s_number(rs.getInt("Room_s_number"));
				troom.setCurrent_status(rs.getString("current_status"));
				troom.setRoom_img(rs.getString("room_img"));
    		}
    	}finally {
    		conn.close();
    	}
    	return troom;
    }
    
    //新增房间类型
    public boolean addRoom_model() throws SQLException {
    	Connection conn = null;
    	int rs = 0;
		try{
			conn = DBConnection.getConnection();
			String sql = "insert into `room_type` (room_model,one_night_rent,one_month_rent) values(?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, this.room_model);
			ps.setFloat(2, this.one_night_rent);
			ps.setFloat(3, this.one_month_rent);
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