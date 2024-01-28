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
import dao.TeacherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Subject;
import model.Teacher;

public class TeacherController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String action = request.getParameter("action");
        
        if (action != null){
            switch(action){
                case "register":
                    registerTeacher(request, response);
                    break;
                    
                case "update":
                    updateTeacher(request, response);
                    break;
                
                case "delete":
                    deleteTeacher(request, response);
                    break;
                    
                case "replace":
                    replaceTeacher(request, response);
                    break;
                    
                case "cancel":
                    cancelReplacementTeacher(request, response);
                    break;
                    
                case "updateReplacement":
                    updateReplacementTeacher(request, response);
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
            Logger.getLogger(TeacherController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TeacherController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void registerTeacher(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        PrintWriter out = response.getWriter();
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String pw = request.getParameter("password");
        String email = request.getParameter("email");
        
        Teacher teacher = new Teacher(id, pw, name, email);
        
        int status = TeacherDAO.add(teacher);
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"New teacher record registered successfully!\")");
            out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in registering new teacher record\")");
            out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
            out.println("</script>");
        }
    }

    private void updateTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String pw = request.getParameter("password");
        String email = request.getParameter("email");
        
        Teacher teacher = new Teacher(id, pw, name, email);
        
        int status = TeacherDAO.update(teacher);
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"New teacher record is updated successfully!\")");
            out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in updating new teacher record\")");
            out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
            out.println("</script>");
        }
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("teacherID");       
        List<Subject> subjectList = new ArrayList<>();
        
        int status = TeacherDAO.findReplacementTeacherByTeacherID(id);//Find if teacher is currently assigned as replacement teacher

        //If status = 0, then proceed to delete the teacher record
        if(status == 0) {
            subjectList = SubjectDAO.findAllSubjectsByTeacherID(id);//Find if teacher is currently assigned with any subject.
            
            //If no then proceed to delete the teacher record
            if(subjectList.size() == 0) {
                int status2 = TeacherDAO.deleteOnLeaveTeacher(id);//delete teacher record in Replacement table if teacher is currently on leave
                int status3 = TeacherDAO.delete(id); //delete teacher in Teacher table
                    if (status3 > 0) {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert (\"Teacher record deleted successfully\")");
                        out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
                        out.println("</script>");
                    } else {
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert (\"Failure in deleting teacher record\")");
                        out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
                        out.println("</script>");
                    }
            //If yes then display error message to ask admin to update the position of to-be-deleted teacher with new teacher
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"This teacher is currently assigned with an active subject. Please update the subject with new teacher first.\")");
                out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
                out.println("</script>");
            }
        //If more than 0 then display error message to ask admin to update the position of to-be-deleted teacher with new replacement teacher    
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"This teacher is currently assigned as replacement teacher. Please update the position with new teacher first\")");
            out.println("window.location.href = './Admin/admin-manage-teachers.jsp';");
            out.println("</script>");
        }
    }

    private void replaceTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        String currentTeacherID = request.getParameter("currentTeacherID");
        String replacementTeacherID = request.getParameter("replacementTeacher");
        String subjectID = request.getParameter("subjectID");
        String confirm = request.getParameter("status");
        
        if(confirm.equals("Yes")) {
            int status = TeacherDAO.addReplacementTeacher(currentTeacherID, replacementTeacherID, subjectID);
                if (status > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Replacement teacher record added successfully\")");
                out.println("window.location.href = './Teacher/teacher-homepage.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in adding replacement teacher record\")");
                out.println("window.location.href = './Teacher/teacher-homepage.jsp';");
                out.println("</script>");
            }
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Cancel teacher replacement\")");
            out.println("window.location.href = './Teacher/teacher-homepage.jsp';");
            out.println("</script>");
        }
    }

    private void cancelReplacementTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        String id = request.getParameter("currentTeacherID");
        String code = request.getParameter("subjectCode");
        
        int status = TeacherDAO.deleteReplacementTeacher(id, code);
        
        if (status > 0) {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Replacement teacher record deleted successfully\")");
            out.println("window.location.href = './Teacher/teacher-homepage.jsp';");
            out.println("</script>");
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Failure in deleting replacement teacher record\")");
            out.println("window.location.href = './Teacher/teacher-homepage.jsp';");
            out.println("</script>");
        }
    }

    private void updateReplacementTeacher(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        PrintWriter out = response.getWriter();
        String currentTeacherID = request.getParameter("currentTeacherID");
        String replacementTeacherID = request.getParameter("replacementTeacher");
        String subjectID = request.getParameter("subjectID");
        String confirm = request.getParameter("status");
        
        if(confirm.equals("Yes")) {
            int status = TeacherDAO.updateReplacementTeacher(currentTeacherID, replacementTeacherID, subjectID);
                if (status > 0) {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Replacement teacher record updated successfully\")");
                out.println("window.location.href = './Admin/admin-replacement-list.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert (\"Failure in updating replacement teacher record\")");
                out.println("window.location.href = './Admin/admin-replacement-list.jsp';");
                out.println("</script>");
            }
        } else {
            out.println("<script type=\"text/javascript\">");
            out.println("alert (\"Cancel updating teacher replacement\")");
            out.println("window.location.href = './Admin/admin-replacement-list.jsp';");
            out.println("</script>");
        }
    }

}
