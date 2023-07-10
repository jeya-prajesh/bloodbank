<% 
session.invalidate(); //destroy session
response.sendRedirect("ulogin.jsp");
%>