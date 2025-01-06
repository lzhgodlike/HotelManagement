package servlet;

import bean.customer1;
import bean.sub1;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/customer1")
public class customerSerclet1 extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String res = null;
        Gson gson = new Gson();
        try {
            res = gson.toJson(customer1.listall());
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
            customer1 customer = new customer1();
            String i = request.getParameter("id");
            
            String sfzhm = request.getParameter("sfzhm");
            String name = request.getParameter("name");
            String unit = request.getParameter("unit");
            String phone = request.getParameter("phone");
           
            customer.setCustomer_id(i);
            customer.setCustomer_idcard(sfzhm);
            customer.setCustomer_name(name);
            customer.setCustomer_unit(unit);
            customer.setCustomer_phone(phone);
        

            int res = customer.UpdateByid(customer);

            response.getWriter().append(String.valueOf(res));


        } else if (avr.equals("delete")) {

            String i = request.getParameter("id");

            customer1 customer = new customer1();
            int res = customer.DeleteByid(i);
            response.getWriter().append(String.valueOf(res));

        } else if (avr.equals("add")) {
            customer1 customer = new customer1();
            String sfzhm = request.getParameter("sfzhm");
            String name = request.getParameter("name");
            String unit = request.getParameter("unit");
            String phone = request.getParameter("phone");
           
            customer.setCustomer_idcard(sfzhm);
            customer.setCustomer_name(name);
            customer.setCustomer_unit(unit);
            customer.setCustomer_phone(phone);
            
            int res = customer.AddKehu(customer);
            response.getWriter().append(String.valueOf(res));
        }


    }
}
