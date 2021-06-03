<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%> 
<%@ page import = "java.lang.*"%>
<%@ page import = "java.util.*"%>
<%
String dt=request.getParameter("dt");
String cust_id=request.getParameter("cust_id");
String id=request.getParameter("id");
String total=request.getParameter("total");
String discount=request.getParameter("discount");
String tax=request.getParameter("tax");
String netamt=request.getParameter("netamt");
Connection connection=null;
try { 
 Class.forName("com.mysql.jdbc.Driver"); 
 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing_application","root", "deepa@2000");
 Statement st=connection.createStatement();
 if(cust_id!=null){
	String query="insert into invoice_detail(invoiceno,cust_id,invoicedate) values('"+id+"','"+cust_id+"','"+dt+"')";
	st.executeUpdate(query);
 }
 else
 {
	String query="insert into amountdetail(invoiceno,total,tax,discount,netamt) values('"+id+"','"+total+"','"+tax+"','"+discount+"','"+netamt+"')";
	st.executeUpdate(query);
	out.println(netamt);
 }
} catch (ClassNotFoundException e) {
 e.printStackTrace();
} catch (SQLException e) {
 e.printStackTrace();
}
%>
