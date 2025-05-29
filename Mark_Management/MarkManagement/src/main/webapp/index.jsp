<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mark Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #d0e7ff, #f8fbff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #1a2a52;
        }
        .card {
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(26, 42, 82, 0.15);
            padding: 2rem 2.5rem;
            background: #ffffff;
            max-width: 420px;
            margin: auto;
        }
        h2 {
            font-weight: 700;
            letter-spacing: 0.05em;
            margin-bottom: 2rem;
            color: #0d1c45;
            text-align: center;
            text-shadow: 0 1px 2px rgba(13, 28, 69, 0.3);
        }
        .btn {
            font-size: 1.1rem;
            padding: 0.75rem 1.25rem;
            border-radius: 0.6rem;
            border: 1.5px solid #7aa7ff;
            background: linear-gradient(145deg, #d8e6ff, #aebfff);
            color: #0d1c45;
            text-align: left;
            box-shadow: 4px 4px 8px #aec6f7,
                        -4px -4px 8px #f0f6ff;
            transition: all 0.3s ease;
            font-weight: 600;
            letter-spacing: 0.02em;
        }
        .btn:hover, .btn:focus {
            background: linear-gradient(145deg, #aebfff, #d8e6ff);
            border-color: #4669d4;
            color: #0a1540;
            box-shadow: 6px 6px 12px #7c99f3,
                        -6px -6px 12px #f3f8ff;
            transform: scale(1.04);
        }
        .btn:active {
            background: #91a9e7;
            border-color: #2e438e;
            box-shadow: inset 3px 3px 5px #5f76c1,
                        inset -3px -3px 5px #b9c9ff;
            transform: scale(0.98);
        }
        .btn .icon {
            margin-right: 0.7rem;
            font-size: 1.4rem;
            vertical-align: middle;
        }
        .d-grid {
            gap: 1.25rem !important;
        }
    </style>
</head>
<body>

<div class="container d-flex align-items-center justify-content-center vh-100">
    <div class="card">
        <h2>Mark Management System</h2>
        <div class="d-grid">
            <a href="markadd.jsp" class="btn"><i class="bi bi-plus-circle icon"></i> Add Marks</a>
            <a href="markupdate.jsp" class="btn"><i class="bi bi-pencil-square icon"></i> Update Marks</a>
            <a href="markdelete.jsp" class="btn"><i class="bi bi-trash icon"></i> Delete Marks</a>
            <a href="markdisplay.jsp" class="btn"><i class="bi bi-card-list icon"></i> Display All Marks</a>
            <a href="report_form.jsp" class="btn"><i class="bi bi-bar-chart-line icon"></i> Generate Report</a>
        </div>
    </div>
</div>

</body>
</html>
