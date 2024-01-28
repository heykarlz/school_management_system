<%-- 
    Document   : admin-replacement-list
    Created on : 2 Jun 2022, 10:45:57 am
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Subject"%>
<%@page import="model.Subject"%>
<%@page import="model.Teacher"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="model.Replacement"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Manage Replacement</title>
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

            .input-group-prepend {
                width : 25%; /*adjust as needed*/
             }

             .input-group-prepend label {
                width: 100%;
                overflow: hidden;
              }
            
            select.form-control {
                -webkit-appearance: menulist;
            }
            
            #nav_replacement {
                color: white;
                font-weight: bold;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">        
        <%
            List<Replacement> replacementList = new ArrayList<>();            
            replacementList = TeacherDAO.findAllReplacementTeacher();                                                                                                        
        %>
                <div class="card-body ">
                    <h5 class="card-header">Replacement Teacher Schedule</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">ON LEAVE TEACHER</th>
                                <th scope="col">REPLACEMENT TEACHER</th>
                                <th scope="col">SUBJECT ID</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(replacementList.size() > 0) {
                                        for(int i = 0; i < replacementList.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' value='" + (i+1) + "'/>");
                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='onLeaveTeacherID' value='" + replacementList.get(i).getOnLeaveTeacherID()+  "'/>");
                                            
                                            Teacher onLeaveTeacher = TeacherDAO.findTeacherByTeacherId(replacementList.get(i).getOnLeaveTeacherID());
                                            
                                            out.print(onLeaveTeacher.getTeacherName());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='replacementTeacherID' value='" + replacementList.get(i).getReplacementTeacherID() + "'/>");
                                            
                                            Teacher replacementTeacher = TeacherDAO.findTeacherByTeacherId(replacementList.get(i).getReplacementTeacherID());
                                            
                                            out.print(replacementTeacher.getTeacherName());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='subjectID' value='" + replacementList.get(i).getSubjectID() +  "'/>");
                                            
                                            String subject = SubjectDAO.findSubjectNameBySubjectCode(replacementList.get(i).getSubjectID());
                                            
                                            out.print(subject);
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<div class='modal-container'>");
                                            out.println("<button type='button' class='btn btn-success btn-sm btn-flex' data-toggle='modal' data-target='#manageScheduleModal" + (i+1) +"'><b>Manage</b></button>");
                                            out.print("</div>");
                                            out.print("</td>");
                                            out.print("</tr>");
                                       }
                                    } else {
                                         out.print("<tr class='no-register'><td colspan='5'>No scheduled replacement teachers</td></tr>");
                                    }                     
                                %>                           
                            </tbody>
                       </table>
                 </div>
            </div>
    <!--Modal Box for Manage Subjects-->
            <%              
                List<Teacher> teacherList = new ArrayList<>();
                teacherList = TeacherDAO.findAllTeachers();
                
                for(int i = 0; i < replacementList.size(); i++) {
                    out.println("<div  class='modal fade' id='manageScheduleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='manageScheduleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog mw-100 w-50' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='manageScheduleModalLabel" + (i+1) +"'>Manage Replacement Teacher</h5>");
                    out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.println("<span aria-hidden='true'>&times;</span>");
                    out.println("</button>");
                    out.println("</div>");
                    out.println("<div class='modal-body'>");
                    out.println("<form action='../TeacherController?action=replace' id='my_form" + (i+1) + "'></form>");
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Subject Code</label>");
                    out.println("</div>");
                    out.println("<input type='text' class='form-control' readonly value='" + replacementList.get(i).getSubjectID() + "'>");
                    out.println("<input type='hidden' name='subjectID' value='" + replacementList.get(i).getSubjectID() + "' form='my_form" + (i+1) + "'>");
                    out.println("</div>");
                    
                    String subjectTitle = SubjectDAO.findSubjectNameBySubjectCode(replacementList.get(i).getSubjectID());
                    
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Subject Code</label>");
                    out.println("</div>");
                    out.println("<input type='text' class='form-control' readonly value='" + subjectTitle + "'>");
                    out.println("</div>");
                    
                    Teacher onLeaveTeacher = TeacherDAO.findTeacherByTeacherId(replacementList.get(i).getOnLeaveTeacherID());
                    
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Current Teacher</label>");
                    out.println("</div>");
                    out.println("<input type='text' readonly class='form-control' value='" + onLeaveTeacher.getTeacherName() + "'>");
                    out.println("<input type='hidden' name='currentTeacherID' value='" + replacementList.get(i).getOnLeaveTeacherID() + "' form='my_form" + (i+1) + "'>");
                    out.println("</div>");
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Replacement Teacher</label>");
                    out.println("</div>");
                    out.println("<select class='form-control' for='replacementTeacher' name='replacementTeacher' form='my_form" + (i+1) + "'>");
                    
                    for(int j = 0; j < teacherList.size(); j++) {
                        if(teacherList.get(j).getTeacherID().equals(onLeaveTeacher.getTeacherID())) {
                           continue;
                        }
                        out.println("<option value='" + teacherList.get(j).getTeacherID() + "'>" + teacherList.get(j).getTeacherName() + "</option>");
                    }
                    
                    out.println("</select>");
                    out.println("</div>");
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='status'>Confirm Replacement</label>");
                    out.println("</div>");
                    out.println("<select class='form-control' for='status' name='status' form='my_form" + (i+1) + "'>");
                    out.println("<option selected value='No'>No</option>");
                    out.println("<option value='Yes'>Yes</option>");
                    out.println("</select>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("<div class='modal-footer" + "'>");
                    out.println("<button type='submit' name='action' value='updateReplacement' class='btn btn-success' form='my_form" + (i+1) + "'>Save</button>");
                    out.println("<button type='button' class='btn btn-info' data-dismiss='modal'>Close</button>");
                    out.println("</div>");
                    out.println("</form>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>");
                }
            %>
    </body>
</html>

