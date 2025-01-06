package servlet;

import java.io.BufferedReader;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import bean.TravelService;
import bean.User;

//@WebServlet("/travelService")
public class TravelServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("application/json;charset=UTF-8");

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
         // 从会话中获取用户信息
            User user = (User) request.getSession().getAttribute("user");
            int customerId = user != null ? user.getId() : 1011; // 如果用户未登录，使用默认值1011
            String province = data.get("province");
            String destination = data.get("destination");
            String transportType = data.get("transportType");
            String passagerName = data.get("passagerName");
            String passagerPhone = data.get("passagerPhone");

            // 记录出行信息到数据库
            TravelService travelService = new TravelService();
            boolean success = travelService.saveTravelInfo(customerId, province, destination, transportType, passagerName, passagerPhone);

            // 响应客户端
            if (success) {
                response.getWriter().write("{\"status\":\"success\", \"message\":\"出行信息已成功记录\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"记录出行信息失败\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"服务器内部错误\"}");
            e.printStackTrace();
        }
    }
}