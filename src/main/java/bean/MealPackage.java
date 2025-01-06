package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBConnection;

public class MealPackage {
	private int packageId;
	private String packageName;
	private String description;
	private Double price;
	private String pictureSrc;
	public int getPackageId() {
		return packageId;
	}
	public void setPackageId(int packageId) {
		this.packageId = packageId;
	}
	public String getPackageName() {
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	
	public String getPictureSrc() {
		return pictureSrc;
	}
	public void setPictureSrc(String pictureSrc) {
		this.pictureSrc = pictureSrc;
	}
	public List<MealPackage> getAllPackages(){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<MealPackage> mealPackages = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			String sql = "select * from meal_packages";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				int packageId = rs.getInt("package_id");
				String packageName = rs.getString("package_name");
				String description = rs.getString("description");
				double price = rs.getDouble("price");
				String pictureSrc = rs.getString("picture_src");
				MealPackage mealPackage = new MealPackage();
				mealPackage.setPackageId(packageId);
				mealPackage.setPackageName(packageName);
				mealPackage.setDescription(description);
				mealPackage.setPrice(price);
				mealPackage.setPictureSrc(pictureSrc);
				mealPackages.add(mealPackage);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBConnection.close(rs, null, conn);
		}
		return mealPackages;
	}
}
