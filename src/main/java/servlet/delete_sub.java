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

import bean.User;
import bean.car;
import bean.car_model;
import bean.sub1;

/**
 * Servlet implementation class delete_sub
 */
@WebServlet("/delete_sub")
public class delete_sub extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public delete_sub() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String num = request.getParameter("id");
		if(num==null){
			response.getWriter().append("错误页面");
		}else{
			response.getWriter().append(num);
			/*try {
				car tcar =  (car)car_model.getCar(num);
				System.out.println(tcar.getId()+tcar.getNumber());
				request.setAttribute("tcar", tcar);
				request.getRequestDispatcher("/sub_detail.jsp").forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		}
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
		sub1 sub = gson.fromJson(json, sub1.class);
		System.out.println(sub.getSub_id());
		try {
			boolean res = sub.deleteSub();
			response.getWriter().append(String.valueOf(res));
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
