package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddMarkServlet")
public class AddMarkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/markfinal";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentIdStr = request.getParameter("id");
        String studentName = request.getParameter("name");
        String section = request.getParameter("section");
        String ccStr = request.getParameter("cc");
        String mlStr = request.getParameter("ml");
        String adjStr = request.getParameter("adj");
        String reppStr = request.getParameter("repp");
        String iksStr = request.getParameter("iks");
        String examDateStr = request.getParameter("examDate");

        // Validate inputs
        if (studentIdStr == null || studentIdStr.trim().isEmpty() ||
            studentName == null || studentName.trim().isEmpty() ||
            section == null || section.trim().isEmpty() ||
            ccStr == null || ccStr.trim().isEmpty() ||
            mlStr == null || mlStr.trim().isEmpty() ||
            adjStr == null || adjStr.trim().isEmpty() ||
            reppStr == null || reppStr.trim().isEmpty() ||
            iksStr == null || iksStr.trim().isEmpty() ||
            examDateStr == null || examDateStr.trim().isEmpty()) {

            request.setAttribute("error", "Please fill in all fields including Exam Date.");
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
            return;
        }

        int studentId, cc, ml, adj, repp, iks;
        Date examDate;

        try {
            studentId = Integer.parseInt(studentIdStr);
            cc = Integer.parseInt(ccStr);
            ml = Integer.parseInt(mlStr);
            adj = Integer.parseInt(adjStr);
            repp = Integer.parseInt(reppStr);
            iks = Integer.parseInt(iksStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter valid numeric values for Student ID and Marks.");
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
            return;
        }

        try {
            examDate = Date.valueOf(examDateStr); // Must be in YYYY-MM-DD format
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid exam date format. Use YYYY-MM-DD.");
            request.getRequestDispatcher("markadd.jsp").forward(request, response);
            return;
        }

        boolean success = addMarkToDB(studentId, studentName, section, cc, ml, adj, repp, iks, examDate);

        if (success) {
            request.setAttribute("message", "Mark added successfully!");
        } else {
            request.setAttribute("error", "Failed to add marks. Please try again.");
        }

        request.getRequestDispatcher("markadd.jsp").forward(request, response);
    }

    private boolean addMarkToDB(int studentId, String studentName, String section,
                                int cc, int ml, int adj, int repp, int iks, Date examDate) {
        boolean inserted = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String sql = "INSERT INTO student_marks (StudentID, StudentName, Section, CC, ML, ADJ, REPP, IKS, ExamDate) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, studentId);
                pstmt.setString(2, studentName);
                pstmt.setString(3, section);
                pstmt.setInt(4, cc);
                pstmt.setInt(5, ml);
                pstmt.setInt(6, adj);
                pstmt.setInt(7, repp);
                pstmt.setInt(8, iks);
                pstmt.setDate(9, examDate);

                int rows = pstmt.executeUpdate();
                inserted = (rows > 0);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return inserted;
    }
}
