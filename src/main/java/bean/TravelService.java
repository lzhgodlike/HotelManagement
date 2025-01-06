package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DBConnection;

public class TravelService {
	private int serviceId;
	private int customerId;
	private String province;
	private String destinatiton;
	private String transportType;
	private String passengerName;
	private String passengePhone;
	private String serviceStatus;
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
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getDestinatiton() {
		return destinatiton;
	}
	public void setDestinatiton(String destinatiton) {
		this.destinatiton = destinatiton;
	}
	public String getTransportType() {
		return transportType;
	}
	public void setTransportType(String transportType) {
		this.transportType = transportType;
	}
	public String getPassengerName() {
		return passengerName;
	}
	public void setPassengerName(String passengerName) {
		this.passengerName = passengerName;
	}
	public String getPassengePhone() {
		return passengePhone;
	}
	public void setPassengePhone(String passengePhone) {
		this.passengePhone = passengePhone;
	}
	public String getServiceStatus() {
		return serviceStatus;
	}
	public void setServiceStatus(String serviceStatus) {
		this.serviceStatus = serviceStatus;
	}
	public boolean saveTravelInfo(int customerId, String province, String destination, String transportType, String passagerName, String passagerPhone) {
        // 这里实现将信息保存到数据库的逻辑
        // 返回true表示成功，false表示失败
    	Connection conn = null;
    	PreparedStatement ps = null;
    	int lines = 0;
    	try {
			conn = DBConnection.getConnection();
			String sql = "insert into travel_services(customer_id, province, destination, transport_type, passenger_name, passenger_phone)"
					+ "values(?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, customerId);
			ps.setString(2, province);
			ps.setString(3, destination);
			ps.setString(4, transportType);
			ps.setString(5, passagerName);
			ps.setString(6, passagerPhone);
			
			lines = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(null, ps, conn);
		}
        return lines == 1 ? true : false; // 示例中直接返回true
    }
}
