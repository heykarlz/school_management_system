<%-- 
    Document   : admin-manage-subjects
    Created on : 1 Jun 2022, 11:52:55 am
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Subject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Manage Subjects</title>
        <style>
            .modal-container {
                display: flex;
                justify-content: space-around;
                gap: 25px;
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
            
            #nav_subject {
                color: white;
                font-weight: bold;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">        
        <%
            List<Subject> subjectList = new ArrayList<>();            
            subjectList = SubjectDAO.findAllSubjects();                                                                                                        
            
            for(int i = 0; i < subjectList.size(); i++) {
                out.print("<form action='../SubjectController' method='post' id='my_form" + (i+1) + "'></form>");
            }
        %>
                <div class="card-body ">
                    <button type="button" onclick="window.location.href='process-add-subject.jsp'" class="btn btn-flex btn btn-primary mb-3"><b>Add Subject</b></button>
                    <h5 class="card-header">Subject List</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">SUBJECT CODE</th>
                                <th scope="col">SUBJECT TITLE</th>
                                <th scope="col">SUBJECT DURATION</th>
                                <th scope="col">SUBJECT DAY</th>
                                <th scope="col">TEACHER IN CHARGE</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(subjectList.size() > 0) {
                                        for(int i = 0; i < subjectList.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' form='my_form" + (i+1) + "' value='" + (i+1) + "'/>");
                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectCode' form='my_form" + (i+1) + "' value='" + subjectList.get(i).getSubjectCode()+  "'/>");
                                            out.print(subjectList.get(i).getSubjectCode());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectTitle' form='my_form" + (i+1) + "' value='" + subjectList.get(i).getSubjectTitle() + "'/>");
                                            out.print(subjectList.get(i).getSubjectTitle());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectDuration' form='my_form" + (i+1) + "' value='" +  subjectList.get(i).getSubjectDuration()+  "'/>");
                                            out.print(subjectList.get(i).getSubjectDuration() + " Hours");
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectDay' form='my_form" + (i+1) + "' value='" +  subjectList.get(i).getSubjectDay()+  "'/>");
                                            out.print(subjectList.get(i).getSubjectDay());
                                            out.print("</td>");
                                            
                                            Teacher teacher = TeacherDAO.findTeacherBySubjectCode(subjectList.get(i).getSubjectCode());
                                            
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='teacherInCharge' form='my_form" + (i+1) + "' value='" +  teacher.getTeacherName() +  "'/>");
                                            out.print(teacher.getTeacherName());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<div class='modal-container'>");
                                            out.print("<button type='button' class='btn btn-success btn-sm btn-edit btn-flex' onclick=\"window.location.href='process-update-subject.jsp?id=" + subjectList.get(i).getSubjectCode() + "'\"><b>Edit</b></button>");
                                            out.print("<button type='submit' name='action' value='delete' onclick=\"return confirm('Are you sure you want to delete?')\"  class='btn btn-danger btn-sm btn-flex' form='my_form" + (i+1) +"'><b>Delete</b></button>");
                                            out.print("</div>");
                                            out.print("</td>");
                                            out.print("</tr>");
                                       }
                                    } else {
                                         out.print("<tr class='no-register'><td colspan='5'>No registered subjects</td></tr>");
                                    }                     
                                %>                           
                            </tbody>
                       </table>
                 </div>
            </div>                        
    </body>
</html>
