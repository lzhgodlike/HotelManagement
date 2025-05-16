package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	
	/**
	 * 数据库驱动名称 - 使用MySQL 8.0以上的驱动
	 */
	private static final String driverName = "com.mysql.cj.jdbc.Driver";
	
	/**
	 * 数据库连接URL
	 * - 默认端口: 3306
	 * - 默认数据库名: hotel
	 * - 字符编码: UTF-8
	 * - 时区: UTC
	 */
	private static final String url = "jdbc:mysql://localhost:3306/hotel?"
			+ "characterEncoding=utf8&useSSL=false&serverTimezone=UTC"
			+ "&rewriteBatchedStatements=true";
	
	/**
	 * 数据库用户名 - 根据您的MySQL设置修改
	 */
	private static final String user = "root";
	
	/**
	 * 数据库密码 - 根据您的MySQL设置修改
	 */
	private static final String password = "123456";

	private DBConnection() {
	}

	static {
		try {
			Class.forName(driverName);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(url, user, password);
	}

	public static void close(ResultSet rs, Statement st, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (st != null) {
					st.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
}
