<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%> 
<html>
<head>
<style>
.sidenav {
  height: 100%;
  width: 200px;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  padding-top: 20px;
}

.sidenav a {
  padding: 6px 6px 6px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
}

.sidenav a:hover {
  color: #f1f1f1;
}


@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
</head>
<body>
<div class="sidenav">
  <a href="http://localhost:8080/invoice/customer_details.html">Add Customer</a>
  <a href="http://localhost:8080/invoice/create_invoice.jsp">New Invoice</a>
</div>
<%
String id=request.getParameter("Id");
String name=request.getParameter("Name");
String email=request.getParameter("Email");
String phone=request.getParameter("Phn");
String address=request.getParameter("Address");
String title=request.getParameter("title");
String cust=title+name;
Connection connection=null; 
try { 
 Class.forName("com.mysql.jdbc.Driver"); 
 connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/billing_application","root", "deepa@2000");
 Statement st=connection.createStatement();
 String query="insert into customer_detail(cust_id,cust_name,cust_email,cust_phn,cust_address) values('"+id+"','"+cust+"','"+email+"','"+phone+"','"+address+"')";
 st.executeUpdate(query);
 out.println("Added Successfully!!!!");
} catch (ClassNotFoundException e) {
 e.printStackTrace();
} catch (SQLException e) {
 e.printStackTrace();
}
%>
<script>alert("added successfully");</script>
</body>
</html>