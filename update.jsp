<%@ page import="java.sql.*" %>  

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/bloodbank","root","123456"); //create connection
	
	if(request.getParameter("btn_update")!=null) //check register button click event not null
	{
		int apos,bpos,opos,abpos,aneg,bneg,oneg,abneg;
		
		String username=(String)session.getAttribute("login"); 
		apos=Integer.parseInt(request.getParameter("txt_apos")); //txt_apos
        bpos=Integer.parseInt(request.getParameter("txt_bpos")); //txt_bpos
		opos=Integer.parseInt(request.getParameter("txt_opos")); //txt_opos
        abpos=Integer.parseInt(request.getParameter("txt_abpos")); //txt_abpos
        aneg=Integer.parseInt(request.getParameter("txt_aneg")); //txt_aneg
        bneg=Integer.parseInt(request.getParameter("txt_bneg")); //txt_bneg
		oneg=Integer.parseInt(request.getParameter("txt_oneg")); //txt_oneg
        abneg=Integer.parseInt(request.getParameter("txt_abneg")); //txt_abneg
        int zero=0; //zero
		
		PreparedStatement pstmt=null; //create statement
		
		
        
        pstmt=con.prepareStatement("update availability set Apos=?, Bpos=?, Opos=?, ABpos=?, Aneg=?, Bneg=?, Oneg=?, ABneg=? where Username=?"); //sql insert query
		pstmt.setInt(1,apos);
		pstmt.setInt(2,bpos);
		pstmt.setInt(3,opos);
		pstmt.setInt(4,abpos);
        pstmt.setInt(5,aneg);
        pstmt.setInt(6,bneg);
        pstmt.setInt(7,oneg);
        pstmt.setInt(8,abneg);
        pstmt.setString(9,username);
		
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

	<link rel="stylesheet" href="css/update.css">

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
                        <span>A+</span>
                        <input type="" name="txt_apos" id="apos" placeholder="A+">
                    </label>
                </div>
                
                <div class="form-row">
                    <label>
                        <span>B+</span>
                        <input type="number" name="txt_bpos" id="bpos" placeholder="B+">
                    </label>
                </div>

                <div class="form-row">
                    <label>
                        <span>O+</span>
                        <input type="number" name="txt_opos" id="opos" placeholder="O+">
                    </label>
                </div>
                
                <div class="form-row">
                    <label>
                        <span>AB+</span>
                        <input type="number" name="txt_abpos" id="abpos" placeholder="AB+">
                    </label>
                </div>	

                <div class="form-row">
                    <label>
                        <span>A-</span>
                        <input type="number" name="txt_aneg" id="aneg" placeholder="A-">
                    </label>
                </div>
                
                <div class="form-row">
                    <label>
                        <span>B-</span>
                        <input type="number" name="txt_bneg" id="bneg" placeholder="B-">
                    </label>
                </div>

                <div class="form-row">
                    <label>
                        <span>O-</span>
                        <input type="number" name="txt_oneg" id="oneg" placeholder="O-">
                    </label>
                </div>

				<div class="form-row">
                    <label>
                        <span>AB-</span>
                        <input type="number" name="txt_abneg" id="abneg" placeholder="AB-">
                    </label>
                </div>	
                
                    <input type="submit" name="btn_update" value="Update">
					
                </div>
				
                <a href="bbwelcome.jsp" class="form-log-in-with-existing">Back</a>

            </div>

        </form>

    </div>

</body>

</html>