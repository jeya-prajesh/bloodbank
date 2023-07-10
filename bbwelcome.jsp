<%@ page import="java.sql.*" %> 

<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Welcome : <%=session.getAttribute("login")%></title>

	<link rel="stylesheet" href="css/bbwelcome.css">
	

</head>

<body>

    <div class="main-content">
	
	<center>
	
	<%
	if(session.getAttribute("login")==null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
	{
		response.sendRedirect("bblogin.jsp"); 
	}
	%>
	
	<h1 style="color:white"> Welcome, <%=session.getAttribute("login")%> </h1>

	<h2><a href="bblogout.jsp">Logout</a></h2>
    
	<br><br><br>

	<h2><a>Current Stock Availability</a></h2>
	
	<table border=1 width=50% height=50%>
	<thead>
		<tr><th>Hospital Id</th><th>Username</th><th>A+</th><th>B+</th><th>O+</th><th>AB+</th><th>A-</th><th>B-</th><th>O-</th><th>AB-</th></tr>
	</thead>
	<%
	String username=(String)session.getAttribute("login");
	try{
		Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection

	PreparedStatement pstmt=null; //create statement

	pstmt=con.prepareStatement("select * from availability where Username=?");
	
	pstmt.setString(1,username);
	
	ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.

		
	%>
	<tbody>
	<tr>
	<%
	while(rs.next())
	{
		out.print("<td>" + rs.getString(1) + "</td>");
		out.print("<td>" + rs.getString(2) + "</td>");
		out.print("<td>" + rs.getInt(3) + "</td>");
		out.print("<td>" + rs.getInt(4) + "</td>");
		out.print("<td>" + rs.getInt(5) + "</td>");
		out.print("<td>" + rs.getInt(6) + "</td>");
		out.print("<td>" + rs.getInt(7) + "</td>");
		out.print("<td>" + rs.getInt(8) + "</td>");
		out.print("<td>" + rs.getInt(9) + "</td>");
		out.print("<td>" + rs.getInt(10) + "</td>");
	}
	%>
	</tr></tbody>
	<%	
		con.close(); //close connection
		} catch (Exception e) {
		e.printStackTrace();
		}
	%>
	</table>
	<h2><a href="update.jsp">Update Records</a></h2>
	<br><br><br>

	<h2><a>Recent Orders</a></h2>

	<table border=1 width=50% height=50%>
		<tr><th>Date</th><th>Name</th><th>Ordered Blood Grp</th><th>Units</th><th>Email</th><th>Phone</th></tr>
		<%
		String dbname,dbdate,dbbgrp,dbemail,dbphone,dbbbname,dbid;
		dbbbname=(String)session.getAttribute("loginbbname");
		dbid=(String)session.getAttribute("loginid");
		int dbunits;
		try{
			Class.forName("com.mysql.jdbc.Driver"); //load driver
		
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection
	
			PreparedStatement pstmt=null; //create statement
		
	
			pstmt=con.prepareStatement("select * from orders,ulogin where Id=?");
		
			pstmt.setString(1,dbid);
			
			ResultSet rst=pstmt.executeQuery(); //execute query and store in resultset object rs.	
		
		
		while(rst.next())
		{
				dbdate=rst.getString("Dt");
				dbname=rst.getString("Name");
                dbbgrp=rst.getString("orders.Bgrp");
                dbunits=rst.getInt("Units");
                dbemail=rst.getString("Email");
                dbphone=rst.getString("Phone");
               
            out.println("<tr><td>" + dbdate + "</td><td>" + dbname + "</td><td>" + dbbgrp + "</td><td>" + dbunits + "</td><td>" + dbemail + "</td><td>" + dbphone + "</td></tr>");

		}
	
		%>
	
		<%	
		con.close(); //close connection
	}	 
			catch (Exception e) 
			{
			e.printStackTrace();
			}
		%>
		</table>

	</center>
		
    </div>
	<center>
		
</center>

</body>

</html>
