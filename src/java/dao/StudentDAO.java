/*
Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
 */
package dao;

import database.MySQL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Student;

public class StudentDAO {
    
    public static int add(Student student) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "INSERT INTO students VALUES(?,?,?,?,?,?)";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, student.getStudentID());
            stmt.setString(2, student.getStudentName());
            stmt.setString(3, student.getStudentPassword());
            stmt.setString(4, student.getGender());
            stmt.setString(5, student.getGuardianNum());
            stmt.setInt(6, student.getClassID());
            result = stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Exception is ; " + e);
        } finally {
            if(connection != null && stmt != null) {
                connection.close();
                stmt.close();
            }
        }
        return result;
    }
    
    public static int delete(String id) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "DELETE FROM students WHERE studentID='" + id + "'";
            stmt = connection.prepareStatement(mySqlQuery);
            result = stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Exception is ; " + e);
        } finally {
            if(connection != null && stmt != null) {
                connection.close();
                stmt.close();
            }
        }
        return result;
    }
    
    public static int update(Student student) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "UPDATE students "
                    + "SET studentName=?, gender=?, guardianNum=?, classID=? "
                    + "WHERE studentID=?";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, student.getStudentName());
            stmt.setString(2, student.getGender());
            stmt.setString(3, student.getGuardianNum());
            stmt.setInt(4, student.getClassID());
            stmt.setString(5, student.getStudentID());
            result = stmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Exception is ; " + e);
        } finally {
            if(connection != null && stmt != null) {
                connection.close();
                stmt.close();
            }
        }
        return result;
    }
    
    public static List<Student> findAllStudents() throws SQLException {
        List<Student> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM students";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                while(rs.next()) {

                    Student student = new Student(
                                        rs.getString(1),
                                        rs.getString(2),
                                        rs.getString(3),
                                        rs.getString(4),
                                        rs.getString(5),
                                        rs.getInt(6)
                                    );
                    l.add(student);
                }
            } catch (SQLException e) {
                System.out.println("Exception is " + e);
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        
        return l;
    }
    
    public static Student findStudentById(String id) throws SQLException {
        Student student = null;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String studID = id.trim();
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM students WHERE studentID='" + studID + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                if(rs.next()) {
                     student = new Student(
                                        rs.getString(1),
                                        rs.getString(2),
                                        rs.getString(3),
                                        rs.getString(4),
                                        rs.getString(5),
                                        rs.getInt(6)
                                    );
                }
            } catch (SQLException e) {
                System.out.println("Exception is " + e);
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        
        return student;
    }
    
    public static List<Student> findStudentBySubjectId(String id) throws SQLException {
        List<Student> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String subjectID = id.trim();
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT students.studentID, studentName, studentPassword, gender, guardianNum, classID"
                                 + " FROM registration INNER JOIN students ON students.studentID = registration.studentID"
                                 + " WHERE subjectCode='" + subjectID + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                while(rs.next()) {
                     Student student = new Student(
                                        rs.getString(1),
                                        rs.getString(2),
                                        rs.getString(3),
                                        rs.getString(4),
                                        rs.getString(5),
                                        rs.getInt(6)
                                    );
                     l.add(student);
                }
            } catch (SQLException e) {
                System.out.println("Exception is " + e);
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        
        return l;
    }
    
    public static String findClassByClassID(int id) throws SQLException {
        String str = "";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT className FROM classroom WHERE classID='" + id + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            if(rs.next()) {
                str = rs.getString(1);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && stmt != null && rs != null) {
                MySQL.closeConnection(connection, stmt, rs);
            }
        }
        return str;
    }
}
