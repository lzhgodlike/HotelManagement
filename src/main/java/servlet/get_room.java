package servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.room;
import bean.room_type;

@WebServlet("/get_room")
public class get_room extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public get_room() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String room_id = request.getParameter("room_id");
		if(room_id==null){
			response.getWriter().append("错误页面");
		}else{
			try {
				room troom =  (room)room_type.getRoomByRoomId(room_id);
				
				request.setAttribute("troom", troom);
				request.getRequestDispatcher("/sub_detail.jsp").forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}