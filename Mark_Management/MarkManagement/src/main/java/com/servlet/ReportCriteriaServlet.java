package com.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ReportCriteriaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward request to report_form.jsp to display the report criteria form
        RequestDispatcher rd = request.getRequestDispatcher("report_form.jsp");
        rd.forward(request, response);
    }
}
