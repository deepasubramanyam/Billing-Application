<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="invoice.css">
<style>
table {
  border-collapse: collapse;
  width: 50%;
}

tr, td {
  padding: 8px;
  text-align:center;
}
</style>
</head>
<body>
<div class="sidenav">
  <a href="http://localhost:8080/invoice/customer_details.html">Add Customer</a>
  <a href="http://localhost:8080/invoice/create_invoice.jsp">New Invoice</a>
</div>
<center><p id="demo"></p></center>
<div id="heading">
<center><h3>Invoice Receipt</h3>
<hr>
<% 
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "billing_application";
String userid = "root";
String password = "deepa@2000";
try {
	Class.forName(driver);
} 
catch (ClassNotFoundException e) {
	e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
PreparedStatement pstatement = null;
%>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
ResultSet rs1 = null; 
ResultSet rs2 = null;
String sql ="select cust_name,cust_id from customer_detail";
rs1 = statement.executeQuery(sql);
%>
<label>Customer Detail:</label>
<select id="cus">
   <%  while(rs1.next()){ %>
   <option><%= rs1.getString(1)%> <%= rs1.getString(2)%></option>
   <%}%>
</select><br><br>
<label>Invoice No:</label><input type="text" id="inv" onclick="inv_detail()">
<span id="in"><input type="radio" id="Radio" name="InVoiceNo" onblur="checkradio()">Autogenerate</br></br></span>
<hr>
<table id="myTable">
<tbody>
  <tr>
    <td>ItemDesc</td>
	<td>Quantity</td>
    <td width="30px">Price</td>
	<td width="30px">Amount</td>
  </tr>
</tbody>
</table>
<br>
<hr>
<div class="head">SubTotal:<span id="val"><input type="text" name="Total" id="total" size="4" onclick="tot_cal()"></span><br/><br/></div><br><br>
<div class="head_dis">Discount:<span id="dis"><input type="text" name="Discount" id="discount" size="4" onblur="dis()"></span>&nbsp;&nbsp;&nbsp;
Tax:<span id="t"><input type="text" name="Tax" id="tax" size="4"></span><br/><br/></div><hr><h3>
Net.Amt:<span id="net"><input type="text" name="NetAmt" id="netamt" size="4" onclick="calculation()"></span></h3><br/>
<%= (new java.util.Date()).toLocaleString()%>
<br/><br/><button class="button" id="generate" onclick="generate()">Generate Bill</button>
<button class="button" onclick="print()">print</button></div>

<form id="form" name="myform">
<h3>NEW INVOICE</h3>
<%
String sq ="select Itemno,ItemDesc,ItemPrice from Itemdetail ";
rs2 = statement.executeQuery(sq);%>
<label>ItemDetail:</label> 
<select id="desc_sel">
   <%  while(rs2.next()){ %>
   <option><%= rs2.getString("Itemno")%>  <%= rs2.getString("ItemDesc")%>  <%= rs2.getString("ItemPrice")%></option>
   <%}%>
</select>
</br></br>
<label>Quantity:</label> 
<input type="number" name="Quantity" onfocus="this.value=''" id="Quantity"><br/><br/> 
<label>Price:</label>
<input type="number" name="Price" onfocus="this.value=''" id="Price" onclick="prices()"><br/><br/> 
<input class="button" type="reset" value="Reset">
<input type="button" class="button" value="Add" onclick="return addvalues()"></form>
<%
        }
        catch(Exception e)
        {
             out.println("Error"+e);
        }
%>
<script src="myscript.js">
</script>
</body>

</html>


