/*
 Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
 Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
 Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN

 */
package controller;

import dao.RegistrationDAO;
import dao.StudentDAO;
import database.MySQL;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Admin;
import model.Registration;
import model.Student;
import model.Teacher;

public class StudentController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        
        if (action != null){
            switch(action){
                case "register":
                    saveStudent(request, response);
                    break;
                
                case "login":
                    loginUser(request, response);
                    break;
                    
                case "update":
                    updateStudent(request, response);
                    break;
                
                case "delete":
                    deleteStudent(request, response);
                    break;
                    
                case "signout":
                    signOut(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "index.html");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(StudentController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(StudentController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void saveStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");
        String pw = request.getParameter("password");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String guardianNum = request.getParameter("phoneNumber");
        int classID = Integer.parseInt(request.getParameter("classroom"));
        
        Student student = new Student(id, name, pw, gender, guardianNum, classID);
        
        int status = StudentDAO.add(student);
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"New student record registered successfully!\")");
            out.println("window.location.href = './Admin/admin-manage-students.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in registering new student record\")");
            out.println("window.location.href = './Admin/admin-manage-students.jsp';");
            out.println("</script>");
        }      
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        Connection connection = MySQL.getConnection();

        String role = request.getParameter("role");
        String user_id = request.getParameter("txtID");
        String password = request.getParameter("txtPassword");

        if("student".equals(role)) {
            String querySelectStudent = "SELECT * FROM students WHERE studentID='" + 
                    user_id + "' AND studentPassword='" + password + "'";
            PreparedStatement statement = connection.prepareStatement(querySelectStudent);
            ResultSet rs = statement.executeQuery();
            if(user_id.isEmpty() || password.isEmpty()) {
                out.println("<script>");
                out.println("alert('Please key in your password and username')");
                out.print("location=history.back()");
                out.print("</script>");
            } else if(rs.next()) {
                String id = rs.getString(1);
                String name = rs.getString(2);
                String pw = rs.getString(3);
                String gender = rs.getString(4);
                String guardianNum = rs.getString(5);
                int student_class = rs.getInt(6);

                Student student = new Student(id, name, pw, gender, guardianNum, student_class);
                request.getSession().setAttribute("student", student);
                response.sendRedirect("./Student/student-homepage.jsp");
            } else {
                out.println("<script>");
                out.println("alert('Invalid Username or password')");
                out.print("location=history.back()");
                out.print("</script>");
            }
        } else if("teacher".equals(role)) {
            String querySelectTeacher = "SELECT * FROM teachers WHERE teacherID='" + 
                    user_id + "' AND teacherPassword='" + password + "'";
            PreparedStatement statement = connection.prepareStatement(querySelectTeacher);
            ResultSet rs = statement.executeQuery();
            if(user_id.isEmpty() || password.isEmpty()) {
                out.println("<script>");
                out.println("alert('Please key in your password and username')");
                out.print("location=history.back()");
                out.print("</script>");
            } else if(rs.next()) {
                String id = rs.getString(1);
                String pw = rs.getString(2);
                String name = rs.getString(3);
                String email = rs.getString(4);

                Teacher teacher = new Teacher(id, pw, name, email);
                request.getSession().setAttribute("teacher", teacher);
                response.sendRedirect("./Teacher/teacher-homepage.jsp");     
            } else {
                out.println("<script>");
                out.println("alert('Invalid Username or password')");
                out.print("location=history.back()");
                out.print("</script>");
            }
        } else if("admin".equals(role)) {
            String querySelectCust = "SELECT * FROM admin WHERE adminID='" + 
                    user_id + "' AND adminPassword='" + password + "'";
            PreparedStatement statement = connection.prepareStatement(querySelectCust);
            ResultSet rs = statement.executeQuery();
            if(user_id.isEmpty() || password.isEmpty()) {
                out.println("<script>");
                out.println("alert('Please key in your password and username')");
                out.print("location=history.back()");
                out.print("</script>");
            } else if(rs.next()) {
                String id = rs.getString(1);
                String pw = rs.getString(2);
                String name = rs.getString(3);
                String email = rs.getString(4);

                Admin admin = new Admin(id, pw, name, email);
                request.getSession().setAttribute("admin", admin);
                response.sendRedirect("./Admin/admin-manage-students.jsp");     
            } else {
                out.println("<script>");
                out.println("alert('Invalid Username or password')");
                out.print("location=history.back()");
                out.print("</script>");
            }
        }
    }
    
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String guardianNum = request.getParameter("phoneNumber");
        int classID = Integer.parseInt(request.getParameter("classroom"));
        
        Student student = new Student(id, name, gender, guardianNum, classID);
        
        int status = StudentDAO.update(student);
        String user = request.getParameter("user");
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Student record updated successfully\")");
            if(user.equals("teacher")) {
                out.println("window.location.href = './Teacher/teacher-manage-students.jsp';");
            } else {
                out.println("window.location.href = './Admin/admin-manage-students.jsp';");
            } 
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in updating student record\")");
            if(user.equals("teacher")) {
                out.println("window.location.href = './Teacher/teacher-manage-students.jsp';");
            } else {
                out.println("window.location.href = './Admin/admin-manage-students.jsp';");
            } 
            out.println("</script>");
        }    
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("studID");

        List<Registration> list = RegistrationDAO.findRegisteredSubjectsByStudentID(id);
        int status2 = RegistrationDAO.deleteAll(id);
        if (status2 > 0 || list.isEmpty()) {
            int status = StudentDAO.delete(id);
            if (status > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Student record deleted successfully\")");
                out.println("window.location.href = './Admin/admin-manage-students.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in deleting student record\")");
                out.println("window.location.href = './Admin/admin-manage-students.jsp';");
                out.println("</script>");
            }
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in deleting student record in subject registration table\")");
            out.println("window.location.href = './Admin/admin-manage-students.jsp';");
            out.println("</script>");
        }
    }

    private void signOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().removeAttribute("user");           
        response.sendRedirect("log-in.jsp");
    }

}
