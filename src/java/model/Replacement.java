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
public class Replacement {
    
    private String onLeaveTeacherID;
    private String replacementTeacherID;
    private String subjectID;

    public Replacement(String onLeaveTeacherID, String replacementTeacherID, String subjectID) {
        this.onLeaveTeacherID = onLeaveTeacherID;
        this.replacementTeacherID = replacementTeacherID;
        this.subjectID = subjectID;
    }
    
    public String getOnLeaveTeacherID() {
        return onLeaveTeacherID;
    }

    public void setOnLeaveTeacherID(String onLeaveTeacherID) {
        this.onLeaveTeacherID = onLeaveTeacherID;
    }

    public String getReplacementTeacherID() {
        return replacementTeacherID;
    }

    public void setReplacementTeacherID(String replacementTeacherID) {
        this.replacementTeacherID = replacementTeacherID;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }
    
    
}
