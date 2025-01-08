package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class RentCase {
	private int case_id;
	private int customer_id;
    private String customer_idcard;
    private String customer_name;
    private String customer_unit;
    private String customer_phone;
    private String pick_status;
    private int deposit;
    private boolean food_services;
    private boolean mobility_services;
    private String amount_spent;

    public RentCase(int case_id, int customer_id, String customer_idcard, String customer_name, String customer_unit,
			String customer_phone, String pick_status, int deposit, boolean food_services, boolean mobility_services,
			String amount_spent) {
		super();
		this.case_id = case_id;
		this.customer_id = customer_id;
		this.customer_idcard = customer_idcard;
		this.customer_name = customer_name;
		this.customer_unit = customer_unit;
		this.customer_phone = customer_phone;
		this.pick_status = pick_status;
		this.deposit = deposit;
		this.food_services = food_services;
		this.mobility_services = mobility_services;
		this.amount_spent = amount_spent;
	}

	public RentCase() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getCase_id() {
		return case_id;
	}
	
	public void setCase_id() {
		this.case_id = case_id;
	}
	
	public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
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

    public String getPick_status() {
        return pick_status;
    }

    public void setPick_status(String pick_status) {
        this.pick_status = pick_status;
    }

    public int getDeposit() {
        return deposit;
    }

    public void setDeposit(int deposit) {
        this.deposit = deposit;
    }

    public boolean isFood_services() {
        return food_services;
    }

    public void setFood_services(boolean food_services) {
        this.food_services = food_services;
    }

    public boolean isMobility_services() {
        return mobility_services;
    }

    public void setMobility_services(boolean mobility_services) {
        this.mobility_services = mobility_services;
    }

    public String getAmount_spent() {
        return amount_spent;
    }

    public void setAmount_spent(String amount_spent) {
        this.amount_spent = amount_spent;
    }
    
    
    public static List<RentCase> getRentCase() throws SQLException {
    	Connection conn = null;
    	ResultSet rs = null;
    	List<RentCase> allCase = new ArrayList<RentCase>();
    	PreparedStatement ps = null;
    	try {
    		conn = DBConnection.getConnection();
    		String sql = "select * from `rent_case`";
    		ps = conn.prepareStatement(sql);
    		rs = ps.executeQuery();
    		while(rs.next()) {
    			RentCase rc = new RentCase(rs.getInt("case_id"), rs.getInt("customer_id"),rs.getString("customer_idcard"),rs.getString("customer_name"),rs.getString("customer_unit"),rs.getString("customer_phone"),rs.getString("pick_status"),rs.getInt("deposit"),rs.getBoolean("food_services"),rs.getBoolean("mobility_services"),rs.getString("amount_spent"));
    			allCase.add(rc);
    		}
    	}finally {
    		conn.close();
    		ps.close();
    		rs.close();
    	}
    	return allCase;	
    }
    
    
}
