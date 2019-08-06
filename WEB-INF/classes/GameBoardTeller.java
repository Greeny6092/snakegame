import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class GameBoardTeller extends HttpServlet
{
	public void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException
	{	
		res.setContentType("text/event-stream, charset=UTF-8");
		int gid=Integer.parseInt(req.getParameter("gid"));
		String  output="";
		for(gameboard g:game.gameboards)
		{
			if(g.gameboard_id==gid)
			{
				output=new String(g.getString());
				break;
			}
		}
		
		PrintWriter out=res.getWriter();
		out.write("event:boardstatus\n"); 
		out.write("data:"+output+" \n\n");
		//out.write("data:here comes the status \n\n");
	}
	
}



