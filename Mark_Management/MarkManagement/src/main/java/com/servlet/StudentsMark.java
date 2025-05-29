package com.servlet;

import java.sql.Date; // Use java.sql.Date for database date compatibility

public class StudentsMark {
    private int studentId;
    private String studentName;
    private String section;
    private int cc;
    private int ml;
    private int adj;
    private int repp;
    private int iks;
    private Date examDate;  // New field for ExamDate

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }

    public int getCc() { return cc; }
    public void setCc(int cc) { this.cc = cc; }

    public int getMl() { return ml; }
    public void setMl(int ml) { this.ml = ml; }

    public int getAdj() { return adj; }
    public void setAdj(int adj) { this.adj = adj; }

    public int getRepp() { return repp; }
    public void setRepp(int repp) { this.repp = repp; }

    public int getIks() { return iks; }
    public void setIks(int iks) { this.iks = iks; }

    public Date getExamDate() { return examDate; }   // getter for ExamDate
    public void setExamDate(Date examDate) { this.examDate = examDate; }  // setter for ExamDate

    // Calculated methods
    public int getTotalMarks() {
        return cc + ml + adj + repp + iks;
    }

    public double getPercentage() {
        return (getTotalMarks() / 500.0) * 100; // assuming max total marks = 500
    }
}
