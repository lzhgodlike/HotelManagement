package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import util.DBConnection;

public class MealService {
	private int serviceId;
	private int customerId;
	private int packageId;
	private String deliveryTime;
	private String deliveryAddress;
	private String status;
	private String createTime;
	
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
	public String getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(String deliveryTime) {
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
	
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public boolean addMealOrder(int customerId, int packageId, String deliveryTime, String deliveryAddress) {
		// 连接数据库
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String createTime = LocalDate.now().toString() + LocalTime.now().toString().substring(0, 5);
            // 插入或更新订单信息
            String sql = "insert into meal_service(customer_id, package_id, delivery_time, delivery_address, create_time) values (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, customerId);
            pstmt.setInt(2, packageId);
            pstmt.setString(3, deliveryTime);
            pstmt.setString(4, deliveryAddress);
            pstmt.setString(5, createTime);
            pstmt.executeUpdate();
			return true;
        } catch (SQLException e) {
            e.printStackTrace();
			return false;
        } finally {
            DBConnection.close(null, pstmt, conn);
        }
	}
	public static List<MealService> getAllMealHistories() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<MealService> mealHistories = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			String sql = "select * from meal_service";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				int serviceId = rs.getInt("service_id");
				int customerId = rs.getInt("customer_id");
				int packageId = rs.getInt("package_id");
				String deliveryTime = rs.getString("delivery_time");
				String deliveryAddress = rs.getString("delivery_address");
				String status = rs.getString("status");
				String createTime = rs.getString("create_time");
				MealService mealService = new MealService();
				mealService.setServiceId(serviceId);
				mealService.setCustomerId(customerId);
				mealService.setPackageId(packageId);
				mealService.setDeliveryTime(deliveryTime);
				mealService.setDeliveryAddress(deliveryAddress);
				mealService.setCreateTime(createTime);
				mealService.setStatus(status);
				mealHistories.add(mealService);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnection.close(rs, null, conn);
		}
		return mealHistories;
	}
	public boolean updateMealServiceStatus(int serviceId, String newStatus) {
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = DBConnection.getConnection();
			String sql = "update meal_service set status = ? where service_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, newStatus);
			ps.setInt(2, serviceId);
			ps.executeUpdate();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
}
