package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
*/
public class MySQL {
    
    public static Connection getConnection() throws SQLException {
        Connection myConnection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://localhost:3306/school_registration";
            String user = "";
            String password = "";

            // create a connection to the database
            myConnection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        } 
        return myConnection;
    }
    
    public static void closeConnection(Connection connection, PreparedStatement statement, ResultSet resultSet) throws SQLException {
       connection.close();
       statement.close();
       resultSet.close();
    }
}
