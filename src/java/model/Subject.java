package model;

import java.io.Serializable;

/**
 *
Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
 */
public class Subject implements Serializable{
    
    private String subjectCode;
    private String subjectTitle;
    private int subjectDuration;
    private String teacherID;
    private String subjectDay;

    public Subject() {}
    
    public Subject(String subjectCode, String subjectTitle, int subject_duration, String subjectDay,String teacherID) {
        this.subjectCode = subjectCode;
        this.subjectTitle = subjectTitle;
        this.subjectDuration = subject_duration;
        this.subjectDay = subjectDay;
        this.teacherID = teacherID;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectTitle() {
        return subjectTitle;
    }

    public void setSubjectTitle(String subjectTitle) {
        this.subjectTitle = subjectTitle;
    }

    public int getSubjectDuration() {
        return subjectDuration;
    }

    public void setSubjectDuration(int subjectDuration) {
        this.subjectDuration = subjectDuration;
    }

    public String getSubjectDay() {
        return subjectDay;
    }

    public void setSubjectDay(String subjectDay) {
        this.subjectDay = subjectDay;
    }    
    
    public String getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(String teacherID) {
        this.teacherID = teacherID;
    }
}
