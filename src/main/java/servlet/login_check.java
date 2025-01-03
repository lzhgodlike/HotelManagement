package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import bean.User;

/**
 * Servlet implementation class login_check
 */
@WebServlet("/login_check")
public class login_check extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public login_check() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		String res = null;
		try {
			res = user.check();
			if (res.equals("pass")) {
				HttpSession session = request.getSession();
				session.setMaxInactiveInterval(50 * 60);
				session.setAttribute("role", user.getRole());
				session.setAttribute("user", user);
				switch (user.getRole()) {
				case "管理员":
					response.getWriter().append("/z-index/admin.jsp");
					break;
				case "普通业务员":
					response.getWriter().append("/z-index/business.jsp");
					break;
				case "经理":
					response.getWriter().append("/z-index/manager.jsp");
					break;
				default:
					response.getWriter().append("error");
				}
			} else {
				response.getWriter().append("has error");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// response.getWriter().append(res);
	}

}
