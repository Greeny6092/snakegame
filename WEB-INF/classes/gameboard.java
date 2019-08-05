import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class gameboard extends HttpServlet
{
	user u1;
	user u2;
	public gameboard(user u1,user u2)
	{
		this.u1=u1;
		this.u2=u2;
	}
}



