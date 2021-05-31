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
<link rel="stylesheet" href="bill.css">
<style>
table {
  border-collapse: collapse;
  width: 100%;
}

tr, td {
  padding: 8px;
  text-align:center;
}
</style>
</head>
<body>
<div id="heading">
<center><h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Invoice for&nbsp;&nbsp;<span id="cust"><input type="text" name="Custname" id="custsname" required/></h3>
<hr>
<div class="inv">Bill No:<span id="in"><input type="text" name="Inv" id="newinv" onblur="myinv()"required/></span><br/><br/></div><br><br>
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
<div class="head">SubTotal:<span id="val"><input type="text" name="Total" id="total" size="4" onclick="totcal()"></span><br/><br/></div><br><br>
<div class="head_dis">Discount:<span id="dis"><input type="text" name="Discount" id="discount" size="4" onblur="dis()"></span>&nbsp;&nbsp;&nbsp;
Tax:<span id="t"><input type="text" name="Tax" id="tax" size="4"></span><br/><br/></div><hr><h3>
Net.Amt:<span id="net"><input type="text" name="NetAmt" id="netamt" size="4" onclick="calculation()"></span></h3><br/>
<%= (new java.util.Date()).toLocaleString()%>
<br/><br/><button class="button" id="generate" onclick="generate()">Generate Bill</button>
<button class="button" onclick="print()">print</button>
<button class="button" onclick="location.reload()">Cancel</button></center></div>

<form id="form" name="myform">
<h2>BILL COUNTER</h2>
<label>Invoice No:</label><input type="text" id="inv">
<input type="radio" id="Radio" name="InVoiceNo" onblur="checkradio()">Autogenerate</br></br>
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
String sql ="select ItemDesc,ItemPrice from Item ";
rs1 = statement.executeQuery(sql);
%>
<label>Customer Name:</label>
<select id="title">
  <option value="Mr."> Mr.</option>
  <option value="Mrs."> Mrs.</option>
  <option value="Miss."> Miss.</option>
  <option value="Ms."> Ms.</option>
  <option value="Dr."> Dr.</option>
</select>
<input type="text" name="custname" onfocus="this.value=''" id="cus" onblur="blur_cust()" ><br/><br/> 
<label>ItemDesc:</label> 
<select id="desc_sel">
   <%  while(rs1.next()){ %>
   <option><%= rs1.getString("ItemDesc")%>  <%= rs1.getString("ItemPrice")%></option>
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


