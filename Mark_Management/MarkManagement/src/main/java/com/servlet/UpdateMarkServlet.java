package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/markupdate")
public class UpdateMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Updated DB URL to use database "markfinal"
    private static final String DB_URL = "jdbc:mysql://localhost:3306/markfinal";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String section = request.getParameter("section");
        String subject = request.getParameter("subject");
        String marksStr = request.getParameter("marks");
        String examDate = request.getParameter("examDate");  // new parameter for ExamDate

        int marks;
        try {
            marks = Integer.parseInt(marksStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid marks input.");
            request.getRequestDispatcher("markupdate.jsp").forward(request, response);
            return;
        }

        boolean updated = updateMarkInDB(studentId, studentName, section, subject, marks, examDate);

        if (updated) {
            request.setAttribute("message", "Mark updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update mark. Please check the inputs.");
        }

        request.getRequestDispatcher("markupdate.jsp").forward(request, response);
    }

    private boolean updateMarkInDB(String studentId, String studentName, String section, String subject, int marks, String examDate) {
        boolean success = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Update query includes examDate in WHERE clause (assuming examDate is a string in 'yyyy-MM-dd' format)
            String sql = "UPDATE student_marks SET " + subject + " = ? WHERE StudentID = ? AND StudentName = ? AND Section = ? AND ExamDate = ?";

            try (
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                PreparedStatement pstmt = conn.prepareStatement(sql)
            ) {
                pstmt.setInt(1, marks);
                pstmt.setInt(2, Integer.parseInt(studentId));
                pstmt.setString(3, studentName);
                pstmt.setString(4, section);
                pstmt.setString(5, examDate);

                success = pstmt.executeUpdate() > 0;
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return success;
    }
}
