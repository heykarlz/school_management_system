<%-- 
    Document   : student-display-subject
    Created on : 26 Apr 2022, 9:30:24 am
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
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.MySQL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Subject"%>
<%@page import="model.Teacher"%>
<%@page import="model.Registration"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="student-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student | Registered Subject</title>
        <style>
            .modal-container, .form-center {
                display: flex;
                justify-content: center;   
            }
            
            .modal-container {
                display: flex;
                justify-content: space-around;
            }
            
            body:not(.container) {
                background-color: #EAEEF1;
            }
            
            .card-header {
                background-color: #2A58AD;
                color: white;
            }
            
            th {
                font-size: 16px;
            }

            .no-register td {
                background-color: #FDFDFE;
                text-align: center;
            }
            
            #nav_subjects {
                font-weight: bold;
                color: white;
            }
        </style>
    </head>
    <body>
        <%
            Student student = (Student) request.getSession().getAttribute("student");
            List<Subject> subjectList = new ArrayList<>();
            List<Teacher> teacherList = new ArrayList<>();
            List<Registration> regList = new ArrayList<>();
            
            //Retrieve the list of all registered subject for current student
            //param : studentID
            //return : result (int) : > 0 Success, = 0 Failure
            regList = RegistrationDAO.findRegisteredSubjectsByStudentID(student.getStudentID());
            
            //Print form based on regList size
            for(int i = 0; i < regList.size(); i++) {
                out.print("<form action='process-subject-registration.jsp' method='POST' id='drop_subject_form" + (i + 1) + "'></form>");
            }
        %>
        <div class="container mt-5">
            <div class="card-body">
                <h5 class="card-header">Registered Subjects</h5>
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
                                    if(regList.size() > 0) {
                                        for(int i = 0; i < regList.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectNo' form='drop_subject_form" + (i+1) + "' value='" + (i+1) + "'/>");
                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectCode' form='drop_subject_form" + (i+1) + "' value='" + regList.get(i).getSubjectCode() + "'/>");
                                            out.print(regList.get(i).getSubjectCode());
                                            out.print("</td>");
                                            
                                            //Retrieve all of the subject information respective to current subject code
                                            //param : subjectCode
                                            //return : Subject (all related variable) -> may check subjects table in database or Subject.java in model package
                                            subjectList = SubjectDAO.findAllSubjectsBySubjectCode(regList.get(i).getSubjectCode());
                                            
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectTitle' form='drop_subject_form" + (i+1) + "' value='" + subjectList.get(0).getSubjectTitle()  + "'/>");
                                            out.print(subjectList.get(0).getSubjectTitle());
                                            out.print("</td>");
                                            
                                            //Retrieve all of the information of teacher assigned to current subject code
                                            //param : subjectCode
                                            //return : Teacher (all related variable) -> may check teachers table in database or Teacher.java in model package
                                            teacherList = TeacherDAO.findAllTeachersBySubjectCode(regList.get(i).getSubjectCode());
                                            
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='teacherName' form='drop_subject_form" + (i+1) + "' value='" + teacherList.get(0).getTeacherName() + "'/>");
                                            out.print(teacherList.get(0).getTeacherName());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<div class='modal-container'>");
                                            out.print("<button type='button' class='btn btn-flex btn-sm btn-info' data-toggle='modal' data-target='#messageModal" + (i + 1) + "'><b>Message</b></button>");
                                            out.print("<button type='submit' name='action' value='deleteOne' form='drop_subject_form" + (i+1) + "' class='btn btn-outline-danger btn-sm'><b>Drop</b></button>");
                                            out.print("</div>");
                                            out.print("</td>");
                                            out.print("</tr>");
                                       }
                                    } else {
                                        out.print("<tr class='no-register'><td colspan='5'>No registered subject</td></tr>");
                                    }                                   
                                %>                        
                          </tbody>
                       </table>
                 </div>
                 <%if(regList.size() > 1){%>
                 <div class="form-center">
                    <form action="process-subject-registration.jsp" method="POST">
                        <button type='submit' name='action' value='deleteAll' class='btn btn-danger btn-sm'><b>Drop All</b></button>             
                    </form>
                </div>
                 <%}%>
            </div>
            <%
                for(int i = 0; i < regList.size(); i++) {
                    out.println("<div  class='modal fade' id='messageModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='messageModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='messageModalLabel" + (i+1) +"'>Subject Details</h5>");
                    out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.println("<span aria-hidden='true'>&times;</span>");
                    out.println("</button>");
                    out.println("</div>");
                    
                    List<String> message = SubjectDAO.findAnnouncement(regList.get(i).getSubjectCode());
                    
                    out.println("<div class='modal-body'>");
                    out.println("<label><b>Message</b></label><br>");
                    
                    if(message.size() != 0) {
                        for(int x = 0; x < message.size(); x++) {
                            out.println("<p>" + message.get(x) + "</p>");
                        }
                    } else {
                        out.print("No message by teacher");
                    }
                   
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
