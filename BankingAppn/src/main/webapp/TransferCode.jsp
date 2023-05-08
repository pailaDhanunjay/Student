<%@ page import="java.sql.*" %>
<%
long account_no=Long.parseLong(request.getParameter("uacno"));
String name=request.getParameter("uname");
String password=request.getParameter("upwd");
long taccount_no=Long.parseLong(request.getParameter("tarno"));
double amount=Double.parseDouble(request.getParameter("uamt"));
out.print("Amount to be Transfer:" + amount +"<p></P>");
try
{
	String status="inactive";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","dhanunjay","welcome");
	PreparedStatement ps4=con.prepareStatement("select status from accounts where account_no=?");
	ps4.setLong(1,account_no);
	ResultSet rs2=ps4.executeQuery();
	String s=" ";
	 if(rs2.next())
	 {
		  s=rs2.getString("status");
	 }
	 PreparedStatement ps5=con.prepareStatement("select status from accounts where account_no=?");
		ps5.setLong(1,taccount_no);
		ResultSet rs3=ps5.executeQuery();
		String str=" ";
		 if(rs3.next())
		 {
			  str=rs3.getString("status");
		 }
		 if(s.equals(status))
		 {
			 out.print("Your account was not in running condition...");
		 }
		 else if(str.equals(status))
		 {
			 out.print("Target Account is not in running condition...");
		 }
		 else
		 {
PreparedStatement ps=con.prepareStatement("select amount from accounts where account_no=? and name=? and password=?");
ps.setLong(1,account_no);
ps.setString(2,name);
ps.setString(3,password);
ResultSet rs=ps.executeQuery();
double x=0;
 if(rs.next())
 {
	 x=rs.getDouble("amount");
 }
 out.print("Your Account Original Balance:" + x+"<p></p>");
 x=x-amount;
 out.print("Remaining Balance in your Account:" + x+"<p></p>");
 PreparedStatement ps2=con.prepareStatement("update accounts set amount=? where account_no=? and name=? and password=?");
 ps2.setLong(2,account_no);
 ps2.setString(3,name);
 ps2.setString(4,password);
 ps2.setDouble(1,x);
 int j=ps2.executeUpdate();
 out.print("Amount Transfered Successfully..."+"<br>");
 PreparedStatement ps1=con.prepareStatement("select amount from accounts where account_no=?");
 ps1.setLong(1,taccount_no);
 ResultSet rs1=ps1.executeQuery();
 double y=0;
  if(rs1.next()) 
  {
 	 y=rs1.getDouble("amount");
  }
  y=amount+y;
 PreparedStatement ps3=con.prepareStatement("update accounts set amount=? where account_no=?");
 ps3.setLong(2,taccount_no);
 ps3.setDouble(1,y);
 int i=ps3.executeUpdate();
 out.print( "Target Account Holder Recieved Amount Successfully...");
		 }
con.close();
}
catch(Exception ex)
{
	out.print(ex);
}
%>