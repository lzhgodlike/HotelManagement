package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.pick;
import bean.sub;

/**
 * Servlet implementation class add_pick
 */
@WebServlet("/add_pick")

public class add_pick extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public add_pick() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
  //接收前端发送的提车信息并调用pick中的方法插入数据库
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String res = null;	// 存放JSON的字符串变量
		Gson gson = new Gson();	// 创建转换器
		try {
			res = gson.toJson(pick.getPicks());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.getWriter().append(res);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
		StringBuffer stringBuffer = new StringBuffer();
		String iString = bufferedReader.readLine();
		while (iString!= null) {
			stringBuffer.append(iString);
			iString = bufferedReader.readLine();
		}
		String json = new String(stringBuffer);
		System.out.println(json);
		Gson gson = new Gson();
		pick pick= gson.fromJson(json, pick.class);
		System.out.println(pick.getCustomer_idcard());
		try {
			boolean res = pick.addPick();
			response.getWriter().append(String.valueOf(res));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//response.getWriter().append("true");
		catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
