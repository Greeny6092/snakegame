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
	
	<script>
		
		var id;
		var gamestartflag=0;
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
							liveusers.style.display=none;
						}
					}
				}
				
            };
		}
	</script>
</body>
</html>
