package com.dao;

import com.model.StudentMark;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MarkDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/markfinal";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_MARK_SQL =
        "INSERT INTO student_marks (StudentID, StudentName, Section, CC, ML, ADJ, REPP, IKS, ExamDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    protected Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void addMark(StudentMark mark) throws Exception {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_MARK_SQL)) {

            preparedStatement.setInt(1, mark.getStudentId());
            preparedStatement.setString(2, mark.getStudentName());
            preparedStatement.setString(3, mark.getSection());
            preparedStatement.setInt(4, mark.getCc());
            preparedStatement.setInt(5, mark.getMl());
            preparedStatement.setInt(6, mark.getAdj());
            preparedStatement.setInt(7, mark.getRepp());
            preparedStatement.setInt(8, mark.getIks());
            preparedStatement.setDate(9, new java.sql.Date(mark.getExamDate().getTime()));

            preparedStatement.executeUpdate();
        }
    }

    // Helper: Validate subject name against allowed columns to prevent SQL injection
    private String validateSubject(String subject) throws Exception {
        String s = subject.toUpperCase();
        switch (s) {
            case "CC":
            case "ML":
            case "ADJ":
            case "REPP":
            case "IKS":
                return s;
            default:
                throw new Exception("Invalid subject name: " + subject);
        }
    }

    public List<StudentMark> getTopNStudents(int n) throws Exception {
        List<StudentMark> list = new ArrayList<>();
        String sql = "SELECT StudentID, StudentName, Section, CC, ML, ADJ, REPP, IKS, ExamDate, " +
                     "(CC + ML + ADJ + REPP + IKS) AS TotalMarks " +
                     "FROM student_marks ORDER BY TotalMarks DESC LIMIT ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, n);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    StudentMark sm = new StudentMark();
                    sm.setStudentId(rs.getInt("StudentID"));
                    sm.setStudentName(rs.getString("StudentName"));
                    sm.setSection(rs.getString("Section"));
                    sm.setCc(rs.getInt("CC"));
                    sm.setMl(rs.getInt("ML"));
                    sm.setAdj(rs.getInt("ADJ"));
                    sm.setRepp(rs.getInt("REPP"));
                    sm.setIks(rs.getInt("IKS"));
                    sm.setExamDate(rs.getDate("ExamDate"));
                    // No setTotalMarks - calculated dynamically in model
                    list.add(sm);
                }
            }
        }
        return list;
    }

    public List<StudentMark> getStudentsAboveThreshold(double threshold) throws Exception {
        List<StudentMark> list = new ArrayList<>();
        String sql = "SELECT StudentID, StudentName, Section, CC, ML, ADJ, REPP, IKS, ExamDate " +
                     "FROM student_marks " +
                     "WHERE ((CC + ML + ADJ + REPP + IKS) / 500.0) * 100 >= ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setDouble(1, threshold);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    StudentMark sm = new StudentMark();
                    sm.setStudentId(rs.getInt("StudentID"));
                    sm.setStudentName(rs.getString("StudentName"));
                    sm.setSection(rs.getString("Section"));
                    sm.setCc(rs.getInt("CC"));
                    sm.setMl(rs.getInt("ML"));
                    sm.setAdj(rs.getInt("ADJ"));
                    sm.setRepp(rs.getInt("REPP"));
                    sm.setIks(rs.getInt("IKS"));
                    sm.setExamDate(rs.getDate("ExamDate"));
                    list.add(sm);
                }
            }
        }
        return list;
    }

    public List<StudentMark> getMarksBySubject(String subject) throws Exception {
        List<StudentMark> list = new ArrayList<>();
        String subjectCol = validateSubject(subject);
        String sql = "SELECT StudentID, StudentName, Section, ExamDate, " + subjectCol + " AS marks FROM student_marks ORDER BY marks DESC";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                StudentMark sm = new StudentMark();
                sm.setStudentId(rs.getInt("StudentID"));
                sm.setStudentName(rs.getString("StudentName"));
                sm.setSection(rs.getString("Section"));
                sm.setSubjects(subjectCol);
                sm.setMarks(rs.getInt("marks"));
                sm.setExamDate(rs.getDate("ExamDate"));
                list.add(sm);
            }
        }
        return list;
    }

    public List<StudentMark> getTopNStudentsBySubject(String subject, int topN) throws Exception {
        List<StudentMark> list = new ArrayList<>();
        String subjectCol = validateSubject(subject);
        String sql = "SELECT StudentID, StudentName, Section, ExamDate, " + subjectCol + " AS marks " +
                     "FROM student_marks ORDER BY marks DESC LIMIT ?";

        try (Connection connection = getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, topN);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    StudentMark sm = new StudentMark();
                    sm.setStudentId(rs.getInt("StudentID"));
                    sm.setStudentName(rs.getString("StudentName"));
                    sm.setSection(rs.getString("Section"));
                    sm.setSubjects(subjectCol);
                    sm.setMarks(rs.getInt("marks"));
                    sm.setExamDate(rs.getDate("ExamDate"));
                    list.add(sm);
                }
            }
        }
        return list;
    }

    public List<StudentMark> getAllStudentMarks() throws Exception {
        List<StudentMark> list = new ArrayList<>();
        String sql = "SELECT StudentID, StudentName, Section, CC, ML, ADJ, REPP, IKS, ExamDate FROM student_marks";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                StudentMark sm = new StudentMark();
                sm.setStudentId(rs.getInt("StudentID"));
                sm.setStudentName(rs.getString("StudentName"));
                sm.setSection(rs.getString("Section"));
                sm.setCc(rs.getInt("CC"));
                sm.setMl(rs.getInt("ML"));
                sm.setAdj(rs.getInt("ADJ"));
                sm.setRepp(rs.getInt("REPP"));
                sm.setIks(rs.getInt("IKS"));
                sm.setExamDate(rs.getDate("ExamDate"));
                list.add(sm);
            }
        }
        return list;
    }
}
