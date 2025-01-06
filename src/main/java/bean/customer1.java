package bean;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

//修改客户信息表
public class customer1 {
    private String customer_id;
    private String customer_idcard;
    private String customer_name;
    private String customer_unit;
    private String customer_phone;
    

    public String getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(String customer_id) {
        this.customer_id = customer_id;
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

    public String getCustomer_unit() {
        return customer_unit;
    }

    public void setCustomer_unit(String customer_unit) {
        this.customer_unit = customer_unit;
    }

    public String getCustomer_phone() {
        return customer_phone;
    }

    public void setCustomer_phone(String customer_phone) {
        this.customer_phone = customer_phone;
    }


    public customer1(String customer_id, String customer_idcard, String customer_name, String customer_unit,
                    String customer_phone) {
        super();
        this.customer_id = customer_id;
        this.customer_idcard = customer_idcard;
        this.customer_name = customer_name;
        this.customer_unit = customer_unit;
        this.customer_phone = customer_phone;
        
    }

    public customer1() {

    }

    public boolean addCustomer() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "insert* from `customer` where `customer_idcard` = ?";
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

    public boolean deleteCustomer() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "delete * from `customer` where `customer_idcard` = ?";
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

    public boolean updateCustomer() throws SQLException {
        Connection conn = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "update * from `customer` where `customer_idcard` = ?";
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

    /*查询客户表*/
    public static List<customer1> listall() {
        Connection conn = null;
        ResultSet rs = null;
        ArrayList<customer1> customers = new ArrayList<>();
        try {
            conn = DBConnection.getConnection();

            String sql = " select * from customer";
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {

                customer1 customer = new customer1();

                customer.setCustomer_id(rs.getString("customer_id"));
                customer.setCustomer_idcard(rs.getString("customer_idcard"));
                customer.setCustomer_name(rs.getString("customer_name"));
                customer.setCustomer_unit(rs.getString("customer_unit"));
                customer.setCustomer_phone(rs.getString("customer_phone"));
//                customer.setRgin_date(String.valueOf(rs.getDate("regin_date")));
                customers.add(customer);

            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return customers;
    }


    /*修改*/

    public int UpdateByid(customer1 customer) {

        int i = 0;
        Connection conn = null;
        PreparedStatement ps = null;

//        String rgin_date = customer.getRgin_date();
//        Date date = Date.valueOf(rgin_date);
        try {
            conn = DBConnection.getConnection();
            String sql = " update customer set customer_idcard =?, customer_name=?,customer_unit=?,customer_phone=? where customer_id=?";

            ps = conn.prepareStatement(sql);

            ps.setString(1, customer.getCustomer_idcard());
            ps.setString(2, customer.getCustomer_name());
            ps.setString(3, customer.getCustomer_unit());
            ps.setString(4, customer.getCustomer_phone());
//            ps.setDate(5, date);
            ps.setString(5, customer.getCustomer_id());
            i = ps.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return i;
    }

    /*删除*/
    public int DeleteByid(String id) {
        int i = 0;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            String sql = " delete from customer where customer_id=?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
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

//        String rgin_date = customer.getRgin_date();
//        Date date = Date.valueOf(rgin_date);
        try {
            conn = DBConnection.getConnection();
            String sql = " insert into customer values (?,?,?,?,?)";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, 0);
            ps.setString(2, customer.getCustomer_idcard());
            ps.setString(3, customer.getCustomer_name());
            ps.setString(4, customer.getCustomer_unit());
            ps.setString(5, customer.getCustomer_phone());
//            ps.setDate(6, date);
            i = ps.executeUpdate();

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        return i;
    }
}


