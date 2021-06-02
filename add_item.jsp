<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%> 
<%
String desc=request.getParameter("itemid");
String quant=request.getParameter("quantity");
String id=request.getParameter("id");
String amt=request.getParameter("amt");
Connection connection=null; 
try { 
 Class.forName("com.mysql.jdbc.Driver"); 
 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing_application","root", "deepa@2000");
 Statement st=connection.createStatement();
 String query="insert into invoice_item(invoiceno,itemno,quantity,amount) values('"+id+"','"+desc+"','"+quant+"','"+amt+"')";
 st.executeUpdate(query);
 out.println("item added Successfully!!!!");
} catch (ClassNotFoundException e) {
 e.printStackTrace();
} catch (SQLException e) {
 e.printStackTrace();
}
%>