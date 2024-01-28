<%-- 
    Document   : admin-manage-students
    Created on : 31 May 2022, 10:41:05 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.StudentDAO"%>
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
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Manage Students</title>
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
            
            .btn-edit {
                width: 60px;
            }
            
            .no-register td {
                color: black;
                background-color: #FDFDFE;
                text-align: center;
            }
            
            #nav_student {
                color: white;
                font-weight: bold;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">        
        <%
            List<Student> studentList = new ArrayList<>();            
            studentList = StudentDAO.findAllStudents();                                                                                                        
            
            for(int i = 0; i < studentList.size(); i++) {
                out.print("<form action='../StudentController' method='post' id='my_form" + (i+1) + "'></form>");
            }
        %>
                <div class="card-body ">
                    <button type="button" onclick="window.location.href='process-add-student.jsp'" class="btn btn-flex btn btn-primary mb-3"><b>Add Student</b></button>
                    <h5 class="card-header">Student List</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">STUDENT ID</th>
                                <th scope="col">STUDENT NAME</th>
                                <th scope="col">GENDER</th>
                                <th scope="col">CLASSROOM</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(studentList.size() > 0) {
                                        for(int i = 0; i < studentList.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' form='my_form" + (i+1) + "' value='" + (i+1) + "'/>");
                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='studID' form='my_form" + (i+1) + "' value='" + studentList.get(i).getStudentID()+  "'/>");
                                            out.print(studentList.get(i).getStudentID());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='studName' form='my_form" + (i+1) + "' value='" + studentList.get(i).getStudentName() + "'/>");
                                            out.print(studentList.get(i).getStudentName());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='studGender' form='my_form" + (i+1) + "' value='" + studentList.get(i).getGender()+  "'/>");
                                            out.print(studentList.get(i).getGender());
                                            out.print("</td>");

                                            String classroom = StudentDAO.findClassByClassID(studentList.get(i).getClassID());

                                            out.print("<td>");
                                            out.print("<input type='hidden' name='studClassroom' form='my_form" + (i+1) + "' value='" + classroom + "'/>");
                                            out.print(classroom);
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<div class='modal-container'>");
                                            out.print("<button type='button' class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b>Details</b></button>");
                                            out.print("<button type='button' class='btn btn-success btn-sm btn-edit btn-flex' onclick=\"window.location.href='process-update-student.jsp?id=" + studentList.get(i).getStudentID() + "'\"><b>Edit</b></button>");
                                            out.print("<button type='submit' name='action' value='delete' onclick=\"return confirm('Are you sure you want to delete?')\" class='btn btn-danger btn-sm btn-flex' form='my_form" + (i+1) +"'><b>Delete</b></button>");
                                            out.print("</div>");
                                            out.print("</td>");
                                            out.print("</tr>");
                                       }
                                    } else {
                                         out.print("<tr class='no-register'><td colspan='6'>No registered students</td></tr>");
                                    }                     
                                %>                           
                            </tbody>
                       </table>
                 </div>
            </div>                        
            <!--Modal Box-->
            <%
                for(int i = 0; i < studentList.size(); i++) {
                    out.println("<div  class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Student Details</h5>");
                    out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.println("<span aria-hidden='true'>&times;</span>");
                    out.println("</button>");
                    out.println("</div>");
                    out.println("<div class='modal-body'>");
                    out.println("<label><b>Student ID</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getStudentID() + "'><br>");
                    out.println("<label><b>Student Name</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getStudentName() + "'><br>");
                    out.println("<label><b>Student Password</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getStudentPassword()+ "'><br>");
                    out.println("<label><b>Student Gender</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getGender() + "'><br>");
                    out.println("<label><b>Guardian Number</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getGuardianNum()+ "'><br>");
                    
                    String classroom = StudentDAO.findClassByClassID(studentList.get(i).getClassID());
                    
                    out.println("<label><b>Classroom Name</b></label>");
                    out.println("<input type='text' disabled placeholder='" + classroom + "'><br>");
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

