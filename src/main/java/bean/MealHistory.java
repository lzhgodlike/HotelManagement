package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class MealHistory {
	private int serviceId;
	private int customerId;
	private int packageId;
	private String deliveryTime;
	private String deliveryAddress;
	private String status;
	private String description;
	private String price;
	private String packageName;
	private String createTime;
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPackageName() {
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	
	public static List<MealHistory> getAllMealHistories() {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<MealHistory> mealHistories = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			String sql = "SELECT ms.service_id, ms.customer_id, ms.package_id, ms.delivery_time, ms.delivery_address, ms.status, ms.create_time, mp.description, mp.price, mp.package_name " +
						"FROM meal_service ms " +
						"JOIN meal_packages mp ON ms.package_id = mp.package_id";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				int serviceId = rs.getInt("service_id");
				int customerId = rs.getInt("customer_id");
				int packageId = rs.getInt("package_id");
				String deliveryTime = rs.getString("delivery_time");
				String deliveryAddress = rs.getString("delivery_address");
				String status = rs.getString("status");
				String description = rs.getString("description");
				String price = rs.getString("price");
				String packageName = rs.getString("package_name");
				String createTime = rs.getString("create_time");
				MealHistory mealHistory = new MealHistory();
				mealHistory.setServiceId(serviceId);
				mealHistory.setCustomerId(customerId);
				mealHistory.setPackageId(packageId);
				mealHistory.setDeliveryTime(deliveryTime);
				mealHistory.setDeliveryAddress(deliveryAddress);
				mealHistory.setStatus(status);
				mealHistory.setDescription(description);
				mealHistory.setPrice(price);
				mealHistory.setPackageName(packageName);
				mealHistory.setCreateTime(createTime);
				mealHistories.add(mealHistory);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(rs, ps, conn);
		}
		return mealHistories;
	}
	
	public static List<MealHistory> getFilteredMealHistories(String statuses, String timeRange) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<MealHistory> mealHistories = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			StringBuilder sql = new StringBuilder("SELECT ms.service_id, ms.customer_id, ms.package_id, ms.delivery_time, ms.delivery_address, ms.status, ms.create_time, mp.description, mp.price, mp.package_name " +
												"FROM meal_service ms " +
												"JOIN meal_packages mp ON ms.package_id = mp.package_id " +
												"WHERE 1=1");
			// 根据订单状态筛选
			if (statuses != null && !statuses.isEmpty()) {
				String[] statusArray = statuses.split(",");
				sql.append(" and ms.status in (");
				for (int i = 0; i < statusArray.length; i++) {
					if (i > 0) {
						sql.append(", ");
					}
					sql.append("?");
				}
				sql.append(")");
			}

			// 根据订单时间筛选
			if (timeRange != null && !timeRange.isEmpty()) {
				sql.append(" and ms.create_time >= ?");
				if ("today".equals(timeRange)) {
					sql.append(" and ms.create_time < date_add(curdate(), interval 1 day)");
				} else if ("week".equals(timeRange)) {
					sql.append(" and ms.create_time < date_add(curdate(), interval 7 day)");
				} else if ("month".equals(timeRange)) {
					sql.append(" and ms.create_time < date_add(curdate(), interval 30 day)");
				}
			}

			ps = conn.prepareStatement(sql.toString());

			// 设置参数
			int paramIndex = 1;
			if (statuses != null && !statuses.isEmpty()) {
				String[] statusArray = statuses.split(",");
				for (String status : statusArray) {
					ps.setString(paramIndex++, status);
				}
			}

			if (timeRange != null && !timeRange.isEmpty()) {
				ps.setString(paramIndex++, LocalDate.now().toString());
			}

			rs = ps.executeQuery();
			while (rs.next()) {
				int serviceId = rs.getInt("service_id");
				int customerId = rs.getInt("customer_id");
				int packageId = rs.getInt("package_id");
				String deliveryTime = rs.getString("delivery_time");
				String deliveryAddress = rs.getString("delivery_address");
				String status = rs.getString("status");
				String description = rs.getString("description");
				String price = rs.getString("price");
				String packageName = rs.getString("package_name");
				String createTime = rs.getString("create_time");
				MealHistory mealHistory = new MealHistory();
				mealHistory.setServiceId(serviceId);
				mealHistory.setCustomerId(customerId);
				mealHistory.setPackageId(packageId);
				mealHistory.setDeliveryTime(deliveryTime);
				mealHistory.setDeliveryAddress(deliveryAddress);
				mealHistory.setStatus(status);
				mealHistory.setDescription(description);
				mealHistory.setPrice(price);
				mealHistory.setPackageName(packageName);
				mealHistory.setCreateTime(createTime);
				mealHistories.add(mealHistory);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(rs, ps, conn);
		}
		return mealHistories;
	}
	
}
