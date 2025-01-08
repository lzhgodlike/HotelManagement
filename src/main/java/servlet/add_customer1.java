package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;

import bean.customer1;

/**
 * Servlet implementation class add_customer1
 */
@WebServlet("/add_customer1")
public class add_customer1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public add_customer1() {
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
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
        StringBuffer stringBuffer = new StringBuffer();
        String iString = bufferedReader.readLine();
        while (iString != null) {
            stringBuffer.append(iString);
            iString = bufferedReader.readLine();
        }
        String json = new String(stringBuffer);
        System.out.println(json);

        // 自定义日期格式化器
        Gson gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX")
                .create();

        try {
            customer1 customer = gson.fromJson(json, customer1.class);
            boolean res = customer.getCustomer();
            response.getWriter().append(String.valueOf(res));
        } catch (JsonSyntaxException | SQLException e) {
            e.printStackTrace();
            response.getWriter().append("false");
        }
    }
}