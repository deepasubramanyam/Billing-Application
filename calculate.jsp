<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%> 
<%@page import="java.sql.ResultSet"%>
<%
String id=request.getParameter("id");
Connection connection=null;
ResultSet resultSet = null; 
try { 
 Class.forName("com.mysql.jdbc.Driver"); 
 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing_application","root", "deepa@2000");
 Statement st=connection.createStatement();
 String query="select sum(amount) from invoice_item where invoiceno='"+id+"'";
 resultSet=st.executeQuery(query);
 while(resultSet.next()){
	out.println(resultSet.getString(1));
 }
} catch (ClassNotFoundException e) {
 e.printStackTrace();
} catch (SQLException e) {
 e.printStackTrace();
}
%>