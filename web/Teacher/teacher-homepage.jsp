<%-- 
    Document   : teacher-homepage
    Created on : 1 Jun 2022, 6:08:47 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="model.Student"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="dao.RegistrationDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Teacher"%>
<%@page import="model.Subject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="teacher-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher | Homepage</title>
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
            
            .btn-danger {
                width: 70px;
            }
            
            #nav_teacher {
                color: white;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">        
        <%
            Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
            List<Subject> subjectList = new ArrayList<>();
            List<Teacher> teacherList = new ArrayList<>();
            
            //Retrieve list of all teacher
            teacherList = TeacherDAO.findAllTeachers();
            
            //Retrieve the subject assigned to current teacher
            //Param : teacherID
            subjectList = SubjectDAO.findAllSubjectsByTeacherID(teacher.getTeacherID());  
            
            //Print the form based on the size of subjectList (arraylist)
            for(int i = 0; i < subjectList.size(); i++) {
                out.print("<form action='../TeacherController' method='POST' id='subjectForm" + (i+1) + "'></form>");
            }
        %>
                <div class="card-body ">
                    <h5 class="card-header text-center">Assigned Subject</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">SUBJECT CODE</th>
                                <th scope="col">SUBJECT NAME</th>
                                <th scope="col">SUBJECT DAY</th>
                                <th scope="col">YOUR STATUS</th>
                                <th scope="col">REPLACEMENT TEACHER</th>
                                <th scope="col" style="text-align: center;">ACTION</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(subjectList.size() > 0) {
                                        for(int i = 0; i < subjectList.size(); i++) {
                                            out.println("<tr>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='currentTeacherID' form='subjectForm" + (i+1) + "' value='" + teacher.getTeacherID() + "'/>");
                                            out.println("<scope='row'>" + (i + 1) + "</td>");
                                            out.println("</td>"); 
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='subjectCode' form='subjectForm" + (i+1) + "' value='" + subjectList.get(i).getSubjectCode() + "'/>");
                                            out.println(subjectList.get(i).getSubjectCode());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='subjectTitle' form='subjectForm" + (i+1) + "' value='" + subjectList.get(i).getSubjectCode() + "'/>");
                                            out.println(subjectList.get(i).getSubjectTitle());
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<input type='hidden' name='subjectDay' form='subjectForm" + (i+1) + "' value='" + subjectList.get(i).getSubjectDay() + "'/>");
                                            out.println(subjectList.get(i).getSubjectDay());
                                            out.println("</td>");
                                            
                                            //Check teacher status for the respective subject (Active or On Leave)
                                            int status = TeacherDAO.findTeacherStatus(teacher.getTeacherID(), subjectList.get(i).getSubjectCode());
                                            
                                            out.println("<td>");
                                            //If status > 0, print "On Leave" in red color
                                            if(status > 0) {
                                                out.println("<input type='hidden' name='status' form='subjectForm" + (i+1) + "' value='On Leave'/>");
                                                out.println("<span style='color: red'><b>On Leave</b></span>");
                                            } else {
                                            //Else print "Active" in green color
                                                out.println("<input type='hidden' name='status' form='subjectForm" + (i+1) + "' value='Active'/>");
                                                out.println("<span style='color: green'><b>Active</b></span>");
                                            }
                                            out.println("</td>");
                                            
                                            //Get the replacement teacher for current subject
                                            Teacher teacherRecord = TeacherDAO.findReplacementTeacher(teacher.getTeacherID(), subjectList.get(i).getSubjectCode());
                                            
                                            out.println("<td>");
                                            
                                            //If teacherRecord is null then print "Not applicable"
                                            //Indicated no replacement teacher is assigned for this current subject
                                            //Or teacher is currently active
                                            if(teacherRecord == null) {
                                                out.println("Not applicable");
                                            } else {
                                            //Else print the replacement teacher name
                                                out.println(teacherRecord.getTeacherName());
                                            }
                                            
                                            out.println("</td>");
                                            out.println("<td>");
                                            out.println("<div class='modal-container'>");
                                            out.println("<button type='button' class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i+1) +"'><b>Details</b></button>");
                                            //If status > 0, print the "Cancel" button which allows teacher to cancel the replacement teacher
                                            //Which means teacher status will return back to active
                                            if(status > 0) {
                                                out.println("<button type='submit' name='action' value='cancel' class='btn btn-danger btn-sm btn-flex' form='subjectForm" + (i+1) + "'><b>Cancel</b></button>");
                                            } else {
                                            //Else if status = 0, print the "Manage" button which allow teacher to choose the replacement teacher
                                            //If teacher is to change its status to On Leave
                                                out.println("<button type='button' class='btn btn-success btn-sm btn-flex' data-toggle='modal' data-target='#manageScheduleModal" + (i+1) +"'><b>Manage</b></button>");
                                            }
                                            out.print("</div>");
                                            out.print("</td>");
                                            out.print("</tr>");
                                        }
                                    } else {
                                        out.println("<tr class='no-register'><td colspan='7'>No assigned subject</tr>");
                                    }
                                %>                           
                            </tbody>
                       </table>
                 </div>
            </div>
<!--Modal Box for Subject Details-->
            <%
                for(int i = 0; i < subjectList.size(); i++) {
                    out.println("<div  class='modal fade' id='exampleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog mw-100 w-50' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='exampleModalLabel" + (i+1) +"'>Subject Details</h5>");
                    out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                    out.println("<span aria-hidden='true'>&times;</span>");
                    out.println("</button>");
                    out.println("</div>");
                    out.println("<div class='modal-body'>");
                    out.println("<label><b>List of Registered Student</b></label>");
                    
                    List<Student> studentList = new ArrayList<>();
                    
                    studentList = RegistrationDAO.findRegisteredStudentsBySubjectCode(subjectList.get(i).getSubjectCode());
                    
                    out.println("<ul>");
                    for(int k = 0; k < studentList.size(); k++) {
                        out.println("<li>");
                        out.println(studentList.get(k).getStudentName() + " " + studentList.get(k).getStudentID());
                        out.println("</li>");
                    }
                    out.println("</ul>");
                    
                    if(studentList.isEmpty()) {
                        out.println("No registered students for this subject");
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
<!--Modal Box for Manage Subjects-->
            <%
                for(int i = 0; i < subjectList.size(); i++) {
                    out.println("<div  class='modal fade' id='manageScheduleModal" + (i+1) +"' tabindex='-1' role='dialog' aria-labelledby='manageScheduleModalLabel" + (i+1) +"' aria-hidden='true'>");
                    out.println("<div class='modal-dialog mw-100 w-50' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='manageScheduleModalLabel" + (i+1) +"'>Manage Subject</h5>");
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
                    out.println("<input type='text' class='form-control' readonly value='" + subjectList.get(i).getSubjectCode() + "'>");
                    out.println("<input type='hidden' name='subjectID' value='" + subjectList.get(i).getSubjectCode() + "' form='my_form" + (i+1) + "'>");
                    out.println("</div>");
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Subject Code</label>");
                    out.println("</div>");
                    out.println("<input type='text' class='form-control' readonly value='" + subjectList.get(i).getSubjectTitle() + "'>");
                    out.println("</div>");
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Current Teacher</label>");
                    out.println("</div>");
                    out.println("<input type='text' readonly class='form-control' value='" + teacher.getTeacherName() + "'>");
                    out.println("<input type='hidden' name='currentTeacherID' value='" + teacher.getTeacherID() + "' form='my_form" + (i+1) + "'>");
                    out.println("</div>");
                    out.println("<div class='input-group mb-4 mt-1'>");
                    out.println("<div class='input-group-prepend'>");
                    out.println("<label class='input-group-text text-dark' for='id'>Replacement Teacher</label>");
                    out.println("</div>");
                    out.println("<select class='form-control' for='replacementTeacher' name='replacementTeacher' form='my_form" + (i+1) + "'>");
                    
                    for(int j = 0; j < teacherList.size(); j++) {
                        if(teacherList.get(j).getTeacherID().equals(teacher.getTeacherID())) {
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
                    out.println("<button type='submit' name='action' value='replace' class='btn btn-success' form='my_form" + (i+1) + "'>Save</button>");
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

