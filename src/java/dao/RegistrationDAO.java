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
import model.Registration;
import model.Student;

public class RegistrationDAO {
    public static int add(String id, String code) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = MySQL.getConnection();           
            String queryInsertSubj = "INSERT IGNORE INTO registration (studentID, subjectCode) VALUES (?, ?)";            
            statement = connection.prepareStatement(queryInsertSubj);
            
            statement.setString(1, id);
            statement.setString(2, code);
            
            status = statement.executeUpdate();
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null) {
                connection.close();
                statement.close();
            }
        }
        return status;
    }
    
    public static int delete(String id, String code) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {             
             connection = MySQL.getConnection();
             String sqlDelete = "DELETE FROM registration WHERE subjectCode='" + code + "' AND studentID='" + id+ "'";           
             statement = connection.prepareStatement(sqlDelete);
             status = statement.executeUpdate(sqlDelete);
             
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null) {
                connection.close();
                statement.close();
            }
        }
        return status;
    }
    
    public static int deleteAll(String id) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
             connection = MySQL.getConnection();
             String sqlDelete = "DELETE FROM registration WHERE studentID='" + id + "'";           
             statement = connection.prepareStatement(sqlDelete);
             status = statement.executeUpdate(sqlDelete);
             
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null) {
                connection.close();
                statement.close();
            }
        }
        return status;
    }
    
    public static List<Registration> findRegisteredSubjectsByStudentID(String id) throws SQLException {
        List<Registration> rg = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM registration WHERE studentID='" + id + "'";
            statement = connection.prepareStatement(sqlSelect);
            rs = statement.executeQuery(sqlSelect);
            while(rs.next()) {
                
                Registration registration = new Registration(rs.getString(1), rs.getString(2));
                rg.add(registration);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null && rs != null) {
                MySQL.closeConnection(connection, statement, rs);
            }
        }
        return rg;
    }
    
    public static int findRegisteredSubjectsBySubjectCode(String id, String code) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT subjectCode FROM registration WHERE subjectCode='" + code + "' AND studentID='" + id + "'";
            statement = connection.prepareStatement(sqlSelect);
            rs = statement.executeQuery(sqlSelect);
            if(rs.next()) {          
                status++;
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null && rs != null) {
                MySQL.closeConnection(connection, statement, rs);
            }
        }
        return status;
    }
    
    public static List<Student> findRegisteredStudentsBySubjectCode(String code) throws SQLException {
        
        List<Student> l = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT students.studentID, studentName, gender, guardianNum, classID FROM registration"
                             + " INNER JOIN students ON registration.studentID = students.studentID "
                             + "WHERE subjectCode='" + code + "'";
            statement = connection.prepareStatement(sqlSelect);
            rs = statement.executeQuery(sqlSelect);
            while(rs.next()) {          
                Student student = new Student(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(5));
                l.add(student);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null && rs != null) {
                MySQL.closeConnection(connection, statement, rs);
            }
        }
        return l;
    }
    
    public static int findRegisteredSubjects(String code) throws SQLException {
        int status = 0;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT subjectCode FROM registration WHERE subjectCode='" + code + "'";
            statement = connection.prepareStatement(sqlSelect);
            rs = statement.executeQuery(sqlSelect);
            if(rs.next()) {          
                status++;
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
            if(connection != null && statement != null && rs != null) {
                MySQL.closeConnection(connection, statement, rs);
            }
        }
        return status;
    }
}
