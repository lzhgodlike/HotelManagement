package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import util.DBConnection;

public class return_room {
    private int return_id;
    private String room_id;
    private String customer_idcard;
    private String room_model;
    private Date room_estimate_date;
    private Date return_date;
    private int pick_id;

    // Getters and Setters
    public int getReturn_id() {
        return return_id;
    }

    public void setReturn_id(int return_id) {
        this.return_id = return_id;
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

    public String getRoom_model() {
        return room_model;
    }

    public void setRoom_model(String room_model) {
        this.room_model = room_model;
    }

    public Date getRoom_estimate_date() {
        return room_estimate_date;
    }

    public void setRoom_estimate_date(Date room_estimate_date) {
        this.room_estimate_date = room_estimate_date;
    }

    public Date getReturn_date() {
        return return_date;
    }

    public void setReturn_date(Date return_date) {
        this.return_date = return_date;
    }

    public int getPick_id() {
        return pick_id;
    }

    public void setPick_id(int pick_id) {
        this.pick_id = pick_id;
    }

    // Constructors
    public return_room(String customer_idcard, String room_id, String room_model, Date room_estimate_date, Date return_date, int pick_id) {
        this.customer_idcard = customer_idcard;
        this.room_id = room_id;
        this.room_model = room_model;
        this.room_estimate_date = room_estimate_date;
        this.return_date = return_date;
        this.pick_id = pick_id;
    }

    public return_room(int return_id, String customer_idcard, String room_id, String room_model, Date room_estimate_date, Date return_date, int pick_id) {
        this.return_id = return_id;
        this.customer_idcard = customer_idcard;
        this.room_id = room_id;
        this.room_model = room_model;
        this.room_estimate_date = room_estimate_date;
        this.return_date = return_date;
        this.pick_id = pick_id;
    }

    public return_room() {
    }

    // Method to fetch all return room entries from the database
    public static List<return_room> getReturnRooms() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        List<return_room> allReturnRooms = new ArrayList<>();
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM return_room";
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                return_room temp = new return_room(
                        rs.getInt("return_id"),
                        rs.getString("customer_idcard"),
                        rs.getString("room_id"),
                        rs.getString("room_model"),
                        rs.getDate("room_estimate_date"),
                        rs.getDate("return_date"),
                        rs.getInt("pick_id")
                );
                allReturnRooms.add(temp);
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return allReturnRooms;
    }

    // Method to add a return room entry to the database
    public boolean addReturnRoom() throws SQLException, ParseException {
        Connection conn = null;
        int rs = 0;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO return_room (customer_idcard, room_id, room_model, room_estimate_date, return_date, pick_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, this.customer_idcard);
            ps.setString(2, this.room_id);
            ps.setString(3, this.room_model);
            ps.setDate(4, new java.sql.Date(this.room_estimate_date.getTime()));
            ps.setDate(5, new java.sql.Date(this.return_date.getTime()));
            ps.setInt(6, this.pick_id);
            rs = ps.executeUpdate();
            return rs == 1;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }
}
