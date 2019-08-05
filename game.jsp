<html>
<head>
<title>game</title>
<style>
	td
	{
		width:8vw;
		height:9vh;
	}
	button
	{
		background-color:rgba(100,50,50,0.8);
	}
</style>
</head>
<body onload="createboard()">
	<div id="liveuserbox">
	</div>
	<div>
		<center>
			<table border="2" name="gameboard">
				<tr name="row">
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</center>
	</div>
	<div id="requestbox">
	<table name="requesttable">
		<tr name="requestrow">
		</tr>
	</table>
	</div>
	<script>
		
		var id;
		var gamestartflag=0;
		var gameboard_id;
		function createboard()
		{
			id=sessionStorage.getItem('id');
			//alert("id is "+id);
			var gameboard=document.getElementsByName("gameboard")[0];
			var row=document.getElementsByName("row")[0];
			for(i=0;i<9;i++)
			{
				let newrow=row.cloneNode(true);
				gameboard.appendChild(newrow);
			}
			get_live_users();
		}
		function get_live_users()
		{
			var liveusers=document.getElementById("liveuserbox");
			var node;
			var source = new EventSource('./LiveUserLister'); 
			 source.onmessage=function(event)
            {
				//alert(event.data);
                //liveusers.innerHTML="<span style='float:right'><button onclick='this.parentNode.display=none'>CLOSE</button></span>";
				liveusers.innerHTML="";
				let ids=event.data.split("$")[0].split(",");
				let names=event.data.split("$")[1].split(",");
				for(i=1;i<ids.length;i++)
				{
					//alert("loop "+ids[i]+" s");
					//ids[i]=ids[i].replace(/(\r\n|\n|\r)/gm,"");
					//ids[i]=ids[i].trim();
					let temp=ids[i];
					////alert(ids[i].replace(/(\r\n|\n|\r)/gm,"")+" "+ids[i].trim());
					////alert(id+" "+ids[i].replace(/(\r\n|\n|\r)/gm," ").trim());
					////alert(id+temp.replace(/(\r\n|\n|\r)/gm," ").trim()+" "+ids[i].includes(id.toString()));
					if(!(ids[i].includes(id)))
					{
						//alert("list");
						node=document.createElement("button");
						node.setAttribute("onclick","challenge("+ids[i]+")");
						node.setAttribute("style","border-radius:2vw;width:18vw;height:5vh;");
						node.innerHTML=names[i];
						liveusers.appendChild(node);
						if(gamestartflag==1)
						{
							liveusers.style.display="none";
						}
					}
				}
				
            };
			get_request_details();
		}
		
		function get_request_details()
		{
			var requestbox=document.getElementsByName("requestbox")[0];
			var requesttable=document.getElementsByName("requesttable")[0];
			var requestrow=document.getElementsByName("requestrow")[0];
			var source = new EventSource('./RequestTeller?id='+id); 
			source.addEventListener("live_users",function(event)
			{
					//alert("got request");
					console.log("you got request!!! "+event.data+" end");
					requesttable.innerHTML="<tr name='requestrow'></tr>";
					let requested=event.data.split("$")[1].split(",");
					let names=event.data.split("$")[0].split(",");
					for(i=0;i<requested.length-1;i++)
					{
						let newrow=requestrow.cloneNode(true);
						newrow.innerHTML="<td>"+names[i]+"</td><td><button style='background-color:green;' onclick='accept("+requested[i]+",1)'>Accept</button></td><td><button style='background-color:red;' onclick='accept("+requested[i]+",0)'>Decline</button></td>";
						requesttable.appendChild(newrow);
					}
					//confirm("You got request from "+);
			})
			
			source.addEventListener("gamestartflag",function(event)
            {
					gamestartflag=event.data.split(",")[0];
					if(gamestartflag==1)
					{
						document.getElementById("requestbox").style.display="none";
						listentogameboard();
					}
					gameboard_id=event.data.split(",")[1];
					console.log("game board id is "+gameboard_id+"gameflag is "+gamestartflag);
            })
		}
		
		function challenge(id2)
		{
			  var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() 
				{
				  if (this.readyState == 4 && this.status == 200) 
				  {
					//id = this.responseText;
					alert("challenge request sent!!!");
				  }
				};
				xhttp.open("GET", "./getid?id1="+id+"&id2="+id2+"&t=1", false);
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhttp.send();
		}
		
		function accept(u2,accept)
		{
				//alert("Entered");
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() 
				{
				  if (this.readyState == 4 && this.status == 200) 
				  {
					//id = this.responseText;
					console.log("accepted!!!");
				  }
				};
				xhttp.open("GET", "./getid?u1="+id+"&u2="+u2+"&t=2&accept="+accept, false);
				xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
				xhttp.send();
		}
		
		function listentogameboard()
		{
			var source = new EventSource('./RequestTeller?id='+id); 
		}
	</script>
</body>
</html>
