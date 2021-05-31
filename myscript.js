function generate(){
	var table = document.getElementById("myTable");
	for(var i = 1; i < table.rows.length; i++)
	{
		var firstRow = document.getElementById("myTable").rows[i];
		firstRow.deleteCell(4);
	}
	var a=document.getElementById("inv").value;
	var netamts=document.getElementById("netamt").value;
	var tot=document.getElementById("total").value;
	var dis=document.getElementById("discount").value;
	var t=document.getElementById("tax").value;
	var customername=document.getElementById("custsname").value;
	var d=new Date();
	var mon=d.getMonth()+1;
	var dte=d.getDate();
	var dt=dte+'/'+mon+'/'+d.getFullYear();
	var http = new XMLHttpRequest();
    var queryString = "?id = " + a ;
    queryString +=  "&name= " + customername+ "&id= " + a +"&netamt= " + netamts+"&dte="+dt;
    http.open("POST", "http://localhost:8080/billing_application/insert_to_db.jsp"+ queryString, true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    http.send();
	document.getElementById("net").innerHTML =netamts;
    console.log(netamts);
	document.getElementById("in").innerHTML = a;
    console.log(a);
	document.getElementById("val").innerHTML =tot;
    console.log(tot);
	document.getElementById("dis").innerHTML =dis;
    console.log(dis);
	document.getElementById("t").innerHTML =t;
    console.log(t);
	document.getElementById("cust").innerHTML =customername;
    console.log(customername);
	document.getElementById("generate").style.visibility = "hidden";
}
function totcal()
{
	var table = document.getElementById("myTable"), sumVal = 0;
	for(var i = 1; i < table.rows.length; i++)
	{
		sumVal = sumVal + parseInt(table.rows[i].cells[3].innerHTML);
    }
	document.getElementById("total").value= sumVal;
}
function myinv()
{
	var a=document.getElementById("inv").value;
	document.getElementById("newinv").value = a;
}
function deleteRow(r)
{
	var i=r.parentNode.parentNode.rowIndex;
	document.getElementById('myTable').deleteRow(i);
}
function blur_cust()
{
	var name=document.getElementById("cus").value;
	var tit=document.getElementById("title").value
	document.getElementById("custsname").value=tit+name;
}
function checkradio() {
  var x = document.getElementById("Radio");
  if(x.checked ==true)
  {
	  var randomChars ='0123456789';
	  var result = '';
	  for ( var i = 0; i < 6; i++ ) {
        result += randomChars.charAt(Math.floor(Math.random() * randomChars.length));
   }
   document.getElementById("inv").value='INV-'+result;
   document.getElementById("newinv").value='INV'+result;
  }
}
function calculation()
{
	var numVal1 = Number(document.getElementById("total").value);
	var numVal2 = Number(document.getElementById("discount").value) / 100;
	var t=document.getElementById("tax").value;
	var subtot = numVal1 - (numVal1 * numVal2);
	var tot=subtot+(subtot*t);
	document.getElementById("netamt").value =tot.toFixed(2);
}

function prices()
{
		var desc = document.getElementById("desc_sel").value;
		var price = desc.split(" ");
	    document.getElementById("Price").value = price[1];
}
function dis()
{
	var d=document.getElementById("discount").value;
}
function print() {
            var divContents = document.getElementById("heading").innerHTML;
            var a = window.open('', '', 'height=750, width=750');
			a.document.write('<html>');
            a.document.write('<body>');
			a.document.write(divContents);
			a.document.write('</body></html>');
            a.document.close();
            a.print();
}
function addvalues()
{
	var n=document.getElementById("inv").value;
	var Cus=document.getElementById("cus").value;
	var table = document.getElementById("myTable");
	var desc = document.getElementById("desc_sel").value;
	var price = desc.split(" ");
    var q = document.getElementById("Quantity").value;
    var p = document.getElementById("Price").value;
	if (n==null || n==""||Cus==null||desc==null||desc==""||q==null||q==""||p==""||p==null) {
          alert("Please fill all fields");
          return false;
    }
	else{
		   var row = table.insertRow(-1);
		   var cell1 = row.insertCell(0);
		   var cell2 = row.insertCell(1);
		   var cell3 = row.insertCell(2);
		   var cell4 = row.insertCell(3);
		   var cell5 = row.insertCell(4);
		   cell1.innerHTML = price[0];
		   cell2.innerHTML = q;
		   cell3.innerHTML = p;
		   cell4.innerHTML = q*p;
		   cell5.innerHTML='<input type="button" id="x" value="X" onclick="deleteRow(this)"/>';
        } 
} 