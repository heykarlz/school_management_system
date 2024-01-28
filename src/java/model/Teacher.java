package model;

/**
Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
*/
public class Teacher {
    
    private String teacherID;
    private String teacherPassword;
    private String teacherName;
    private String teacherEmail;
    
    public Teacher() {}

    public Teacher(String teacherID, String teacherName, String teacherEmail) {
        this.teacherID = teacherID;
        this.teacherName = teacherName;
        this.teacherEmail = teacherEmail;
    }
    
    public Teacher(String teacherID, String teacherPassword, String teacherName, String teacherEmail) {
        this.teacherPassword = teacherPassword;
        this.teacherID = teacherID;
        this.teacherName = teacherName;
        this.teacherEmail = teacherEmail;
    }

    public String getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(String teacherID) {
        this.teacherID = teacherID;
    }

    public String getTeacherPassword() {
        return teacherPassword;
    }

    public void setTeacherPassword(String teacherPassword) {
        this.teacherPassword = teacherPassword;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherEmail() {
        return teacherEmail;
    }

    public void setTeacherEmail(String teacherEmail) {
        this.teacherEmail = teacherEmail;
    }
}
