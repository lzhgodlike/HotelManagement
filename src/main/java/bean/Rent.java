package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import util.DBConnection;

public class Rent {
	private String car_model;
	private float rent;
	
	public String getCar_model() {
		return car_model;
	}
	public void setCar_model(String car_model) {
		this.car_model = car_model;
	}
	public float getRent() {
		return rent;
	}
	public void setRent(float rent) {
		this.rent = rent;
	}
	
	public Rent(String car_model, float rent) {
		super();
		this.car_model = car_model;
		this.rent = rent;
	}

	public Rent() {
		super();
		// TODO Auto-generated constructor stub
	}
	public static java.sql.Date setString2SQLDate(String dateStr){
	       SimpleDateFormat dateFormatHiddenHour = new SimpleDateFormat("yyyy-MM-dd");   
	       java.sql.Date date = null;   
	       try {       
	            String s = dateFormatHiddenHour.format(dateFormatHiddenHour.parse(dateStr));    
	            date = java.sql.Date.valueOf(s);   
	        } catch (ParseException e) {  
	            // TODO Auto-generated catch block    
	            e.printStackTrace();    

	        }
		return date;   
	}
		public static List<Rent> listAll(String m1,String m2) throws ClassNotFoundException, SQLException{
			Map<String,Float> map = new HashMap<String,Float>();
			Date out_date=setString2SQLDate(m1);
			Date back_date=setString2SQLDate(m2);
			List<Rent> list = new ArrayList<Rent>();
			try{
				Connection conn = null;
				Statement st = null;
				ResultSet rs;
				conn = DBConnection.getConnection();
				String sql = "select * from rent_cash";
				st = conn.createStatement();
				rs = st.executeQuery(sql);
			while(rs.next()){
				Date b1=rs.getDate("out_date");
				Date b2=rs.getDate("return_date");
				if(out_date.before(b2) && b2.before(back_date)){
					if(map.get(rs.getString("car_model"))!=null){
					    map.put(rs.getString("car_model"),map.get(rs.getString("car_model"))+rs.getFloat("rent"));
					  }else{
					    map.put(rs.getString("car_model"),rs.getFloat("rent"));
					  }
				}	
			}
			float w=0;
			for(Entry<String, Float> entry : map.entrySet()){
			    String mapKey = entry.getKey();
			    Float mapValue = entry.getValue();
			    w=w+mapValue;
				Rent use = new Rent();
				use.setRent(mapValue);
				use.setCar_model(mapKey);
				list.add(use);
			}
			Rent use = new Rent();
			use.setRent(w);
			use.setCar_model("total");
			list.add(use);
			for(int i=0;i<list.size();i++){
				System.out.print(list.get(i).getRent());
				System.out.println(list.get(i).getCar_model());
			}
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return list;	
		}
	


}
