package com.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;

import com.model.StudentMark;  // import your updated model class

@WebServlet("/DisplayMarksServlet")
public class DisplayMarksServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/markfinal";  // updated DB name
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIdStr = request.getParameter("studentId");

        if (studentIdStr == null || studentIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Please enter a Student ID.");
            request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
            return;
        }

        int studentId;
        try {
            studentId = Integer.parseInt(studentIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Student ID format.");
            request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
            return;
        }

        StudentMark studentMark = getStudentMark(studentId);
        if (studentMark == null) {
            request.setAttribute("error", "No record found for Student ID: " + studentId);
        } else {
            request.setAttribute("studentMark", studentMark);
        }

        request.getRequestDispatcher("markdisplay.jsp").forward(request, response);
    }

    private StudentMark getStudentMark(int studentId) {
        StudentMark sm = null;
        String sql = "SELECT * FROM student_marks WHERE StudentID = ?";  // updated table name

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        sm = new StudentMark();
                        sm.setStudentId(rs.getInt("StudentID"));
                        sm.setStudentName(rs.getString("StudentName"));
                        sm.setSection(rs.getString("Section"));
                        sm.setCc(rs.getInt("CC"));
                        sm.setMl(rs.getInt("ML"));
                        sm.setAdj(rs.getInt("ADJ"));
                        sm.setRepp(rs.getInt("REPP"));
                        sm.setIks(rs.getInt("IKS"));
                        sm.setExamDate(rs.getDate("ExamDate"));  // setting ExamDate
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sm;
    }
}
