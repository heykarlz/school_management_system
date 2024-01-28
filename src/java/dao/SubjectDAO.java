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
import model.Subject;

public class SubjectDAO {
    
    public static int add(Subject subject) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "INSERT INTO subjects(subjectCode, subjectTitle, subjectDuration, subjectDay ,teacherID) VALUES(?,?,?,?,?)";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, subject.getSubjectCode());
            stmt.setString(2, subject.getSubjectTitle());
            stmt.setInt(3, subject.getSubjectDuration());
            stmt.setString(4, subject.getSubjectDay());
            stmt.setString(5, subject.getTeacherID());
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
    
    public static int addMessage(String id, String message) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "INSERT INTO announcement(subjectCode, message) VALUES(?,?)";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, id);
            stmt.setString(2, message);
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
            String mySqlQuery = "DELETE FROM subjects WHERE subjectCode='" + id + "'";
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
    
    public static int update(Subject subject, String currentID) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "UPDATE subjects "
                    + "SET subjectCode=?, subjectTitle=?, subjectDuration=?, subjectDay=?, teacherID=? "
                    + "WHERE subjectCode=?";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, subject.getSubjectCode());
            stmt.setString(2, subject.getSubjectTitle());
            stmt.setInt(3, subject.getSubjectDuration());
            stmt.setString(4, subject.getSubjectDay());
            stmt.setString(5, subject.getTeacherID());
            stmt.setString(6, currentID);
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
    
    public static List<Subject> findAllSubjects() throws SQLException {
        List<Subject> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM subjects";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                while(rs.next()) {

                    Subject s = new Subject();

                    s.setSubjectCode(rs.getString(1));
                    s.setSubjectTitle(rs.getString(2));
                    s.setSubjectDuration(rs.getInt(3));
                    s.setSubjectDay(rs.getString(4));
                    s.setTeacherID(rs.getString(5));

                    l.add(s);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return l;
    }
    
    public static List<Subject> findAllSubjectsBySubjectCode(String code) throws SQLException {
        List<Subject> l = new ArrayList<>();     
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM subjects WHERE subjectCode='" + code + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);
                while(rs.next()) {

                    Subject s = new Subject(
                            rs.getString(1),
                            rs.getString(2),
                            rs.getInt(3),
                            rs.getString(4),
                            rs.getString(5)
                    );

                    l.add(s);
                }
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return l;
    }
    
    public static String findSubjectNameBySubjectCode(String code) throws SQLException {        
        String s = null;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT subjectTitle FROM subjects WHERE subjectCode='" + code + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);

                if(rs.next()) {
                    s = rs.getString(1);
                } 
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                        MySQL.closeConnection(connection, stmt, rs);
                }
            }       
        return s;
    }
    
    public static List<Subject> findAllSubjectsByTeacherID(String id) throws SQLException {        
        List<Subject> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT * FROM subjects WHERE teacherID='" + id + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);

                while(rs.next()) {
                    Subject subject = new Subject(rs.getString(1), rs.getString(2), rs.getInt(3), rs.getString(4), rs.getString(5));
                    l.add(subject);
                } 
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                        MySQL.closeConnection(connection, stmt, rs);
                }
            }       
        return l;
    }
    
    public static List<String> findAnnouncement(String id) throws SQLException {        
        List<String> s = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;        
            try {
                connection = MySQL.getConnection();
                String sqlSelect = "SELECT message FROM announcement WHERE subjectCode='" + id + "'";
                stmt = connection.prepareStatement(sqlSelect);
                rs = stmt.executeQuery(sqlSelect);

                while(rs.next()) {
                    s.add(rs.getString(1));
                } 
            } catch (SQLException ex) {
                ex.getMessage();
            } finally {
                if(connection != null && stmt != null && rs != null) {
                        MySQL.closeConnection(connection, stmt, rs);
                }
            }       
        return s;
    }
}
