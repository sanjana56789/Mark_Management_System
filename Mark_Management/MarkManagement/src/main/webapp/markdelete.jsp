<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Delete Student Marks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #fef0f0, #ffeaea);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 8px 30px rgba(150, 50, 50, 0.15);
            max-width: 500px;
            width: 100%;
            background: #ffffff;
            padding: 2.5rem 2rem;
            transition: box-shadow 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 12px 40px rgba(150, 50, 50, 0.25);
        }
        h2 {
            color: #b22222; /* Firebrick red */
            font-weight: 700;
            margin-bottom: 1.8rem;
            text-align: center;
            letter-spacing: 0.04em;
        }
        label.form-label {
            font-weight: 600;
            color: #7a2a2a;
        }
        .form-control {
            border-radius: 0.5rem;
            border: 1.5px solid #f28b8b;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-control:focus {
            border-color: #b22222;
            box-shadow: 0 0 8px rgba(178, 34, 34, 0.3);
            outline: none;
        }
        button.btn-danger {
            background: linear-gradient(145deg, #b22222, #7a1616);
            border: none;
            font-weight: 700;
            font-size: 1.15rem;
            border-radius: 0.7rem;
            padding: 0.75rem 0;
            transition: background 0.3s ease, transform 0.2s ease;
        }
        button.btn-danger:hover {
            background: linear-gradient(145deg, #7a1616, #b22222);
            transform: scale(1.05);
        }
        button.btn-danger:active {
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
            color: #b22222;
            border-color: #b22222;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        a.btn-outline-secondary:hover {
            background-color: #b22222;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="card shadow-sm">
        <h2>Delete Student Marks</h2>

        <form action="${pageContext.request.contextPath}/DeleteMarkServlet" method="post">
            <div class="mb-3">
                <label for="studentId" class="form-label">Student ID</label>
                <input type="number" id="studentId" name="id" class="form-control" required min="1" />
            </div>

            <button type="submit" class="btn btn-danger w-100">Delete Mark</button>
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
