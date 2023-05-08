<%@ page import="java.sql.*" %>
<% 
      long accountno=Long.parseLong(request.getParameter("uacno"));
      String name=request.getParameter("uname");
      out.print("Welcome" + name);
      String password=request.getParameter("upwd");
		try
		{
			String status="active";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","dhanunjay","welcome");
		PreparedStatement ps=con.prepareStatement("select status from accounts where account_no=?");
		ps.setLong(1,accountno);
		ResultSet rs=ps.executeQuery();
		String s=" ";
		 if(rs.next())
		 {
			  s=rs.getString("status");
		 }
		 if(s.equals(status))
		 {
	    PreparedStatement ps1=con.prepareStatement("select * from accounts where account_no=?"); 
	    ps1.setLong(1,accountno);
	    ResultSet rs1=ps1.executeQuery();
		ResultSetMetaData rss=rs1.getMetaData();
		out.print("<html><body><table border='1'>");
		int n=rss.getColumnCount();
		for(int i=1;i<=n;i++)
			out.println("<td font color=blue size=3>" + "<br>" + rss.getColumnName(i));
		out.print("<tr>");
		while(rs1.next())
		{
			for(int i=1;i<=n;i++)
				out.println("<td><br>" + rs1.getString(i));
			out.println("<tr>");
		}
		out.println("</table></body></html>");
		 }
		 else
		 {
			 out.print("Your Account was Deactivated..."+"<br>"+ "please keep it in running condition...");
		 }
		con.close();
		}
		catch(Exception ex)
		{
			out.print(ex);
		}
		%>