<%@ page import="java.sql.*" %>
<%
long account_no=Long.parseLong(request.getParameter("uacno"));
String name=request.getParameter("uname");
String password=request.getParameter("upwd");
double amount=Double.parseDouble(request.getParameter("uamt"));
out.print("Amount to be Deposit:" + amount+"<br>");
try
{
	String status="active";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","dhanunjay","welcome");
	PreparedStatement ps=con.prepareStatement("select status from accounts where account_no=?");
	ps.setLong(1,account_no);
	ResultSet rs=ps.executeQuery();
	String s=" ";
	 if(rs.next())
	 {
		  s=rs.getString("status");
	 }
	 if(s.equals(status))
	 {
PreparedStatement ps1=con.prepareStatement("select amount from accounts where account_no=? and name=? and password=?");
ps1.setLong(1,account_no);
ps1.setString(2,name);
ps1.setString(3,password);
ResultSet rs1=ps1.executeQuery();
double x=0;
 if(rs1.next())
 {
	  x=rs1.getDouble("amount");
	  out.print("Your Account current Balance:" + x+"<br>");
 }
 x=amount+x;
 out.print("Your Account Balance after Deposit:" + x+"<br>");
 PreparedStatement ps2=con.prepareStatement("update accounts set amount=? where account_no=? and name=? and password=?");
 ps2.setDouble(1,x);
 ps2.setLong(2,account_no);
 ps2.setString(3,name);
 ps2.setString(4,password);
 int i=ps2.executeUpdate();
 out.print(i + "Deposited Successfully...");
	 }
	 else
	 {
		out.print("Your Account is not in running condition..."); 
	 }
con.close();
}
catch(Exception ex)
{
	out.print(ex);
}
%>