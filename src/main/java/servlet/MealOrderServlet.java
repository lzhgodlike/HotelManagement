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
import bean.User;

@WebServlet("/mealOrder")
public class MealOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 读取请求体中的 JSON 数据
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String requestBody = sb.toString();

            // 使用 Jackson 解析 JSON 数据
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, String> data = objectMapper.readValue(requestBody, HashMap.class);

            // 获取请求参数
            User user = (User) request.getSession().getAttribute("user");
            int customerId = user != null ? user.getId() : 1011; // 如果用户未登录，使用默认值1011

            // 获取并转换 packageId
            String packageIdString = data.get("packageId");
            if (packageIdString == null || !packageIdString.matches("\\d+")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"status\":\"error\", \"message\":\"无效的套餐ID\"}");
                return;
            }
            int packageId = Integer.parseInt(packageIdString);

            // 获取其他参数
            String deliveryTime = data.get("deliveryTime");
            String deliveryAddress = data.get("deliveryAddress");

            // 调用Service层方法
            MealService mealService = new MealService();
            boolean orderSuccess = mealService.addMealOrder(customerId, packageId, deliveryTime, deliveryAddress);

            // 设置响应内容类型
            response.setContentType("application/json;charset=UTF-8");
            // 响应客户端
            if (orderSuccess) {
                response.getWriter().write("{\"status\":\"success\", \"message\":\"餐饮订单提交成功\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"餐饮订单提交失败\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"服务器内部错误\"}");
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}