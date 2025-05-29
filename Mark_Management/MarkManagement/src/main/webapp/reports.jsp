<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reports - Mark Management System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    
</head>
<body>
    <h2>Generate Reports</h2>

    <form action="reportCriteria" method="post">
        <label>Select Report Type:</label><br><br>

        <input type="radio" name="reportType" value="aboveThreshold" required> Students with marks above a threshold<br><br>

        <input type="radio" name="reportType" value="subjectScore"> Students who scored in a specific subject<br><br>

        <input type="radio" name="reportType" value="topN"> Top N students<br><br>

        <input type="submit" value="Next">
    </form>

    <br>
    <a href="index.jsp">Back to Home</a>
</body>
</html>
