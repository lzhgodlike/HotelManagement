package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

//111211
public class room_type {
    private String room_model;
    private float one_night_rent;
    private float one_month_rent;
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}