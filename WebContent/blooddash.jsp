<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1"%><html><head>	<meta charset="utf-8">	<title>Donor Patient Dashboard</title>	<link media="all" rel="stylesheet" type="text/css" href="css/all.css" />	<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>	<script type="text/javascript">window.jQuery || document.write('<script type="text/javascript" src="js/jquery-1.7.2.min.js"><\/script>');</script>	<script type="text/javascript" src="js/jquery.main.js"></script>	<!--[if lt IE 9]><link rel="stylesheet" type="text/css" href="css/ie.css" /><![endif]-->	<script type="text/javascript">function noBack() {window.history.forward();        }        </script><style>table, th, td {    border: 1px solid black;}</style></head><body onload="noBack(),calendar()">	<div id="wrapper">		<div id="content">			<div class="c1">				<div class="controls">					<div class="profile-box">						<span class="profile">							<a href="#" class="section">								<span class="text-box">									Welcome									<strong class="name">${name}</strong>								</span>							</a>							<a href="#" class="opener">opener</a>						</span>						<a href="DP" class="btn-on">On</a>					</div>				</div>				<div class="tabs">					<div id="tab-1" class="tab">						<article>							<div class="text-section">							<h1>Find a Donor</h1>								<p>Search a Donor by area.</p>							</div>							<form action="blooddash.jsp" method="post">							<input type="hidden" name="pagename" value="FindDonor">							<table style="border:black solid; margin-left:100px; margin-top:100px;">							<tr>							<td>State</td>							<td><select name="state" required>										<option value="Delhi">Delhi</option>										<option value="Haryana">Haryana</option>										<option value="Rajasthan">Rajasthan</option>										<option value="Punjab">Punjab</option>										<option value="Uttara Khand">Uttara Khand</option>										<option value="Uttar Pradesh">Uttar Pradesh</option>										<option value="Madhya Pradesh">Madhya Pradesh</option>										</select></td>							</tr>							<tr>								<td>Blood Group:</td>								<td><select name="bgroup">								<option value="A+">A+</option>								<option value="B+">B+</option>								<option value="O+">O+</option>								<option value="AB+">AB+</option>								<option value="A-">A-</option>								<option value="B-">B-</option>								<option value="O-">O-</option>								<option value="AB-">AB-</option>								<option value="Bombay">Bombay</option>								</select>								</td>								</tr>							<tr>							<td><input type="submit" value="search"></td>							</tr>							</table>							</form>																<div style="margen-left:100px">							<%							String state=request.getParameter("state");							 String name=session.getAttribute("name").toString();							String bgroup=request.getParameter("bgroup");							String email=session.getAttribute("email").toString();							String url="jdbc:mysql://localhost:3306/";							String user="root";							String db="e-lab";							String pass="root";							String driver="com.mysql.jdbc.Driver";							java.sql.Connection connection=null;						 	try{							Class.forName(driver);  							connection = java.sql.DriverManager.getConnection(url+db,user,pass);							java.sql.Statement st = connection.createStatement();							java.sql.ResultSet rs = st.executeQuery("SELECT * FROM `e-lab`.donorpatient where blooddonor='on' and state='"+state+"' and bloodgroup='"+bgroup+"';");							out.print("<br><form name='request' action='RequestBlood' method='post'><table style='border:black solid; margin-left:100px; margin-top:50px;'><tr><td><b>Select</td><td><b>Name</td><td><b>Gender</td><td><b>City</td><td><b>Address</td><td><b>Blood Group</td><td><b>Number</td><tr>");							while(rs.next()){							out.print("<tr><td><input type='checkbox' name='email' value='"+rs.getString("email")+"'></td><td>"+rs.getString("fname")+" "							+rs.getString("lname")+"</td><td>"+rs.getString("gender")+"</td><td>"+rs.getString("city")+"</td><td>"+rs.getString("address")+"</td><td>"+rs.getString("bloodgroup")+"</td><td>"+rs.getString("phone")+"</td></tr>");							}							out.println("<tr><td><input type='submit' value='Send Request'></td></tr></table> </form>");							connection.close();							}							catch (Exception e){							out.println(e);							}							%>							</div>													</article>					</div>					<div id="tab-2" class="tab">						<article>							<div class="text-section">								<h1>Requests</h1>								<p>You have following requests</p>							</div>							<div style="margen-left:100px">							<%						 	try{							Class.forName(driver);  							connection = java.sql.DriverManager.getConnection(url+db,user,pass);							java.sql.Statement st = connection.createStatement();							java.sql.ResultSet rs = st.executeQuery("SELECT * FROM `e-lab`.request where reqReceiver like '"+session.getAttribute("email")+"';");							out.print("<br><table style='border:black solid; margin-left:100px; margin-top:50px;'><tr><td><b>Name</td><td><b>State</td><td><b>Address</td><td><b>Number</td><tr>");							while(rs.next()){								out.print("<tr><td>"+rs.getString("name")+"</td><td>"+rs.getString("state")+"</td><td>"+rs.getString("address")+"</td><td>"+rs.getString("phone")+"</td></tr>");							}							out.println("</table>");							connection.close();							}							catch (Exception e){							out.println(e);							}							%>							</div>						</article>					</div>					<div id="tab-3" class="tab">						<article>							<div class="text-section">								<h1>Request Path Test</h1>								<p>Request Path Test</p>							</div>							<div style="margen-left:100px">													<form action="Pathology" method="post">								<input type="hidden" name="pagename" value="request">								<input type="hidden" name="reqSender" value="<% 								String a=session.getAttribute("email").toString();								out.print(a);								%>">								<table>								<tr>								<td>Name</td>								<td><input type="text" name="name" value="<%out.print(name);%>"></td>								</tr>								<tr><td>Name of Test</td>								<td><input type="text" name="test" required/></td></tr>								<tr><td>Date of Test</td>								<td><%@ page import="java.time.format.DateTimeFormatter" %>								<%@ page import="java.time.LocalDateTime" %>								<input type="date" name="date" min="<%  DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");   								LocalDateTime now = LocalDateTime.now();   								out.print(dtf.format(now));%>"></td></tr>								<tr><td>Select Path-Lab</td>								<td><%							 	try{								Class.forName(driver);	  							connection = java.sql.DriverManager.getConnection(url+db,user,pass);								java.sql.Statement st = connection.createStatement();								java.sql.ResultSet rs = st.executeQuery("SELECT pathname,city FROM `e-lab`.pathologyreg;");								out.print("<select name='reqReceiver' >");								while(rs.next()){									out.print("<option value='"+rs.getString("pathname")+"'>"+rs.getString("pathname")+","+rs.getString("city")+"</option>");								}								connection.close();								out.print("</select>");								}								catch (Exception e){								out.println(e);								}																%></td></tr>								<tr><td>Address</td>								<td><input type="text" name="address" required/></td></tr>								<tr><td>Contect No.</td>								<td><input type="text" name="phone"  pattern="[0-9]{10}" placeholder="<10 digit number>" required/></td></tr>								<tr><td>								<input type="hidden" name="reqSender" value="<% out.print(email);%>"><input type="submit" value="Submit"></td></tr>								</table>																	</form>							</div>						</article>					</div>					<div id="tab-4" class="tab">						<article>							<div class="text-section">								<h1>Update</h1>								<p>Update your Profile</p>							</div>							<div style="margen-left:100px">													<%									try{								Class.forName(driver);									connection = java.sql.DriverManager.getConnection(url+db,user,pass);								java.sql.Statement st = connection.createStatement();								java.sql.ResultSet rs = st.executeQuery("SELECT * FROM `e-lab`.donorpatient where email like '"+email+"';");								while(rs.next()){								out.print("<br><form name='Update' action='UpdateDonor' method='post' >");								out.print("<input type='hidden' name='pagename' value='Update'/><table style='border:black solid; margin-left:100px; margin-top:50px;'><tr><td><h3>Update Profile</h3></td></tr>");								out.print("<tr><td>First Name:</td><td><input type='text' name='fname' value='"+rs.getString("fname")+"'required></td></tr>");								out.print("<tr><td>Last Name:</td><td><input type='text' name='lname' value='"+rs.getString("lname")+"'required></td></tr>");																if(rs.getString("gender").equals("male")){									out.print("</tr><tr><td>Gender:</td><td><input type='radio' name='gender' id='male' value='male' checked='checked' required><label for='male'>Male</label><input type='radio' name='gender' id='female' value='female' required><label for='male'>Female</label></td>");								}								else{									out.print("</tr><tr><td>Gender:</td><td><input type='radio' name='gender' id='male' value='male' required><label for='male'>Male</label><input type='radio' name='gender' id='female' value='female' checked='checked' required><label for='male'>Female</label></td>");								}								out.print("</tr><tr><td>Age:</td><td><input type='date' name='dob' value='"+rs.getString("dob")+"' required></td></tr>");								out.print("<tr><td>state:</td><td><select name='state' required><option value='"+rs.getString("state")+"'>"+rs.getString("state")+"</option><option value='Delhi'>Delhi</option><option value='Haryana'>Haryana</option><option value='Rajasthan'>Rajasthan</option>");								out.print("<option value='Punjab'>Punjab</option><option value='Uttara Khand'>Uttara Khand</option><option value='Uttar Pradesh'>Uttar Pradesh</option><option value='Madhya Pradesh'>Madhya Pradesh</option></select>");								out.print("<tr><td>Address:</td><td><input type='text' name='city' value='"+rs.getString("city")+"' required></td></tr>");								out.print("<tr><td>Address:</td><td><input type='text' name='address' value='"+rs.getString("address")+"' required></td></tr>");								out.print("<tr><td>Blood Group:</td><td><select name='bgroup'><option value='"+rs.getString("bloodgroup")+"'>"+rs.getString("bloodgroup")+"</option><option value='A+'>A+</option><option value='B+'>B+</option><option value='O+'>O+</option>");								out.print("<option value='AB+'>AB+</option><option value='A-'>A-</option><option value='B-'>B-</option><option value='O-'>O-</option><option value='AB-'>AB-</option><option value='Bombay'>Bombay</option></select></td></tr>");								out.print("<tr><td>Blood Donor:</td><td><input type='checkbox' name='blooddonor' ></td></tr>");								out.print("<tr><tr><td>Contact No.:</td><td><input type='text' name='phone' pattern='[0-9]{10}' value='"+rs.getString("phone")+"'required ></td></tr><tr><td>");								}																out.print("<input type='submit'id='btnSubmit' value='Submit' />");										out.print("</td></tr></table></form>");								connection.close();									}									catch (Exception e){									out.println(e);									}								%>							</div>						</article>					</div>				</div>			</div>		</div>		<aside id="sidebar">			<strong class="logo"><a href="#">E-Lab</a></strong>			<ul class="tabset buttons">				<li class="active">					<a href="#tab-1" class="ico1"><span>Find a Donor</span><em></em></a>					<span class="tooltip"><span>Find a Donor</span></span>				</li>				<li>					<a href="#tab-2" class="ico1"><span>Dashboard</span><em></em></a>					<span class="tooltip"><span>Dashboard</span></span>				</li>				<li>					<a href="#tab-3" class="ico3"><span>Request Path Test</span><em></em></a>					<span class="tooltip"><span>Request Path Test</span></span>				</li>				<li>					<a href="#tab-4" class="ico4"><span>Update</span><em></em></a>					<span class="tooltip"><span>Update</span></span>				</li>			</ul>			<span class="shadow"></span>		</aside>	</div></body></html>