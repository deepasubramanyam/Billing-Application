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
	if(tot==""||net=="")
	{
		alert("please choose atleast 1 items");
		return false;
	}
	else{
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
		alert("Invoice created successfully");
	}
}
function tot_cal()
{
	var id=document.getElementById("inv").value;	
	var http = new XMLHttpRequest();
	var queryString = "?id= " + id;
    http.open("POST", "http://localhost:8080/invoice/calculate.jsp"+ queryString, true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    http.send();
	http.onreadystatechange = function() {
     if (this.readyState == 4 && this.status == 200) {
      document.getElementById("total").value = this.responseText;
    }
    };
	document.getElementById("total").setAttribute('readonly',true);
	
}
function deleteRow(r)
{
	var i=r.parentNode.parentNode.rowIndex;
	var x = document.getElementById("myTable").rows[i].cells;
	var id=document.getElementById("inv").value; 
    var desc = document.getElementById("desc_sel").value;
	var price = desc.split(" ");
	var http = new XMLHttpRequest();
	var queryString = "?id= " + id;
	queryString+="&itemdesc="+x[0].innerHTML+"&quant="+x[1].innerHTML+"&itemno="+price[0];
    http.open("POST", "http://localhost:8080/invoice/delete_item.jsp"+ queryString, true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    http.send();
	http.onreadystatechange = function() {
     if (this.readyState == 4 && this.status == 200) {
      document.getElementById("demo").innerHTML = this.responseText;
    }
    };
	document.getElementById('myTable').deleteRow(i);
}
function checkradio() {
  var x = document.getElementById("Radio");
  if(x.checked ==true)
  {
	  var randomChars ='123456789';
	  var result = '';
	  for ( var i = 0; i < 6; i++ ) {
        result += randomChars.charAt(Math.floor(Math.random() * randomChars.length));
   }
   document.getElementById("inv").value=result;
  }
}
function calculation()
{
	var a=document.getElementById("inv").value;
	var netamts=document.getElementById("netamt").value;
	var tot=document.getElementById("total").value;
	var dis=document.getElementById("discount").value;
	var t=document.getElementById("tax").value;
	var numVal1 = Number(document.getElementById("total").value);
	var numVal2 = Number(document.getElementById("discount").value) / 100;
	var subtot = numVal1 - (numVal1 * numVal2);
	var total=subtot+(subtot*t);
	var http = new XMLHttpRequest();
    var queryString = "?id = " + a ;
    queryString +=  "&id="+a+"&total= " + tot+ "&discount= " + dis +"&tax= " + t+"&netamt="+total;
    http.open("POST", "http://localhost:8080/invoice/insert_invoice_detail.jsp"+ queryString, true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    http.send();
	http.onreadystatechange = function() {
     if (this.readyState == 4 && this.status == 200) {
      document.getElementById("netamt").value = this.responseText;
    }
    };
	document.getElementById("netamt").setAttribute('readonly',true);
}

function prices()
{
		var desc = document.getElementById("desc_sel").value;
		var price = desc.split(" ");
	    document.getElementById("Price").value = price[2];
		document.getElementById("Price").setAttribute('readonly',true);
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
function inv_detail()
{
	 var id=document.getElementById("inv").value;
	 var cus=document.getElementById("cus").value;
	 var cust_id = cus.match(/[a-zA-Z]+|[0-9]+(?:\.[0-9]+|)/g);
	 var d=new Date();
	 var mon=d.getMonth()+1;
	 var dte=d.getDate();
	 var dt=dte+'/'+mon+'/'+d.getFullYear();
	 var http = new XMLHttpRequest();
	 var queryString = "?id= " + id;
     queryString += "&cust_id="+cust_id[2]+"&dt="+dt;
     http.open("POST", "http://localhost:8080/invoice/insert_invoice_detail.jsp"+ queryString, true);
     http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
     http.send();
	 http.onreadystatechange = function() {
     if (this.readyState == 4 && this.status == 200) {
      document.getElementById("demo").innerHTML = this.responseText;
    }
    };
}
function addvalues()
{
	var id=document.getElementById("inv").value;
	var table = document.getElementById("myTable");
	var desc = document.getElementById("desc_sel").value;
	var price = desc.split(" ");
    var q = document.getElementById("Quantity").value;
    var p = document.getElementById("Price").value;
	if(id==""){
          alert("Please fill invoiceno");
          return false;
    }
	else if (desc==null||desc==""||q==0||q==""||p==""||p==null) {
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
		   cell1.innerHTML = price[1];
		   cell2.innerHTML = q;
		   cell3.innerHTML = p;
		   cell4.innerHTML = q*p;
		   cell5.innerHTML='<input type="button" id="x" value="X" onclick="deleteRow(this)"/>';
           var http = new XMLHttpRequest();
	       var queryString = "?id= " + id;
           queryString +=  "&id= " + id+"&itemid="+price[0]+"&quantity="+q+"&amt="+(p*q);
           http.open("POST", "http://localhost:8080/invoice/add_item.jsp"+ queryString, true);
           http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
           http.send();
	       http.onreadystatechange = function() {
           if (this.readyState == 4 && this.status == 200) {
             document.getElementById("demo").innerHTML = this.responseText;
           }
          };	
    }
} 