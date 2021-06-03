<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%> 
<%@page import="java.sql.ResultSet"%>
<%
String id=request.getParameter("id");
String desc=request.getParameter("itemdesc");
String quant=request.getParameter("quant");
String itemno=request.getParameter("itemno");
Connection connection=null;
ResultSet resultSet = null; 
try { 
 Class.forName("com.mysql.jdbc.Driver"); 
 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing_application","root", "deepa@2000");
 Statement st=connection.createStatement();
 String qury="delete from invoice_item where invoiceno='"+id+"' and quantity='"+quant+"' and itemno='"+itemno+"'";
 st.executeUpdate(qury);
 out.println(itemdesc+"Deleted Successfully");
} catch (ClassNotFoundException e) {
 e.printStackTrace();
} catch (SQLException e) {
 e.printStackTrace();
}
%>