<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Update Student Marks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #f0f4ff, #d9e6ff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 8px 30px rgba(20, 40, 80, 0.15);
            max-width: 600px;
            width: 100%;
            background: #ffffff;
            padding: 2.5rem 2rem;
            transition: box-shadow 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 12px 40px rgba(20, 40, 80, 0.25);
        }
        h2 {
            color: #0a2e8a;
            font-weight: 700;
            margin-bottom: 1.8rem;
            text-align: center;
            letter-spacing: 0.04em;
        }
        label.form-label {
            font-weight: 600;
            color: #253858;
        }
        .form-control {
            border-radius: 0.5rem;
            border: 1.5px solid #a0b9ff;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus {
            border-color: #0a2e8a;
            box-shadow: 0 0 8px rgba(10, 46, 138, 0.3);
            outline: none;
        }
        button.btn-primary {
            background: linear-gradient(145deg, #375aeb, #243ea5);
            border: none;
            font-weight: 700;
            font-size: 1.15rem;
            border-radius: 0.7rem;
            padding: 0.75rem 0;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        button.btn-primary:hover {
            background: linear-gradient(145deg, #243ea5, #375aeb);
            transform: scale(1.05);
        }
        button.btn-primary:active {
            transform: scale(0.98);
        }
        .alert {
            border-radius: 0.7rem;
            font-weight: 600;
            letter-spacing: 0.02em;
        }
        a.btn-outline-secondary {
            border-radius: 0.7rem;
            padding: 0.6rem 1.4rem;
            font-weight: 600;
            color: #375aeb;
            border-color: #375aeb;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        a.btn-outline-secondary:hover {
            background-color: #375aeb;
            color: white;
            text-decoration: none;
        }
        .subjects-section {
            margin-bottom: 1.5rem;
            padding: 1rem 1.25rem;
            border: 1.5px solid #a0b9ff;
            border-radius: 1rem;
            background-color: #f8f9fa;
        }
        .subjects-section h5 {
            color: #0a2e8a;
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: 0.04em;
        }
    </style>
</head>
<body>
    <div class="card shadow-sm">
        <h2>Update Student Marks</h2>
        
        <form action="${pageContext.request.contextPath}/markupdate" method="post">
            <div class="mb-3">
                <label for="studentId" class="form-label">Student ID</label>
                <input type="text" id="studentId" name="studentId" class="form-control" required />
            </div>

            <div class="mb-3">
                <label for="studentName" class="form-label">Student Name</label>
                <input type="text" id="studentName" name="studentName" class="form-control" required />
            </div>

            <div class="mb-3">
                <label for="section" class="form-label">Section</label>
                <input type="text" id="section" name="section" class="form-control" required />
            </div>

            <div class="subjects-section">
                <h5>Subjects</h5>
                <select id="subject" name="subject" class="form-select" required>
                    <option value="" disabled selected>Select Subject</option>
                    <option value="CC">CC</option>
                    <option value="ML">ML</option>
                    <option value="ADJ">ADJ</option>
                    <option value="REPP">REPP</option>
                    <option value="IKS">IKS</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="examDate" class="form-label">Exam Date</label>
                <input type="date" id="examDate" name="examDate" class="form-control" required />
            </div>

            <div class="mb-4">
                <label for="marks" class="form-label">New Marks</label>
                <input type="number" id="marks" name="marks" class="form-control" min="0" max="100" required />
            </div>

            <button type="submit" class="btn btn-primary w-100">Update</button>
        </form>

        <%
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
        %>
        <div class="mt-4">
            <% if (message != null) { %>
                <div class="alert alert-success text-center"><%= message %></div>
            <% } else if (error != null) { %>
                <div class="alert alert-danger text-center"><%= error %></div>
            <% } %>
        </div>

        <div class="mt-4 text-center">
            <a href="index.jsp" class="btn btn-outline-secondary">Back to Home</a>
        </div>
    </div>
</body>
</html>
