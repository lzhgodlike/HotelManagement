package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class sub1 {
    private int sub_id;
    private String customer_idcard;
    private String customer_name;
    private String room_model;
    private String sub_date;
    private String sub_get_date;
    private String sub_return_date;
    private String sub_status;
    private int room_id;
    public sub1() {}

    public sub1(int room_id,int sub_id, String customer_idcard, String customer_name, String room_model, String sub_date, String sub_get_date, String sub_return_date, String sub_status) {
        this.sub_id = sub_id;
        this.room_id = room_id;
        this.customer_idcard = customer_idcard;
        this.customer_name = customer_name;
        this.room_model = room_model;
        this.sub_date = sub_date;
        this.sub_get_date = sub_get_date;
        this.sub_return_date = sub_return_date;
        this.sub_status = sub_status;
    }

    public int getSub_id() { return sub_id; }
    
    public void setSub_id(int sub_id) { this.sub_id = sub_id; }
    
    public int getRoom_id() { return room_id; }
    
    public void setRoom_id(int room_id) { this.room_id = room_id; }

    public String getCustomer_idcard() { return customer_idcard; }
    public void setCustomer_idcard(String customer_idcard) { this.customer_idcard = customer_idcard; }

    public String getCustomer_name() { return customer_name; }
    public void setCustomer_name(String customer_name) { this.customer_name = customer_name; }

    public String getRoom_model() { return room_model; }
    public void setRoom_model(String room_model) { this.room_model = room_model; }

    public String getSub_date() { return sub_date; }
    public void setSub_date(String sub_date) { this.sub_date = sub_date; }

    public String getSub_get_date() { return sub_get_date; }
    public void setSub_get_date(String sub_get_date) { this.sub_get_date = sub_get_date; }

    public String getSub_return_date() { return sub_return_date; }
    public void setSub_return_date(String sub_return_date) { this.sub_return_date = sub_return_date; }

    public String getSub_status() { return sub_status; }
    public void setSub_status(String sub_status) { this.sub_status = sub_status; }

    public static List<sub1> getSubs() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        List<sub1> allsubs = new ArrayList<>();
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM room_reservation";
            PreparedStatement ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                sub1 temp = new sub1(
                	rs.getInt("room_id"),
                    rs.getInt("sub_id"),
                    rs.getString("customer_idcard"),
                    rs.getString("customer_name"),
                    rs.getString("room_model"),
                    rs.getString("sub_date"),
                    rs.getString("sub_get_date"),
                    rs.getString("sub_return_date"),
                    
                    rs.getString("sub_status")
                );
                allsubs.add(temp);
            }
        } finally {
            if (conn != null) conn.close();
        }
        return allsubs;
    }

    public boolean add() throws SQLException {
        Connection conn = null;
        int rs = 0;
        try {
            conn = DBConnection.getConnection();
            String sql = "INSERT INTO room_reservation (customer_idcard, customer_name, room_model, sub_date, sub_get_date, sub_return_date, sub_status,room_id) VALUES (?,?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, this.customer_idcard);
            ps.setString(2, this.customer_name);
            ps.setString(3, this.room_model);
            ps.setString(4, this.sub_date);
            ps.setString(5, this.sub_get_date);
            ps.setString(6, this.sub_return_date);
            ps.setString(7, this.sub_status);
            ps.setInt(8, this.room_id);
            rs = ps.executeUpdate();
        } finally {
            if (conn != null) conn.close();
        }
        return rs == 1;
    }

    public boolean deleteSub() throws SQLException {
        Connection conn = null;
        int rs = 0;
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM room_reservation WHERE sub_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, this.sub_id);
            rs = ps.executeUpdate();
        } finally {
            if (conn != null) conn.close();
        }
        return rs == 1;
    }
}