package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


import bean.car_model;

/**
 * Servlet implementation class get_car_model
 */
@WebServlet("/get_car_model")
public class get_car_model extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public get_car_model() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("model");//获取要查询的车辆型号
		if(name==null){//如果没有指明model则返回所有的车辆型号信息
			String res = null;	// 存放JSON的字符串变量
			Gson gson = new Gson();	// 创建转换器
			try {
				res = gson.toJson(car_model.getModels());//获得查询结果
			} catch (Exception e) {
				e.printStackTrace();
			} 
			response.getWriter().append(res);//将查询结果返回给前端
		}else{
			String res = null;	
			Gson gson = new Gson();
			try {
				res = gson.toJson(car_model.getCars(name));
			} catch (Exception e) {
				e.printStackTrace();
			} 
			response.getWriter().append(res);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
