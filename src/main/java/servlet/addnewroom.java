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

import bean.room;

@WebServlet("/addnewroom")
public class addnewroom extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addnewroom() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int name = 0;
		name = Integer.parseInt(request.getParameter("num"));
		if(name!=0){
			String res = null;	
			Gson gson = new Gson();	
			try {
				res = gson.toJson(room.deleteRoom(name));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.getWriter().append(res);
		}else{
			response.getWriter().append("����ҳ��");
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
		room room= gson.fromJson(json, room.class);
		System.out.println(room.getRoom_id());
		try {
			boolean res = room.addRoom();
			response.getWriter().append(String.valueOf(res));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
