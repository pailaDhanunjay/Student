<%@ page import="java.sql.*"%>
<%
long account_no=Long.parseLong(request.getParameter("uacno"));
String name=request.getParameter("uname");
String password=request.getParameter("upwd");
try
{
	String status="active";
	String cstatus="inactive";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","dhanunjay","welcome");
PreparedStatement ps=con.prepareStatement("select status from accounts where account_no=? and name=? and password=?");
ps.setLong(1,account_no);
ps.setString(2,name);
ps.setString(3,password);
ResultSet rs=ps.executeQuery();
String s=" ";
 if(rs.next())
 {
	  s=rs.getString("status");
 }
 if(s.equals(status))
 {
	 PreparedStatement ps1=con.prepareStatement("update accounts set status=? where account_no=?");
	 ps1.setLong(2,account_no);
	 ps1.setString(1,cstatus);
 int i=ps1.executeUpdate();
 out.print(i+"Your Account Deactivated...");
 }
 else
 {
	 out.print("Your Account Already Deactivated...");
 }
 con.close();
}
catch(Exception ex)
{
	out.print(ex);
}
%>