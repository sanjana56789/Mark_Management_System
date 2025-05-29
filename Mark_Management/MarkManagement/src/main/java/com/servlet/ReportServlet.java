package com.servlet;

import com.dao.MarkDAO;
import com.model.StudentMark;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to report form JSP
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("reportType");
        List<StudentMark> results = null;

        try {
            MarkDAO dao = new MarkDAO();

            if (type == null || type.trim().isEmpty()) {
                request.setAttribute("error", "Report type is missing.");
            } else {
                switch (type) {
                    case "topN":
                        try {
                            int topN = Integer.parseInt(request.getParameter("topN"));
                            results = dao.getTopNStudents(topN);  // DAO should query markfinal.student_marks
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "Invalid number for Top N students.");
                        }
                        break;

                    case "threshold":
                        try {
                            String thresholdParam = request.getParameter("threshold");
                            if (thresholdParam == null || thresholdParam.trim().isEmpty()) {
                                request.setAttribute("error", "Threshold value is missing.");
                                break;
                            }
                            double threshold = Double.parseDouble(thresholdParam);
                            if (threshold < 0 || threshold > 100) {
                                request.setAttribute("error", "Threshold must be between 0 and 100.");
                                break;
                            }
                            results = dao.getStudentsAboveThreshold(threshold);  // DAO uses ExamDate column here as needed
                            request.setAttribute("threshold", threshold);
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "Invalid threshold value.");
                        }
                        break;

                    case "subject":
                        String subject = request.getParameter("subject");
                        if (subject == null || subject.trim().isEmpty()) {
                            request.setAttribute("error", "Subject cannot be empty.");
                        } else {
                            results = dao.getMarksBySubject(subject.trim());  // DAO queries markfinal.student_marks
                        }
                        break;

                    case "topNSubject":
                        try {
                            String subj = request.getParameter("subject");
                            int topNSub = Integer.parseInt(request.getParameter("topNSubject"));
                            results = dao.getTopNStudentsBySubject(subj.trim(), topNSub);  // DAO queries markfinal.student_marks
                        } catch (Exception e) {
                            request.setAttribute("error", "Invalid subject or number value for Top N by Subject.");
                        }
                        break;

                    default:
                        request.setAttribute("error", "Invalid report type.");
                        break;
                }
            }

            if (request.getAttribute("error") == null) {
                request.setAttribute("results", results);
            }
            request.setAttribute("reportType", type);

            request.getRequestDispatcher("report_result.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error generating report", e);
        }
    }
}
