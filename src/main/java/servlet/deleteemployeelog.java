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

import bean.Employeelog;
//
/**
 * Servlet implementation class deleteuser
 */
@WebServlet("/deleteemployeelog")
public class deleteemployeelog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteemployeelog() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("滚出去！");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(request.getInputStream(), "utf-8"));
		StringBuffer stringBuffer = new StringBuffer();
		String iString = bufferedReader.readLine();
		while (iString!= null) {
			stringBuffer.append(iString);
			iString = bufferedReader.readLine();
		}
		String json = new String(stringBuffer);
		Gson gson = new Gson();
		Employeelog user= gson.fromJson(json, Employeelog.class);
		try {
			boolean res = user.deleteUser();
			response.getWriter().append(String.valueOf(res));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
