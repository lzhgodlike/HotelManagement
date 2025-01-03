package servlet;

import bean.customer;
import bean.sub;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer")
public class CustomerSerclet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String res = null;
        Gson gson = new Gson();
        try {
            res = gson.toJson(customer.listall());
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        response.getWriter().append(res);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String avr = request.getParameter("avr");

        if (avr.equals("update")) {
            customer customer = new customer();
            String i = request.getParameter("id");
            Integer integer = Integer.valueOf(i);
            String sfzhm = request.getParameter("sfzhm");
            String name = request.getParameter("name");
            String unit = request.getParameter("unit");
            String phone = request.getParameter("phone");
            String date = request.getParameter("date");
            customer.setCustomer_id(integer);
            customer.setCustomer_idcard(sfzhm);
            customer.setCustomer_name(name);
            customer.setCustomer_unit(unit);
            customer.setCustomer_phone(phone);
            customer.setRgin_date(date);

            int res = customer.UpdateByid(customer);

            response.getWriter().append(String.valueOf(res));


        } else if (avr.equals("delete")) {

            String i = request.getParameter("id");

            customer customer = new customer();
            int res = customer.DeleteByid(i);
            response.getWriter().append(String.valueOf(res));

        } else if (avr.equals("add")) {
            customer customer = new customer();
            String sfzhm = request.getParameter("sfzhm");
            String name = request.getParameter("name");
            String unit = request.getParameter("unit");
            String phone = request.getParameter("phone");
            String date = request.getParameter("date");
            customer.setCustomer_idcard(sfzhm);
            customer.setCustomer_name(name);
            customer.setCustomer_unit(unit);
            customer.setCustomer_phone(phone);
            customer.setRgin_date(date);
            int res = customer.AddKehu(customer);
            response.getWriter().append(String.valueOf(res));
        }


    }
}
