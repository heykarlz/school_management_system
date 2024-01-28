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
import model.Replacement;
import model.Teacher;

public class TeacherDAO {
    
    public static int add(Teacher teacher) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "INSERT INTO teachers VALUES(?,?,?,?)";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, teacher.getTeacherID());
            stmt.setString(2, teacher.getTeacherPassword());
            stmt.setString(3, teacher.getTeacherName());
            stmt.setString(4, teacher.getTeacherEmail());
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
    
    public static int update(Teacher teacher) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "UPDATE teachers "
                    + "SET teacherPassword=?, teacherName=?, teacherEmail=?"
                    + "WHERE teacherID=?";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, teacher.getTeacherPassword());
            stmt.setString(2, teacher.getTeacherName());
            stmt.setString(3, teacher.getTeacherEmail());
            stmt.setString(4, teacher.getTeacherID());
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
            String mySqlQuery = "DELETE FROM teachers WHERE teacherID='" + id + "'";
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
    
     public static List<Teacher> findAllTeachers() throws SQLException {
        List<Teacher> t = new ArrayList<>();
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM teachers";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            while(rs.next()) {
                
                Teacher s = new Teacher(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                );
                
                t.add(s);
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return t;
    }
     
     public static List<Teacher> findAllTeachersBySubjectCode(String code) throws SQLException {
        List<Teacher> l = new ArrayList<>();        
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {        
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT teachers.teacherID, teacherPassword, teacherName, teacherEmail "
                             + "FROM subjects INNER JOIN teachers ON subjects.teacherID = teachers.teacherID "
                             + "WHERE subjectCode='" + code + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);

            if(rs.next()) {

                Teacher t = new Teacher(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                );
                       
                l.add(t);               
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
     
     public static Teacher findTeacherBySubjectCode(String code) throws SQLException {
        Teacher t = null;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT teachers.teacherID, teacherPassword, teacherName, teacherEmail "
                             + "FROM subjects INNER JOIN teachers ON subjects.teacherID = teachers.teacherID "
                             + "WHERE subjectCode='" + code + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);

            if(rs.next()) {

                 t = new Teacher(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)
                );              
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        
        return t;
     }
     
     public static Teacher findTeacherByTeacherId(String id) throws SQLException {
         Teacher t = null;
         Connection connection = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM teachers where teacherID = '" + id +"'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            if(rs.next()) {               
                t = new Teacher(
                    rs.getString(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4)
                );      
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return t;
     }
     
     public static int findTeacherStatus(String teacherID, String subjectID) throws SQLException {
         int status = 0;
         Connection connection = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM replacement where onLeaveTeacher = '" + teacherID +"' AND subjectCode='" + subjectID + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            if(rs.next()) {               
                status++;
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return status;
     }
     
     public static List<Replacement> findAllReplacementTeacher() throws SQLException {
         List<Replacement> l = new ArrayList<>();
         Connection connection = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT * FROM replacement";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            while(rs.next()) {               
                Replacement teacher = new Replacement(rs.getString(1), rs.getString(2), rs.getString(3));
                l.add(teacher);
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
     
     public static Teacher findReplacementTeacher(String teacherID, String subjectID) throws SQLException {
         Teacher teacher = null;
         Connection connection = null;
         PreparedStatement stmt = null;
         ResultSet rs = null;
         try {
            connection = MySQL.getConnection();
            String sqlSelect = "SELECT teachers.teacherID, teacherName, teacherEmail FROM replacement INNER JOIN teachers "
                              + " ON replacement.replacementTeacher = teachers.teacherID"
                              + " WHERE onLeaveTeacher = '" + teacherID +"' AND subjectCode='" + subjectID + "'";
            stmt = connection.prepareStatement(sqlSelect);
            rs = stmt.executeQuery(sqlSelect);
            if(rs.next()) {               
                teacher = new Teacher(rs.getString(1), rs.getString(2), rs.getString(3));
            }
        } catch (SQLException ex) {
            ex.getMessage();
        } finally {
                if(connection != null && stmt != null && rs != null) {
                    MySQL.closeConnection(connection, stmt, rs);
                }
            }
        return teacher;
     }
     
     public static int addReplacementTeacher(String teacherID, String replaceID, String code) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "INSERT INTO replacement VALUES(?,?,?)";
            stmt = connection.prepareStatement(mySqlQuery);
            stmt.setString(1, teacherID);
            stmt.setString(2, replaceID);
            stmt.setString(3, code);

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
    
    public static int updateReplacementTeacher(String teacherID, String replaceID, String code) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "UPDATE replacement SET replacementTeacher='" + replaceID + "' "
                              + "WHERE onLeaveTeacher='" + teacherID + "' AND subjectCode='" + code + "'";
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
     
     public static int deleteReplacementTeacher(String id, String code) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "DELETE FROM replacement WHERE onLeaveTeacher='" + id + "' AND subjectCode='" + code + "'";
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
     
    public static int deleteOnLeaveTeacher(String id) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "DELETE FROM replacement WHERE onLeaveTeacher='" + id + "'";
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
    
    public static int findReplacementTeacherByTeacherID(String id) throws SQLException {
        int result = 0;
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            connection = MySQL.getConnection();
            String mySqlQuery = "SELECT * FROM replacement WHERE replacementTeacher='" + id + "'";
            stmt = connection.prepareStatement(mySqlQuery);
            rs = stmt.executeQuery();
            
            if(rs.next()) {
                result++;
            }
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
    
}
