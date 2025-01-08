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

import bean.User;

/**
 * Servlet implementation class recover
 */
@WebServlet("/recover")
public class recover extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public recover() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("滚出去！");
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
        Gson gson = new Gson();
        User user = gson.fromJson(json, User.class);
        try {
            boolean res = user.recoverUser();
            response.getWriter().append(String.valueOf(res));
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "数据库操作失败");
        } finally {
            if (bufferedReader != null) {
                bufferedReader.close(); // 确保 BufferedReader 被关闭
            }
        }
    }
}
