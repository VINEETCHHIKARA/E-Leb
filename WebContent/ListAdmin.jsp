<%
							String state=request.getParameter("state");
							String bgroup=request.getParameter("bgroup");
							String url="jdbc:mysql://localhost:3306/";
							String user="root";
							String db="e-lab";
							String pass="root";
							String driver="com.mysql.jdbc.Driver";
							java.sql.Connection connection=null;
						 	try{
							Class.forName(driver);
  							connection = java.sql.DriverManager.getConnection(url+db,user,pass);
							java.sql.Statement st = connection.createStatement();
							java.sql.ResultSet rs = st.executeQuery("SELECT * FROM `e-lab`.admin;");
							out.print("<br><table style='border:black solid; margin-left:100px; margin-top:50px;'><tr><td><b>Name</td><td><b>Gender</td><td><b>Age</td><td><b>Contect No.</td><td><b>Email</td><td><b>Address</td><tr>");
							while(rs.next()){
								out.print("<tr><td>"+rs.getString("name")+"</td><td>"+rs.getString("gender")+"</td><td>"
								+rs.getInt("age")+"</td><td>"+rs.getString("phone")+"</td><td>"+rs.getString("email")+
								"</td><td>"+rs.getString("address")+"</td></tr>");
							}
							out.println("</table>");
							connection.close();
							}
							catch (Exception e){
							out.println(e);
							}
							%>