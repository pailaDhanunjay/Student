<%@ page import="java.sql.*"%>
<%
        long account_no=Long.parseLong(request.getParameter("uacno"));
        String name=request.getParameter("uname");
		String password=request.getParameter("upwd");
		double amount=Double.parseDouble(request.getParameter("uamt"));
		String address=request.getParameter("uadd");
		long mobile_no=Long.parseLong(request.getParameter("umno"));
		String status="active";
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","dhanunjay","welcome");
			PreparedStatement ps=con.prepareStatement("insert into accounts values(?,?,?,?,?,?,?)");
			ps.setLong(1,account_no);
			ps.setString(2,name);
			ps.setString(3,password);
			ps.setDouble(4,amount);
			ps.setString(5,address);
			ps.setLong(6,mobile_no);
			ps.setString(7,status);
			
		 int i=ps.executeUpdate();
		 out.println("Your New Account Creation was Successfully...");
		 con.close();
		}
		catch (Exception ex)
		{
			out.print(ex);
		}
		%>