package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import util.DBConnection;

public class pick_room {
    private int pick_id;
    private String room_id;
    private String customer_idcard;
    private String customer_name;
    private String pick_time;
    private String return_time;
    private String room_model;
    private int plan_rent;
    private int sub_id;
    private String pick_status;

    // Getters and Setters
    public int getPick_id() {
        return pick_id;
    }

    public void setPick_id(int pick_id) {
        this.pick_id = pick_id;
    }

    public String getRoom_id() {
        return room_id;
    }

    public void setRoom_id(String room_id) {
        this.room_id = room_id;
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

    public String getRoom_model() {
        return room_model;
    }

    public void setRoom_model(String room_model) {
        this.room_model = room_model;
    }

    public int getPlan_rent() {
        return plan_rent;
    }

    public void setPlan_rent(int plan_rent) {
        this.plan_rent = plan_rent;
    }

    public int getSub_id() {
        return sub_id;
    }

    public void setSub_id(int sub_id) {
        this.sub_id = sub_id;
    }

    public String getPick_status() {
        return pick_status;
    }

    public void setPick_status(String pick_status) {
        this.pick_status = pick_status;
    }

    // Constructor
    public pick_room(int pick_id, String room_id, String customer_idcard, String customer_name, String pick_time,
                     String return_time, String room_model, int plan_rent, int sub_id, String pick_status) {
        this.pick_id = pick_id;
        this.room_id = room_id;
        this.customer_idcard = customer_idcard;
        this.customer_name = customer_name;
        this.pick_time = pick_time;
        this.return_time = return_time;
        this.room_model = room_model;
        this.plan_rent = plan_rent;
        this.sub_id = sub_id;
        this.pick_status = pick_status;
    }

    // Default constructor
    public pick_room() {
    }

    // Method to add a pick room entry
    public boolean addPick_room() throws SQLException {
        Connection conn = null;
        PreparedStatement ps  = null;
        int rs = 0;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO pick_room (room_id, customer_idcard, customer_name, pick_time, return_time, room_model, plan_rent, sub_id, pick_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
             ps = conn.prepareStatement(sql);
            ps.setString(1, this.room_id);
            ps.setString(2, this.customer_idcard);
            ps.setString(3, this.customer_name);
            ps.setString(4, this.pick_time);
            ps.setString(5, this.return_time);
            ps.setString(6, this.room_model);
            ps.setInt(7, this.plan_rent);
            ps.setInt(8, this.sub_id);
            this.pick_status = "入住"; // Default pick status
            ps.setString(9, this.pick_status);
            rs = ps.executeUpdate();
            return rs == 1;
        } finally {
            if (conn != null) {
            	ps.close();
                conn.close();
            }
        }
    }

    // Method to get all pick room entries
    public static List<pick_room> getPicks() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        List<pick_room> allPickRooms = new ArrayList<>();
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM pick_room";
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                pick_room temp = new pick_room(
                        rs.getInt("pick_id"),
                        rs.getString("room_id"),
                        rs.getString("customer_idcard"),
                        rs.getString("customer_name"),
                        rs.getString("pick_time"),
                        rs.getString("return_time"),
                        rs.getString("room_model"),
                        rs.getInt("plan_rent"),
                        rs.getInt("sub_id"),
                        rs.getString("pick_status")
                );
                allPickRooms.add(temp);
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return allPickRooms;
    }

	
}
