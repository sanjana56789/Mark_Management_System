package com.model;

import java.sql.Date;

public class StudentMark {
    private int studentId;
    private String studentName;
    private String section;
    private int cc;
    private int ml;
    private int adj;
    private int repp;
    private int iks;
    private Date examDate; // NEW FIELD
    
    private String subjects;  // e.g. "CC", "ML", etc.
    private int marks;        // marks for that subject
    
    
    public String getSubjects() { return subjects; }
    public void setSubjects(String subjects) { this.subjects = subjects; }

    public int getMarks() { return marks; }
    public void setMarks(int marks) { this.marks = marks; }

    

    // Removed totalMarks and percentage fields

    // ====== Getters and Setters ======

    public int getStudentId() {
        return studentId;
    }
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getSection() {
        return section;
    }
    public void setSection(String section) {
        this.section = section;
    }

    public int getCc() {
        return cc;
    }
    public void setCc(int cc) {
        this.cc = cc;
    }

    public int getMl() {
        return ml;
    }
    public void setMl(int ml) {
        this.ml = ml;
    }

    public int getAdj() {
        return adj;
    }
    public void setAdj(int adj) {
        this.adj = adj;
    }

    public int getRepp() {
        return repp;
    }
    public void setRepp(int repp) {
        this.repp = repp;
    }

    public int getIks() {
        return iks;
    }
    public void setIks(int iks) {
        this.iks = iks;
    }

    public Date getExamDate() {
        return examDate;
    }
    public void setExamDate(Date examDate) {
        this.examDate = examDate;
    }

    // Calculate total marks dynamically
    public int getTotalMarks() {
        return cc + ml + adj + repp + iks;
    }

    // Calculate percentage dynamically
    public double getPercentage() {
        return (getTotalMarks() / 500.0) * 100;
    }
}
