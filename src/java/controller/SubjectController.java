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

import dao.SubjectDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Subject;

public class SubjectController extends HttpServlet {

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
                    registerSubject(request, response);
                    break;
                    
                case "update":
                    updateSubject(request, response);
                    break;
                
                case "delete":
                    deleteSubject(request, response);
                    break;
                    
                case "announce":
                    announceSubject(request, response);
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
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SubjectController.class.getName()).log(Level.SEVERE, null, ex);
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
 

    private void deleteSubject(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("subjectCode");
        
        int status = SubjectDAO.delete(id);
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Subject record is deleted successfully\")");
            out.println("window.location.href = './Admin/admin-manage-subjects.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in deleting subject record\")");
            out.println("window.location.href = './Admin/admin-manage-subjects.jsp';");
            out.println("</script>");
        }
    }

    private void registerSubject(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String teacherID = request.getParameter("teacher");
        String day = request.getParameter("day");
        int duration = Integer.parseInt(request.getParameter("duration"));
        
        String idStatus = SubjectDAO.findSubjectNameBySubjectCode(id);
        Subject subject = new Subject(id, name, duration, day, teacherID);
        
        if(idStatus == null) {
            int status = SubjectDAO.add(subject);
            if (status > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"New subject is registered successfully!\")");
                out.println("window.location.href = './Admin/admin-manage-subjects.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in registering new subject\")");
                out.println("window.location.href = './Admin/admin-manage-subjects.jsp';");
                out.println("</script>");
            } 
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Subject code has already been registered. Please choose other subject code\")");
            out.println("window.location.href = history.back()");
            out.println("</script>");
        }      
    }

    private void updateSubject(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        
        String currentID = request.getParameter("currentID");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String teacherID = request.getParameter("teacher");
        String day = request.getParameter("day");
        int duration = Integer.parseInt(request.getParameter("duration"));
        
        String idStatus = SubjectDAO.findSubjectNameBySubjectCode(id);
        
        Subject subject = new Subject(id, name, duration, day, teacherID);
        
        if(idStatus == null || currentID.equals(id)) {
            int status = SubjectDAO.update(subject, currentID);
            if (status > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Subject is updated successfully!\")");
                out.println("window.location.href = './Admin/admin-manage-subjects.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in updating subject\")");
                out.println("window.location.href = './Admin/admin-manage-subjects.jsp';");
                out.println("</script>");
            } 
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Subject code has already been registered. Please choose other subject code\")");
            out.println("window.location.href = history.back()");
            out.println("</script>");
        }
    }

    private void announceSubject(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        
        String subjectID = request.getParameter("subjectID");
        String message = request.getParameter("message");
        
        int status = SubjectDAO.addMessage(subjectID, message);
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Annoucement record is successfully created\")");
            out.println("window.location.href = './Teacher/teacher-manage-students.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in creating announcement message\")");
            out.println("window.location.href = './Teacher/teacher-manage-students.jsp';");
            out.println("</script>");
        }
    }

}
