<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.sql.*, java.util.*, p.*, java.lang.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Beneficiary</title>
<script type="text/javascript">

function validateName() {
    var form = document.forms["bene"];
    var x = form["acno"].value.trim();
    var y = form["limit"].value.trim();
    form["chk"].value = "false";

    if (x === "" || y === "") {
        alert("ALL Fields Should Be filled");
        return false;
    }
    if (isNaN(x) || isNaN(y)) {
        alert("Please enter valid numeric values");
        return false;
    }
    if (parseFloat(y) <= 0) {
        alert("Limits Should be greater than 0");
        return false;
    }

    form["chk"].value = "true";
    return true;
}

</script>
</head>
<body>
<jsp:include page="include.jsp" flush="true"/>
<img src="beneficiary.jpg" width="300" height="150" border="0" alt="Beneficiary Image"/>
<span style="background-color: #FFCCCC">
  <em><h3><font face="Times New Roman" size="+2" color="#000033">BENEFICIARY</font></h3></em>
</span>

<table width="100%" border="0" cellpadding="0" cellspacing="0" id="logo">
    <tr>
        <td width="100" align="left" valign="top"><a href="beneficiery.jsp"><img src="add.jpg" alt="ADD" width="70" height="55" border="0" /></a></td>
        <td width="100" align="left" valign="top"><a href="benemodify2.jsp"><img src="modify.jpg" alt="MODIFY" width="70" height="55" border="0" /></a></td>
        <td width="180" align="left" valign="top"><a href="removebene.jsp"><img src="remove.jpg" alt="REMOVE" width="70" height="55" border="0" /></a></td>
        <td align="left" valign="top"><img src="line1.jpg" width="1" height="55" alt="separator"/></td>
    </tr>
</table>

<form method="post" action="" name="bene" onsubmit="return validateName()">
    <input type="hidden" name="chk" value="false" />
    A/C No: <input type="text" name="acno" id="a" /><br>
    SET THE LIMITS: <input type="text" name="limit" id="s" /><br>
    <input type="submit" value="ADD" />
</form>

<%
ArrayList person = (ArrayList) session.getAttribute("ATT");
PersonInfo per = null;
if (person != null && !person.isEmpty()) {
    per = (PersonInfo) person.get(0);
}
Integer a = (per != null) ? per.getcac() : null;

String tacc = request.getParameter("acno");
String lim = request.getParameter("limit");
String chk = request.getParameter("chk");

if (tacc != null && lim != null && !lim.trim().isEmpty() && !tacc.trim().isEmpty() && chk != null) {
    if (a != null && tacc.trim().equals(String.valueOf(a))) {
%>
        <script type="text/javascript">alert("OWNER OF ACCOUNT NO IS SAME");</script>
<%
    } else if ("true".equals(chk)) {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            con = DriverManager.getConnection("jdbc:odbc:abc", "root", "root");
            String sql = "SELECT * FROM accd WHERE cac = " + Integer.parseInt(tacc);
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                sql = "INSERT INTO bene VALUES (" + a + "," + Integer.parseInt(tacc) + "," + Float.parseFloat(lim) + ")";
                stmt.executeUpdate(sql);
            } else {
%>
                <script type="text/javascript">alert("ACCOUNT NO IS NOT EXIST");</script>
<%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
%>
</body>
</html>
