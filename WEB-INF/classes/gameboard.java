import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class gameboard extends HttpServlet
{
	user u1;
	user u2;
	int status;
	int gameboard_id;
	static int gameboard_count=0;
	int matrix[][]=new int[10][12];
	public void init()
	{
		for(int i=0;i<10;i++)
		{
			for(int j=0;j<12;j++)
			{
				if(i==4&&j<3)
				{
					matrix[i][j]=0;
				}
				else if(i==5&&j>8)
				{
					matrix[i][j]=1;
				}
				else
				{
					matrix[i][j]=2;
				}
			}
		}
	}
	
	public String getString()
	{
		String output=new String();
		for(int i=0;i<10;i++)
		{
			for(int j=0;j<12;j++)
			{
				output+=(Integer.toString(matrix[i][j]));
			}
		}
		return output;
	}
	public gameboard(user u1,user u2)
	{
		this.u1=u1;
		this.u2=u2;
		status=1;
		gameboard_id=gameboard.gameboard_count;
		gameboard.gameboard_count++;
	}
}



