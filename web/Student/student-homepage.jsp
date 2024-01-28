<%-- 
    Document   : homepage
    Created on : 25 Apr 2022, 2:34:21 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.RegistrationDAO"%>
<%@page import="model.Student"%>
<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.MySQL"%>
<%@page import="model.Registration"%>
<%@page import="model.Subject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="student-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student | Homepage</title>
        <style>
            .modal-container {
                display: flex;
                justify-content: space-around;
            }
            
            body:not(.container) {
                background-color: #EAEEF1;
            }
            
            .card-header, .modal-header {
                background-color: #2A58AD;
                color: white;
            }
            
            th {
                font-size: 16px;
            }
            
            .modal-body input {
                width: 100%;
            }
            
            .btn-register {
                width: 88px;
            }
            
            #nav_home {
                font-weight: bold;
                color: white;
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">        
        <%
            Student student = (Student) request.getSession().getAttribute("student");
            List<Subject> subjectList = new ArrayList<>();
            List<Teacher> teacherList = new ArrayList<>();
            List<Registration> regListPlaceholder = new ArrayList<>();
            List<Registration> regList = new ArrayList<>();
            Teacher teacher = null;
            
            subjectList = SubjectDAO.findAllSubjects();                                                                                                        
            regListPlaceholder = RegistrationDAO.findRegisteredSubjectsByStudentID(student.getStudentID());
            
            for(int i = 0; i < regListPlaceholder.size(); i++) {
                Registration registration = new Registration(regListPlaceholder.get(i).getSubjectCode());
                regList.add(registration);
            }
            
            for(int i = 0; i < subjectList.size(); i++) {
                out.print("<form action='process-subject-registration.jsp' method='POST' id='my_form" + (i + 1) + "'></form>");
                teacher = TeacherDAO.findTeacherBySubjectCode(subjectList.get(i).getSubjectCode());
                teacherList.add(teacher);
            }
        %>
                <div class="card-body ">
                    <h5 class="card-header">Subject Registration</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">SUBJECT CODE</th>
                                <th scope="col">SUBJECT NAME</th>
                                <th scope="col">TEACHER IN CHARGE</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    for(int i = 0; i < subjectList.size(); i++) {
                                        out.print("<tr>");
                                        out.print("<td>");
                                        out.print("<input type='hidden' name='subjectNo' form='my_form" + (i+1) + "' value='" + (i+1) + "'/>");
                                        out.print("<scope='row'>" + (i + 1) + "</td>");
                                        out.print("</td>"); 
                                        out.print("<td>");
                                        out.print("<input type='hidden' name='subjectCode' form='my_form" + (i+1) + "' value='" + subjectList.get(i).getSubjectCode() + "'/>");
                                        out.print(subjectList.get(i).getSubjectCode());
                                        out.print("</td>");
                                        out.print("<td>");
                                        out.print("<input type='hidden' name='subjectTitle' form='my_form" + (i+1) + "' value='" + subjectList.get(i).getSubjectCode() + "'/>");
                                        out.print(subjectList.get(i).getSubjectTitle());
                                        out.print("</td>");
                                        out.print("<td>");
                                        out.print("<input type='hidden' name='teacherName' form='my_form" + (i+1) + "' value='" + teacherList.get(i).getTeacherName() + "'/>");
                                        out.print(teacherList.get(i).getTeacherName());
                                        out.print("</td>");
                                        out.print("<td>");
                                        out.print("<div class='modal-container'>");
                                        out.print("<button type='button' class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b>Details</b></button>");
                                        
                                        int status = RegistrationDAO.findRegisteredSubjectsBySubjectCode(student.getStudentID(), subjectList.get(i).getSubjectCode());
                                        
                                        if(status == 0) {
                                            out.print("<button type='submit' name='action' value='add' form='my_form" + (i+1) + "' class='btn btn-success btn-sm btn-flex btn-register'><b>Register</b></button>");
                                        } else {
                                            out.print("<button type='submit' name='action' value='add' form='my_form" + (i+1) + "' class='btn btn-danger btn-sm btn-flex btn-register'><b>Registered</b></button>");
                                        }
                                        out.print("</div>");
                                        out.print("</td>");
                                        out.print("</tr>");
                                    }
                                %>                           
                            </tbody>
                       </table>
                 </div>
            </div>                        
            <!--Modal Box-->
            <%
                for(int i = 0; i < subjectList.size(); i++) {
                    out.println("<div  class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Subject Details</h5>");
                    out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.println("<span aria-hidden='true'>&times;</span>");
                    out.println("</button>");
                    out.println("</div>");
                    out.println("<div class='modal-body'>");
                    out.println("<label><b>Subject Code</b></label>");
                    out.println("<input type='text' disabled placeholder='" + subjectList.get(i).getSubjectCode() + "'><br>");
                    out.println("<label><b>Subject Name</b></label>");
                    out.println("<input type='text' disabled placeholder='" + subjectList.get(i).getSubjectTitle() + "'><br>");
                    out.println("<label><b>Teacher ID</b></label>");
                    out.println("<input type='text' disabled placeholder='" + teacherList.get(i).getTeacherID() + "'><br>");
                    out.println("<label><b>Teacher Name</b></label>");
                    out.println("<input type='text' disabled placeholder='" + teacherList.get(i).getTeacherName() + "'><br>");
                    out.println("<label><b>Teacher Email</b></label>");
                    out.println("<input type='text' disabled placeholder='" + teacherList.get(i).getTeacherEmail() + "'><br>");
                    out.println("<label><b>Duration</b></label>");
                    out.println("<input type='text' disabled placeholder='" + subjectList.get(i).getSubjectDuration() + " hours per week'><br>");
                    out.println("</div>");
                    out.println("<div class='modal-footer" + "'>");
                    out.println("<button type='button' class='btn btn-info' data-dismiss='modal'>Close</button>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>");
                }
            %>
    </body>
</html>
