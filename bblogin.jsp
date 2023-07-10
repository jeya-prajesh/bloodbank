<%@ page import="java.sql.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("bbwelcome.jsp");
}
%>

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection
	
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		String dbusername,dbpassword,dbbbname,dbid;
		
		String username,password;
		
		username=request.getParameter("txt_username"); //txt_email
		password=request.getParameter("txt_password"); //txt_password
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("select * from bblogin where username=? AND password=?"); //sql select query 
		pstmt.setString(1,username);
		pstmt.setString(2,password);
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbusername=rs.getString("Username");
			dbpassword=rs.getString("Password");
			dbid=rs.getString("Id");
			dbbbname=rs.getString("BBName");
			
			if(username.equals(dbusername) && password.equals(dbpassword))
			{
				session.setAttribute("login",dbusername); //session name is login and store fetchable database email address
				session.setAttribute("loginbbname",dbbbname);
				session.setAttribute("loginid",dbid);
				response.sendRedirect("bbwelcome.jsp"); //after login success redirect to welcome.jsp page
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

<!DOCTYPE html>
<html>

<head>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Login : Blood Banks</title>

	<link rel="stylesheet" href="css/bblogin.css">
	
	
	<script>
		
		function validate()
		{
			var username = document.myform.txt_username;
			var password = document.myform.txt_password;
				
			if (username.value == null || username.value == "") //check email textbox not blank
			{
				window.alert("please enter email ?"); //alert message
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
    <div class="main-content">

        <form class="form-register" method="post" name="myform" onsubmit="return validate();">

            <div class="form-register-with-email">

                <div class="form-white-background">

                    <div class="form-title-row">
                        <h1>Login</h1>
                    </div>
					
					<p style="color:red">				   		
					<%
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for email or password 
					}
					%>
					</p>
				   
				   </br>

				   <div class="form-row">
						<label>
							<span>Username</span>
							<input type="text" name="txt_username" id="email" placeholder="enter username">
						</label>
					</div>

                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="email" placeholder="enter password">
                        </label>
                    </div>

					<input type="submit" name="btn_login" value="Login">
                    
                </div>

				<a href="bbregister.jsp" class="form-log-in-with-existing">You Don't have an account? <b> Register here </b></a><br><br><br><br><br>

				<a href="home.html" class="form-log-in-with-existing"> Back to home </a>

            </div>

        </form>

    </div>

</body>

</html>
