<%@ page import="com.model.StudentMark" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    StudentMark sm = (StudentMark) request.getAttribute("studentMark");
    String error = (String) request.getAttribute("error");
    boolean isFail = (sm != null && sm.getPercentage() < 35.0);
    boolean isPass = (sm != null && sm.getPercentage() >= 35.0);

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Display Student Marks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e9f7ef, #d1f2eb);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem;
        }

        .card {
            border-radius: 1rem;
            max-width: 700px;
            width: 100%;
            padding: 2.5rem 2rem;
            transition: box-shadow 0.3s ease;
            box-shadow: 0 8px 30px rgba(50, 150, 50, 0.15);
            background: #ffffff;
        }

        .card.fail-mode {
            background: #fce4e4; /* light red */
            box-shadow: 0 8px 30px rgba(200, 0, 0, 0.15);
        }

        .card.pass-mode {
            background: #c8e6c9; /* darker green */
            box-shadow: 0 8px 30px rgba(50, 150, 50, 0.15);
        }

        h2 {
            font-weight: 700;
            margin-bottom: 1.8rem;
            text-align: center;
            letter-spacing: 0.04em;
        }

        label.form-label {
            font-weight: 600;
        }

        .form-control {
            border-radius: 0.5rem;
            border: 1.5px solid #a5d6a7;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus {
            border-color: #2e7d32;
            box-shadow: 0 0 8px rgba(46, 125, 50, 0.3);
            outline: none;
        }

        .btn-primary {
            font-weight: 700;
            font-size: 1.15rem;
            border-radius: 0.7rem;
            padding: 0.75rem 0;
            width: 100%;
            color: white;
            border: none;
            transition: transform 0.2s ease;
        }

        .pass-mode .btn-primary {
            background: linear-gradient(145deg, #2e7d32, #1b5e20);
        }

        .fail-mode .btn-primary {
            background: linear-gradient(145deg, #b30000, #800000);
        }

        .btn-primary:hover {
            transform: scale(1.05);
        }

        .btn-primary:active {
            transform: scale(0.98);
        }

        table {
            margin-top: 1.5rem;
            border-radius: 0.7rem;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(46, 125, 50, 0.1);
        }

        th {
            background-color: #2e7d32;
            color: white;
            font-weight: 600;
        }

        td, th {
            padding: 0.75rem 1rem;
            text-align: center;
        }

        .total-percentage {
            margin-top: 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .alert {
            border-radius: 0.7rem;
            font-weight: 600;
            margin-top: 1rem;
            color: #b71c1c;
            background-color: #fce4e4;
            border: 1px solid #f44336;
        }

        .btn-outline-secondary {
            border-radius: 0.7rem;
            padding: 0.6rem 1.4rem;
            font-weight: 600;
            transition: background-color 0.3s ease, color 0.3s ease;
            margin-top: 1.5rem;
            width: 100%;
            text-align: center;
            display: inline-block;
            text-decoration: none;
        }

        .pass-mode .btn-outline-secondary {
            color: #2e7d32;
            border-color: #2e7d32;
        }

        .pass-mode .btn-outline-secondary:hover {
            background-color: #2e7d32;
            color: white;
        }

        .fail-mode .btn-outline-secondary {
            color: #b30000;
            border-color: #b30000;
        }

        .fail-mode .btn-outline-secondary:hover {
            background-color: #b30000;
            color: white;
        }
    </style>
</head>
<body>
    <div class="card shadow-sm <%= isFail ? "fail-mode" : isPass ? "pass-mode" : "" %>">
        <h2>Display Student Marks</h2>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/DisplayMarksServlet" method="get">
            <label for="studentId" class="form-label">Enter Student ID</label>
            <input type="number" id="studentId" name="studentId" class="form-control" required min="1" placeholder="e.g. 1" />
            <button type="submit" class="btn btn-primary mt-3">Display</button>
        </form>

        <!-- Error -->
        <% if (error != null) { %>
            <div class="alert text-center"><%= error %></div>
        <% } %>

        <% if (sm != null) {
            double percentage = sm.getPercentage();
            String result = percentage < 35.0 ? "Fail" : "Pass";
        %>
            <hr/>
            <p>
               <strong>Student ID:</strong> <%= sm.getStudentId() %> &nbsp;&nbsp;
               <strong>Name:</strong> <%= sm.getStudentName() %> &nbsp;&nbsp;
               <strong>Section:</strong> <%= sm.getSection() %> &nbsp;&nbsp;
               <strong>Exam Date:</strong> <%= sm.getExamDate() != null ? sdf.format(sm.getExamDate()) : "N/A" %>
            </p>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>SR NO</th>
                        <th>Subject</th>
                        <th>Marks</th>
                    </tr>
                </thead>
                <tbody>
                    <tr><td>1</td><td>CC</td><td><%= sm.getCc() %></td></tr>
                    <tr><td>2</td><td>ML</td><td><%= sm.getMl() %></td></tr>
                    <tr><td>3</td><td>ADJ</td><td><%= sm.getAdj() %></td></tr>
                    <tr><td>4</td><td>REPP</td><td><%= sm.getRepp() %></td></tr>
                    <tr><td>5</td><td>IKS</td><td><%= sm.getIks() %></td></tr>
                </tbody>
            </table>

            <p class="total-percentage"><strong>Total Marks:</strong> <%= sm.getTotalMarks() %> / 500</p>
            <p class="total-percentage"><strong>Percentage:</strong> <%= String.format("%.2f", percentage) %> %</p>
            <p class="total-percentage"><strong>Result:</strong> <%= result %></p>
        <% } %>

        <a href="index.jsp" class="btn btn-outline-secondary">Back to Home</a>
    </div>
</body>
</html>
