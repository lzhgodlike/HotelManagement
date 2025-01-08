package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.sub1;

@WebServlet("/add_sub1")
public class add_sub1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public add_sub1() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String res = null;
        Gson gson = new Gson();
        try {
            res = gson.toJson(sub1.getSubs());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.getWriter().append(res);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
        StringBuffer stringBuffer = new StringBuffer();
        String iString = bufferedReader.readLine();
        while (iString != null) {
            stringBuffer.append(iString);
            iString = bufferedReader.readLine();
        }
        String json = new String(stringBuffer);
        Gson gson = new Gson();
        sub1 sub = gson.fromJson(json, sub1.class);
        try {
            boolean res = sub.add();
            response.getWriter().append(String.valueOf(res));
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().append("Error: " + e.getMessage());
        }
    }
}