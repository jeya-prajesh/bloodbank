<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("uwelcome.jsp");
}
%>

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection
	
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		String dbusername,dbpassword,dbname;
		
		String username,password;
		
		username=request.getParameter("txt_username"); //txt_email
		password=request.getParameter("txt_password"); //txt_password
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("select * from ulogin where username=? AND password=?"); //sql select query 
		pstmt.setString(1,username);
		pstmt.setString(2,password);
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbusername=rs.getString("Username");
			dbpassword=rs.getString("Password");
			dbname=rs.getString("Name");
			
			if(username.equals(dbusername) && password.equals(dbpassword))
			{
				session.setAttribute("login",dbusername); //session name is login and store fetchable database email address
				session.setAttribute("loginname",dbname);
				response.sendRedirect("uwelcome.jsp"); //after login success redirect to welcome.jsp page
			}
		}
		else
		{
			request.setAttribute("errorMsg","invalid username or password"); //invalid error message for email or password wrong
		}
		
		con.close(); //close connection	
	}
	
}
catch(Exception e)
{
	out.println(e);
}
%>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Login : user</title>

<link rel="stylesheet" type="text/css" href="css/vi.css">

 <script>
		
    function validate()
    {
        var username = document.myform.txt_username;
        var password = document.myform.txt_password;
            
        if (username.value == null || username.value == "") //check email textbox not blank
        {
            window.alert("please enter username ?"); //alert message
            username.style.background = '#f08080';
            username.focus();
            return false;
        }
        if (password.value == null || password.value == "") //check password textbox not blank
        {
            window.alert("please enter password ?"); //alert message
            password.style.background = '#f08080'; 
            password.focus();
            return false;
        }
    }
        
</script>


</head>

<body>

<br><br><br>

<div class="form-area">

<h3>Login Form</h3> <form method="post" name="myform" onsubmit="return validate();">

    <p style="color:red">				   		
        <%
        if(request.getAttribute("errorMsg")!=null)
        {
            out.println(request.getAttribute("errorMsg")); //error message for email or password 
        }
        %>
    </p>

<input type="text" name="txt_username"  id="uname" placeholder="Username">


<input type="password" name="txt_password" id="pass"   placeholder ="Password">


<input type="submit" value="LOGIN" name="btn_login">

<a href="uregister.jsp" class="primary-button">No account?<b> Register here </b></a><a href="home.html" class="primary-button"> ...Back to home </a><br><br><br><br><br>

				

</form>

</div>

</body>

</html>