package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class customer1 {
    private int customer_id;
    private String customer_idcard;
    private String customer_name;
    private String customer_unit;
    private String customer_phone;

    public customer1() {}

    public customer1(int customer_id, String customer_idcard, String customer_name, String customer_unit, String customer_phone) {
        this.customer_id = customer_id;
        this.customer_idcard = customer_idcard;
        this.customer_name = customer_name;
        this.customer_unit = customer_unit;
        this.customer_phone = customer_phone;
    }

    public int getCustomer_id() { return customer_id; }
    public void setCustomer_id(int customer_id) { this.customer_id = customer_id; }

    public String getCustomer_idcard() { return customer_idcard; }
    public void setCustomer_idcard(String customer_idcard) { this.customer_idcard = customer_idcard; }

    public String getCustomer_name() { return customer_name; }
    public void setCustomer_name(String customer_name) { this.customer_name = customer_name; }

    public String getCustomer_unit() { return customer_unit; }
    public void setCustomer_unit(String customer_unit) { this.customer_unit = customer_unit; }

    public String getCustomer_phone() { return customer_phone; }
    public void setCustomer_phone(String customer_phone) { this.customer_phone = customer_phone; }

    public boolean addCustomer() throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String checkSql = "SELECT * FROM customer WHERE customer_idcard = ?";
            PreparedStatement ps = conn.prepareStatement(checkSql);
            ps.setString(1, this.customer_idcard);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return false;
            } else {
                String insertSql = "INSERT INTO customer (customer_idcard, customer_name, customer_unit, customer_phone) VALUES (?, ?, ?, ?)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setString(1, this.customer_idcard);
                insertPs.setString(2, this.customer_name);
                insertPs.setString(3, this.customer_unit);
                insertPs.setString(4, this.customer_phone);
                insertPs.executeUpdate();
                return true;
            }
        }
    }

    public boolean deleteCustomer() throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String deleteSql = "DELETE FROM customer WHERE customer_idcard = ?";
            PreparedStatement ps = conn.prepareStatement(deleteSql);
            ps.setString(1, this.customer_idcard);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean updateCustomer() throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String updateSql = "UPDATE customer SET customer_name = ?, customer_unit = ?, customer_phone = ? WHERE customer_idcard = ?";
            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setString(1, this.customer_name);
            ps.setString(2, this.customer_unit);
            ps.setString(3, this.customer_phone);
            ps.setString(4, this.customer_idcard);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public static List<customer1> listAllCustomers() throws SQLException {
        List<customer1> customers = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customer";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customer1 customer = new customer1();
                customer.customer_id = rs.getInt("customer_id");
                customer.customer_idcard = rs.getString("customer_idcard");
                customer.customer_name = rs.getString("customer_name");
                customer.customer_unit = rs.getString("customer_unit");
                customer.customer_phone = rs.getString("customer_phone");
                customers.add(customer);
            }
        }
        return customers;
    }
    public boolean getCustomer() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "select * from `customer` where `customer_idcard` = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, this.customer_idcard);
            rs = ps.executeQuery();
            if (rs.next() == true) {
                return false;
            } else {
                String addsql = "insert into `customer` (customer_idcard,customer_name,customer_unit,customer_phone) values(?,?,?,?)";
                PreparedStatement addps = conn.prepareStatement(addsql);
                addps.setString(1, this.customer_idcard);
                addps.setString(2, this.customer_name);
                addps.setString(3, this.customer_unit);
                addps.setString(4, this.customer_phone);
               
                int addrs = addps.executeUpdate();
                return true;
            }
        } finally {
            conn.close();
        }
    }
    
    public int UpdateByid(customer1 customer) {

        int i = 0;
        Connection conn = null;
        PreparedStatement ps = null;

       
      
        try {
            conn = DBConnection.getConnection();
            String sql = " update customer set customer_idcard =?, customer_name=?,customer_unit=?,customer_phone=?  where customer_id=?";

            ps = conn.prepareStatement(sql);

            ps.setString(1, customer.getCustomer_idcard());
            ps.setString(2, customer.getCustomer_name());
            ps.setString(3, customer.getCustomer_unit());
            ps.setString(4, customer.getCustomer_phone());
            
            ps.setInt(5, customer.getCustomer_id());
            i = ps.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return i;
    }

    /*删除*/
    public int DeleteByid(int id) {
        int i = 0;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            String sql = " delete from customer where customer_id=?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            i = ps.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return i;
    }


    /*添加客户信息*/

    public int AddKehu(customer1 customer){

        int i = 0;
        Connection conn = null;
        PreparedStatement ps = null;

        
        try {
            conn = DBConnection.getConnection();
            String sql = " insert into customer values (?,?,?,?,?)";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, 0);
            ps.setString(2, customer.getCustomer_idcard());
            ps.setString(3, customer.getCustomer_name());
            ps.setString(4, customer.getCustomer_unit());
            ps.setString(5, customer.getCustomer_phone());
          
            i = ps.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return i;
    }
}
