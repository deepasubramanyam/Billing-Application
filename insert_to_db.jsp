<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%> 
<%
String id=request.getParameter("id");
String name=request.getParameter("name");
String dte=request.getParameter("dte");
String netamt=request.getParameter("netamt");
Connection connection=null; 
try { 
 Class.forName("com.mysql.jdbc.Driver"); 
 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing_application","root", "deepa@2000");
 Statement st=connection.createStatement();
 String query="insert into customerdetail(custname,invoiceno) values('"+id+"','"+name+"')";
 st.executeUpdate(query);
 String qury="insert into invoicedetail(invoiceno,invoicedate,netamt)values('"+id+"','"+dte+"','"+netamt+"')";
 st.executeUpdate(qury);
} catch (ClassNotFoundException e) {
 e.printStackTrace();
} catch (SQLException e) {
 e.printStackTrace();
}
%>