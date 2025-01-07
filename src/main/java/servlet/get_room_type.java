package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import bean.room_type;

/**
 * Servlet implementation class get_room_model
 */
@WebServlet("/get_room_type")
public class get_room_type extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public get_room_type() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("model");//获取要查询的车辆型号
		if(name==null){//如果没有指明model则返回所有的车辆型号信息
			String res = null;	// 存放JSON的字符串变量
			Gson gson = new Gson();	// 创建转换器
			try {
				res = gson.toJson(room_type.getTypes());//获得查询结果
			} catch (Exception e) {
				e.printStackTrace();
			} 
			response.getWriter().append(res);//将查询结果返回给前端
		}else{
			String res = null;	
			Gson gson = new Gson();
			try {
				res = gson.toJson(room_type.getRooms(name));
			} catch (Exception e) {
				e.printStackTrace();
			} 
			response.getWriter().append(res);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
