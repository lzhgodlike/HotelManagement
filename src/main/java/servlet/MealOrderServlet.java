package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.MealService;
import bean.User;

@WebServlet("/mealOrder")
public class MealOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 从会话中获取用户信息
        User user = (User) request.getSession().getAttribute("user");
        int customerId = user != null ? user.getId() : 1011; // 如果用户未登录，使用默认值1011
        
        // 获取请求参数
        int packageId = Integer.valueOf(request.getParameter("packageId"));
        String deliveryTime = request.getParameter("deliveryTime");
        String deliveryAddress = request.getParameter("deliveryAddress");
        
        // 调用Service层方法
        MealService mealService = new MealService();
        boolean orderSuccess = mealService.addMealOrder(customerId, packageId, deliveryTime, deliveryAddress);
        
        // 根据订单处理结果重定向到相应页面
        if (orderSuccess) {
            response.sendRedirect("orderSuccess.jsp");
        } else {
            response.sendRedirect("orderFailure.jsp"); // 可选：创建一个失败页面
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}