package com.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteMarkServlet")
public class DeleteMarkServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/markfinal";  // updated database name
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIdStr = request.getParameter("id");  // make sure form input name="id"

        if (studentIdStr == null || studentIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Student ID is required.");
            request.getRequestDispatcher("markdelete.jsp").forward(request, response);
            return;
        }

        int studentId;
        try {
            studentId = Integer.parseInt(studentIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Student ID format.");
            request.getRequestDispatcher("markdelete.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM student_marks WHERE StudentID = ?";  // updated table name
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, studentId);

                    int affectedRows = ps.executeUpdate();

                    if (affectedRows > 0) {
                        request.setAttribute("message", "Record deleted successfully for Student ID: " + studentId);
                    } else {
                        request.setAttribute("error", "No record found with Student ID: " + studentId);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error deleting record: " + e.getMessage());
        }

        request.getRequestDispatcher("markdelete.jsp").forward(request, response);
    }
}
