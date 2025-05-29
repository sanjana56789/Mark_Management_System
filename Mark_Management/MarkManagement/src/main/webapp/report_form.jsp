<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generate Student Reports</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f7f9fc;
            padding: 20px;
        }
        .container {
            max-width: 700px;
        }
        .btn-block {
            width: 100%;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Generate Student Reports</h2>

    <!-- Students Above Threshold -->
    <div class="mb-4 p-3 border rounded shadow-sm bg-light">
        <h5 class="mb-3">Students with Marks Above Threshold (%):</h5>
        <input type="number" class="form-control mb-2" id="thresholdInput" name="threshold" min="0" max="100" value="60" step="1" placeholder="Enter threshold percentage e.g. 60">
        <button type="button" class="btn btn-primary btn-block" onclick="submitForm('threshold')">
            Show Students Above Threshold
        </button>
    </div>

    <!-- Students Who Scored in a Specific Subject -->
    <div class="mb-4 p-3 border rounded shadow-sm bg-light">
        <h5 class="mb-3">Students Who Scored in a Specific Subject:</h5>
        <label for="subjectOnlyDropdown" class="form-label">Select Subject:</label>
        <select class="form-select" id="subjectOnlyDropdown" name="subject">
            <option value="cc">CC</option>
            <option value="ml">ML</option>
            <option value="adj">ADJ</option>
            <option value="repp">REPP</option>
            <option value="iks">IKS</option>
        </select>
        <button type="button" class="btn btn-info mt-2 btn-block" onclick="submitForm('subject')">
            Show Students by Subject
        </button>
    </div>

    <!-- Top N Students by Subject -->
    <div class="mb-4 p-3 border rounded shadow-sm bg-light">
        <h5 class="mb-3">Top N Students Scored in Subject:</h5>
        <label for="subjectDropdown" class="form-label">Select Subject:</label>
        <select class="form-select" id="subjectDropdown" name="subject">
            <option value="cc">CC</option>
            <option value="ml">ML</option>
            <option value="adj">ADJ</option>
            <option value="repp">REPP</option>
            <option value="iks">IKS</option>
        </select>

        <label for="topNSubject" class="form-label mt-2">Enter number of students:</label>
        <input type="number" class="form-control" id="topNSubject" name="topNSubject" min="1" placeholder="e.g., 5">

        <button type="button" class="btn btn-success mt-2 btn-block" onclick="submitForm('topNSubject')">
            Show Top N Students by Subject
        </button>
    </div>

    <!-- Top N Overall Students -->
    <div class="mb-4 p-3 border rounded shadow-sm bg-light">
        <h5 class="mb-3">Top N Students Overall:</h5>
        <label for="topN" class="form-label">Enter number of students:</label>
        <input type="number" class="form-control" id="topN" name="topN" min="1" placeholder="e.g., 5">
        <button type="button" class="btn btn-warning mt-2 btn-block" onclick="submitForm('topN')">
            Show Top N Overall Students
        </button>
    </div>

    <!-- Back Button -->
    <div class="text-center">
        <a href="index.jsp" class="btn btn-outline-secondary">← Back to Home</a>
    </div>
</div>

<!-- JavaScript for dynamic form submission -->
<script>
    function submitForm(type) {
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "ReportServlet";

        form.appendChild(createHiddenInput("reportType", type));

        if (type === 'threshold') {
            const thresholdValue = document.getElementById("thresholdInput").value;
            if(thresholdValue === "" || thresholdValue < 0 || thresholdValue > 100) {
                alert("Please enter a valid threshold between 0 and 100");
                return;
            }
            form.appendChild(createHiddenInput("threshold", thresholdValue));
        } else if (type === 'topN') {
            const val = document.getElementById("topN").value;
            if(val === "" || val < 1) {
                alert("Please enter a valid number for top N students.");
                return;
            }
            form.appendChild(createHiddenInput("topN", val));
        } else if (type === 'topNSubject') {
            const topNVal = document.getElementById("topNSubject").value;
            if(topNVal === "" || topNVal < 1) {
                alert("Please enter a valid number for top N students by subject.");
                return;
            }
            form.appendChild(createHiddenInput("subject", document.getElementById("subjectDropdown").value));
            form.appendChild(createHiddenInput("topNSubject", topNVal));
        } else if (type === 'subject') {
            form.appendChild(createHiddenInput("subject", document.getElementById("subjectOnlyDropdown").value));
        }

        document.body.appendChild(form);
        form.submit();
    }

    function createHiddenInput(name, value) {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = name;
        input.value = value;
        return input;
    }
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
