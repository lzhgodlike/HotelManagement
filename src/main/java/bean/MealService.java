package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

import util.DBConnection;

public class MealService {
	private int serviceId;
	private int customerId;
	private int packageId;
	private Date deliveryTime;
	private String deliveryAddress;
	private String status;
	public int getServiceId() {
		return serviceId;
	}
	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public int getPackageId() {
		return packageId;
	}
	public void setPackageId(int packageId) {
		this.packageId = packageId;
	}
	public Date getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(Date deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public boolean addMealOrder(int customerId, int packageId, String deliveryTime, String deliveryAddress) {
		// 连接数据库
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();

            // 插入或更新订单信息
            String sql = "INSERT INTO meal_service (customer_id, package_id, delivery_time, delivery_address) VALUES (?, ?, ?, ?) ";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, packageId);
            pstmt.setString(3, deliveryTime);
            pstmt.setString(4, deliveryAddress);
            pstmt.executeUpdate();
			return true;
        } catch (SQLException e) {
            e.printStackTrace();
			return false;
        } finally {
            DBConnection.close(null, pstmt, conn);
        }
	}
}
