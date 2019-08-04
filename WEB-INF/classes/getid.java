import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class getid extends HttpServlet
{
	static int user_count=1;
	String name;
	public void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException
	{	
		res.setContentType("text/html");
		String name=req.getParameter("name");
		name=req.getParameter("name");
		user u=new user(user_count,name);
		game.users.add(u);
		PrintWriter out = res.getWriter();
		out.println(user_count);
		user_count++;
	}
}



