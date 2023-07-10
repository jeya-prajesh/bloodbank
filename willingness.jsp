<%@ page import="java.sql.*" %>  

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection
	
	if(request.getParameter("btw_update")!=null) //check register button click event not null
	{
		int apos,bpos,opos,abpos,aneg,bneg,oneg,abneg;
		
		String username=(String)session.getAttribute("login"); 
		String willingness=request.getParameter("txt_will"); //txt_will
        int zero=0; //zero
		
		PreparedStatement pstmt=null; //create statement		
		
        
        pstmt=con.prepareStatement("update willingness set Willingness=? where Username=?"); //sql insert query
		pstmt.setString(1,willingness);
        pstmt.setString(2,username);
		
		pstmt.executeUpdate(); //execute query
		
        request.setAttribute("successMsg","Updated Successfully...! Please go back"); //update success messeage

		con.close(); //close connection

	}
}
catch(Exception e)
{
	out.println(e);
}
%>  

<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
		
	<title>Register : onlyxscript.blogspot.com</title>

	<link rel="stylesheet" href="css/willingness.css">

</head>

<body>

    <ul>
    </ul>

    <div class="main-content">

        <form class="form-register" method="post" onsubmit="">

            <div class="form-register-with-email">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Update</h1>
                    </div>
				   
					<p style="color:green">				   		
					<%
					if(request.getAttribute("successMsg")!=null)
					{
						out.println(request.getAttribute("successMsg")); //register success message
					}
					%>
					</p>
				   
				   </br>
				   
                
                <div class="form-row">
                    <label>
                        <span><p style="color: rgb(87, 80, 80); font-size: 20px;">Willingness</p></span>
                        <select name="txt_will">
                            <option value="YES">Yes</option>
                            <option value="NO">No</option>
                        </select>
                    </label>
                </div>
                
                    <input type="submit" name="btw_update" value="Update">
					
                </div>
				
                <a href="uwelcome.jsp" class="form-log-in-with-existing">Back</a>

            </div>

        </form>

    </div>

</body>

</html>