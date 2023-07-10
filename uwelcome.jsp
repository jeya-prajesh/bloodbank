<%@ page import="java.sql.*" %> 

<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Welcome : <%=session.getAttribute("login")%></title>

	<link rel="stylesheet" href="css/uwelcome.css">
	

</head>

<body>

    <div class="main-content">
	
	<center>
	
	<%
	if(session.getAttribute("login")==null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
	{
		response.sendRedirect("ulogin.jsp"); 
	}
	%>
	
	<h1 style="color:white"> Welcome, <%=session.getAttribute("loginname")%> </h1>

	<h2><a href="ulogout.jsp">Logout</a></h2>
    
    <form>
        <input type="submit" value="VIEW ORDER HISTORY" name="btn_orders">
        
    </form> 
       

	<%
	String username=(String)session.getAttribute("login");
	try{

        Class.forName("com.mysql.jdbc.Driver"); //load driver
        
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection
        
        if(request.getParameter("btn_orders")!=null) //check order History button click event not null
        {
            session.setAttribute("show","showw");
            %>
            <p>Order History</p>
            <table border=1 width=50% height=50%>
                <tr><th>Date</th><th>Hospital Id</th><th>Hospital Name</th><th>City</th><th>Blood group</th><th>Number of units</th></tr>
            
            <%
                String dbcity,dbtype,dbid,dbbbname,dbaddress,dbemail,dbphone,dbbgrp;

            int dbunits;
            
            String dbdate;

            PreparedStatement pstmt=null; //create statement
            
            pstmt=con.prepareStatement("select * from orders where Username=?"); //sql select query 
            pstmt.setString(1,username);
            
            ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
            
            //out.println("<table>");  
            //out.println("<tr><th>Date</th><th>Blood Bank Name</th><th>Address</th><th>Email</th><th>Phone</th><th>Availability</th></tr>");
            
            while(rs.next())
            {
                dbcity=rs.getString("City");
                //dbtype=rs.getString("Type");
                dbid=rs.getString("Id");
                dbbbname=rs.getString("BBName");
                //dbaddress=rs.getString("Address");
                //dbemail=rs.getString("Email");
                //dbphone=rs.getString("Phone");
                dbbgrp=rs.getString("Bgrp");       //request.getParameter("txt_bgrp")
                dbunits=rs.getInt("Units");
                dbdate=rs.getString("Dt");
                
                    
                out.println("<tr><td>" + dbdate + "</td><td>" + dbid + "</td><td>" + dbbbname + "</td><td>" + dbcity + "</td><td>" + dbbgrp + "</td><td>" + dbunits + "</td></tr>");
                    
                    
                    
                //request.setAttribute("orders",bgrp); //session name is login and store fetchable database email address
                
            }
            //out.println("</table>");
            
            
            con.close(); //close connection	
        }
        
    }
    catch(Exception e)
    {
        out.println(e);
    }
    %>
</table>
		
	

	</center>
		
    </div>
	<center>
		
        <form>
            <h2><a href="willingness.jsp">Update Willingness</a></h2><br>
        	<h2><a href="css/order.jsp">Order blood</a></h2>
        </form>
</center>

</body>

</html>