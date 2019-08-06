import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

public class gameboard extends HttpServlet
{
	user u1;
	user u2;
	Queue<Integer> u1move=new LinkedList<Integer>();
	Queue<Integer> u2move=new LinkedList<Integer>();
	int status,cur_u1_move,cur_u2_move;
	int gameboard_id;
	static int gameboard_count=0;
	int matrix[][]=new int[10][12];
	public void init()
	{
		for(int i=0;i<10;i++)
		{
			for(int j=0;j<12;j++)
			{
				if(i==4&&j<2)
				{
					matrix[i][j]=0;
				}
				else if(i==4&&j==2)
				{
					matrix[i][j]=3;
				}
				else if(i==5&&j>9)
				{
					matrix[i][j]=1;
				}
				else if(i==5&&j==9)
				{
					matrix[i][j]=4;
				}
				else
				{
					matrix[i][j]=2;
				}
			}
		}
		
	}
	
	public void nextMove()
	{
		int x1,y1,x2,y2;
		if(u1move.size()>0)
		{
			cur_u1_move=u1move.remove();
		}
		if(u2move.size()>0)
		{
			cur_u2_move=u2move.remove();
		}
		switch(cur_u1_move)
		{
			case 1:
			outer: for(int j=0;j<12;j++)
				{
					for(int i=0;i<10;i++)
					{
						if(matrix[i][j]==0)
						{
							x1=i;
							y1=j;
							matrix[i][j]=2;
							break outer;
						}
					}
				}
				
			ou: for(int j=11;j>=0;j--)
				{
					for(int i=0;i<10;i++)
					{
						if(matrix[i][j]==0)
						{
							x2=i;
							y2=(j+1)%12;
							matrix[x2][y2]=0;
							break ou;
						}
					}
				}
				break;
		}		
	}
	
	
	public String getString()
	{
		nextMove();
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
		//u1move.add(2);
		cur_u1_move=1;
		//u2move.add(4);
		cur_u2_move=4;
		gameboard.gameboard_count++;
	}
}



