package model;

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
public class Classroom {
    
    private int classID;
    private String className;

    public Classroom() {
    }

    public Classroom(int classID, String className) {
        this.classID = classID;
        this.className = className;
    }

    public void setClassID(int classID) {
        this.classID = classID;
    }

    public int getClassID() {
        return classID;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getClassName() {
        return className;
    }
}
