package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;


import bean.User;

/**
 * Servlet implementation class listall_user
 */
@WebServlet("/listall_user")
public class listall_user extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public listall_user() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String res = null;	// 存放JSON的字符串变量
		Gson gson = new Gson();	// 创建转换器
		try {
			// 将用户数组转换为JSON
			res = gson.toJson(User.getUsers());
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
