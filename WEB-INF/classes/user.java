import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class user extends HttpServlet
{
	int id,points,status;
	String name=new String();
	ArrayList<request> requests=new ArrayList<request>();
	public user(int id,String name)
	{
		this.name=name;
		this.id=id;
		points=0;
		status=0;
	}
	
	void addRequest(int id)
	{
		
		user u=game.getUserById(id);
		u.requests.add(new request(this));
	}
	
	public void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException
	{	
	
	}
}



