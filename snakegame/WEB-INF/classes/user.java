import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class user extends HttpServlet
{
	String name=new String();
	int points,id;
	public user(int id,String name)
	{
		this.name=name;
		this.id=id;
		points=0;
	}
	
	public void doGet(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException
	{	

	}
}



