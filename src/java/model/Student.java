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
public class Student implements Serializable{
    
    private String studentID;
    private String studentName;
    private String studentPassword;
    private String gender;
    private String guardianNum;
    private int classID;
    
    public Student() {}
    
    public Student(String student_id, String student_name, String student_password, int classID) {
        this.studentName = student_name;
        this.studentID = student_id;
        this.studentPassword = student_password;
        this.classID = classID;
    }  

    public Student(String studentID, String studentName, String gender, String guardianNum, int classID) {
        this.studentID = studentID;
        this.studentName = studentName;
        this.gender = gender;
        this.guardianNum = guardianNum;
        this.classID = classID;
    }
    
    public Student(String studentID, String studentName, String studentPassword, String gender, String guardianNum, int classID) {
        this.studentID = studentID;
        this.studentName = studentName;
        this.studentPassword = studentPassword;
        this.gender = gender;
        this.guardianNum = guardianNum;
        this.classID = classID;
    }
    
    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getStudentPassword() {
        return studentPassword;
    }

    public void setStudentPassword(String studentPassword) {
        this.studentPassword = studentPassword;
    }

    public void setClassID(int classID) {
        this.classID = classID;
    }

    public int getClassID() {
        return classID;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getGuardianNum() {
        return guardianNum;
    }

    public void setGuardianNum(String guardianNum) {
        this.guardianNum = guardianNum;
    }
    
    
}
