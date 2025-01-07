package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import bean.MealService;
import bean.TravelService;
import bean.User;

/**
 * Servlet implementation class UpdateMealHistoryStatus
 */
//@WebServlet("/UpdateMealHistoryStatus")
public class UpdateMealHistoryStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMealHistoryStatus() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("进入UpdateMealHistoryStatus");
      int serviceId = Integer.parseInt(request.getParameter("serviceId"));
      String newStatus = request.getParameter("status");
      
      System.out.println("serviceId " + serviceId+"\nstatus "+newStatus);
  
      // 调用MealService方法
      MealService mealService = new MealService();
      boolean success = mealService.updateMealServiceStatus(serviceId, newStatus);
      System.out.println(success);
		// 设置响应内容类型
//        response.setContentType("application/json;charset=UTF-8");
//
//        try {
//            // 读取请求体中的 JSON 数据
//            StringBuilder sb = new StringBuilder();
//            BufferedReader reader = request.getReader();
//            String line;
//            while ((line = reader.readLine()) != null) {
//                sb.append(line);
//            }
//            String requestBody = sb.toString();
//
//            // 使用 Jackson 解析 JSON 数据
//            ObjectMapper objectMapper = new ObjectMapper();
//            Map<String, String> data = objectMapper.readValue(requestBody, HashMap.class);
//
//            // 获取请求参数
//         // 从会话中获取用户信息
//            User user = (User) request.getSession().getAttribute("user");
//            int customerId = user != null ? user.getId() : 1011; // 如果用户未登录，使用默认值1011
//            String serviceId = data.get("serviceId");
//            String newStatus = data.get("status");
//            System.out.println("serviceId " + serviceId+"\nstatus "+newStatus);
//
//            // 调用MealService方法
//            MealService mealService = new MealService();
//            boolean success = mealService.updateMealServiceStatus(serviceId, newStatus);
//            // 响应客户端
//            if (success) {
//                response.getWriter().write("{\"status\":\"success\", \"message\":\"出行信息已成功记录\"}");
//            } else {
//                response.getWriter().write("{\"status\":\"error\", \"message\":\"记录出行信息失败\"}");
//            }
//        } catch (Exception e) {
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            response.getWriter().write("{\"status\":\"error\", \"message\":\"服务器内部错误\"}");
//            e.printStackTrace();
//        }
	}

}
