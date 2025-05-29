<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.model.StudentMark" %>

<!DOCTYPE html>
<html>
<head>
    <title>Report Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background: #f8f9fa;
        }
        .container {
            max-width: 1100px;
            margin-top: 30px;
        }
        .table-container {
            margin-top: 20px;
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        canvas {
            margin-top: 40px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Report Results</h2>

<%
    List<StudentMark> results = (List<StudentMark>) request.getAttribute("results");
    String error = (String) request.getAttribute("error");
    String reportType = (String) request.getAttribute("reportType");
    Double threshold = (Double) request.getAttribute("threshold");
    if (threshold == null) threshold = 60.0;

    if (error != null) {
%>
    <div class="alert alert-danger mt-3"><%= error %></div>
<%
    } else if (results == null || results.isEmpty()) {
%>
    <div class="alert alert-warning mt-3">No records found.</div>
<%
    } else {
        boolean isSubjectReport = "subject".equals(reportType) || "topNSubject".equals(reportType);
        boolean isTopNOverall = "topN".equals(reportType);
        boolean isThresholdReport = "threshold".equals(reportType);
%>
    <div class="table-container">
        <h5>
            <%= isThresholdReport ? "Students Above " + String.format("%.2f", threshold) + "%" :
                isSubjectReport ? "Students by Subject" :
                "Top N Students Overall" %>
        </h5>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
            <tr>
                <th>Student ID</th>
                <th>Name</th>
                <th>Section</th>
                <% if (isSubjectReport) { %>
                    <th>Subject</th>
                    <th>Marks</th>
                <% } else { %>
                    <th>CC</th>
                    <th>ML</th>
                    <th>ADJ</th>
                    <th>REPP</th>
                    <th>IKS</th>
                    <th>Total</th>
                    <% if (isThresholdReport) { %><th>Percentage</th><% } %>
                <% } %>
            </tr>
            </thead>
            <tbody>
            <% for (StudentMark sm : results) {
                   if (isThresholdReport && sm.getPercentage() < threshold) continue;
            %>
                <tr>
                    <td><%= sm.getStudentId() %></td>
                    <td><%= sm.getStudentName() %></td>
                    <td><%= sm.getSection() %></td>
                    <% if (isSubjectReport) { %>
                        <td><%= sm.getSubjects() %></td>
                        <td><%= sm.getMarks() %></td>
                    <% } else { %>
                        <td><%= sm.getCc() %></td>
                        <td><%= sm.getMl() %></td>
                        <td><%= sm.getAdj() %></td>
                        <td><%= sm.getRepp() %></td>
                        <td><%= sm.getIks() %></td>
                        <td><%= sm.getTotalMarks() %></td>
                        <% if (isThresholdReport) { %>
                            <td><%= String.format("%.2f", sm.getPercentage()) %>%</td>
                        <% } %>
                    <% } %>
                </tr>
            <% } %>
            </tbody>
        </table>

        <% if (!isThresholdReport) { %>
        <!-- Chart -->
        <canvas id="marksChart" width="400" height="200"></canvas>
        <script>
            const labels = [
                <% for (StudentMark sm : results) {
                    String label = sm.getStudentName();
                    if (isSubjectReport) {
                        label += " (" + sm.getSubjects() + ")";
                    }
                %>
                    "<%= label %>",
                <% } %>
            ];
            const data = {
                labels: labels,
                datasets: [{
                    label: '<%= isSubjectReport ? "Marks" : "Total Marks" %>',
                    data: [
                        <% for (StudentMark sm : results) { %>
                            <%= isSubjectReport ? sm.getMarks() : sm.getTotalMarks() %>,
                        <% } %>
                    ],
                    backgroundColor: 'rgba(75, 192, 192, 0.6)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            };

            new Chart(document.getElementById('marksChart'), {
                type: 'bar',
                data: data,
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false },
                        title: {
                            display: true,
                            text: '<%= isSubjectReport ? "Subject-wise Marks" : "Overall Top Performers" %>'
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
        <% } %>
    </div>
<% } %>

    <div class="text-center mt-4">
        <a href="report_form.jsp" class="btn btn-secondary">← Back to Reports</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
