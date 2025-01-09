package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import bean.MealHistory;
import bean.MealPackage;
import bean.MealService;

/**
 * Servlet implementation class ListMealHistories
 */
@WebServlet("/ListMealHistories")
public class ListMealHistories extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListMealHistories() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String res = null;	// 存放JSON的字符串变量
		Gson gson = new Gson();	// 创建转换器
		try {
			// 将套餐数组转换为JSON
			res = gson.toJson(MealHistory.getAllMealHistories());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		// 将JSON数据返回
		response.getWriter().append(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // 获取请求参数
            String statuses = request.getParameter("statuses");
            String timeRange = request.getParameter("timeRange");
            // 调用 Service 层方法获取筛选后的订单记录
            List<MealHistory> filteredHistories = MealHistory.getFilteredMealHistories(statuses, timeRange);

            // 设置响应内容类型
            response.setContentType("application/json;charset=UTF-8");

            // 使用 Jackson 将订单记录转换为 JSON 格式并返回
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonResponse = objectMapper.writeValueAsString(filteredHistories);
            response.getWriter().write(jsonResponse);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"服务器内部错误\"}");
            e.printStackTrace();
        }
	}

}
