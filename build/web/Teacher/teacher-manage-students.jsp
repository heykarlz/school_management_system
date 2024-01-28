<%-- 
    Document   : teacher-manage-students
    Created on : 15 Jun 2022, 12:48:57 pm
    Author     : Muhammad Haikal Aiman Bin Mohd Puat S59419
--%>


<%@page import="dao.StudentDAO"%>
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
        <title>Teacher | Manage Students</title>
        <style>
            [data-tab-content] {
                display: none;
            }

            .active[data-tab-content] {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
            }

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

            #nav_students {
                color: white;
                font-weight: bold;
            }

            .tabs {
                display: flex;
                justify-content: space-around;
                list-style-type: none;
                margin: 0;
                padding: 0;
                gap: 30px;
            }
        </style>
    </head>
    <body>
        <%
            Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
            List<Student> studentList = new ArrayList<>();
            List<Subject> subjectList = new ArrayList<>();

            //Retrieve the subject assigned to current teacher
            //Param : teacherID
            subjectList = SubjectDAO.findAllSubjectsByTeacherID(teacher.getTeacherID());

            //Print the form based on the size of subjectList (arraylist)
            for (int i = 0; i < subjectList.size(); i++) {
                out.print("<form action='../StudentController' method='POST' id='my_form" + (i + 1) + "'></form>");
            }
        %>
        <div class="container mt-5">    
            <ul class="tabs justify-content-center">
                <%
                    for (int x = 0; x < subjectList.size(); x++) {
                        if (x == 0) {
                            out.print("<button class='btn-tab btn btn-primary'><li class='tab active' name='tab" + x
                                    + "' data-tab-target='#container" + x + "'>" + subjectList.get(x).getSubjectCode() + "</li></button>");
                        } else {
                            out.print("<button class='btn-tab btn btn-outline-primary'><li class='tab' name='tab" + x
                                    + "' data-tab-target='#container" + x + "'>" + subjectList.get(x).getSubjectCode() + "</li></button>");
                        }
                    }
                %>
            </ul> 
            <div class="tab-content">
                <%
                    if (subjectList.size() > 0) {
                        for (int i = 0; i < subjectList.size(); i++) {
                            if (i == 0) {
                                out.print("<div id='container" + i + "' data-tab-content class='active'>");
                            } else {
                                out.print("<div id='container" + i + "' data-tab-content class=''>");
                            }
                            out.print("<div class='card-body'>");
                            out.print("<button type='button' class='btn btn-flex btn btn-primary mb-3' data-toggle='modal' data-target='#subjectModal" + (i + 1) + "'><b>Make Announcement</b></button>");
                            out.print("<h5 class='card-header text-center'>" + subjectList.get(i).getSubjectTitle()
                                    + " (" + subjectList.get(i).getSubjectCode() + ")</h5>");
                            out.print("<table class='table table-striped table-light w-auto'");
                            out.print("<thead class='thead-light'>");
                            out.print("<tr>");
                            out.print("<th scope='col'>NO</th>");
                            out.print("<th scope='col'>STUDENT ID</th>");
                            out.print("<th scope='col'>STUDENT NAME</th>");
                            out.print("<th scope='col'>GENDER</th>");
                            out.print("<th scope='col'>CLASSROOM</th>");
                            out.print("<th scope='col' style='text-align: center;'>ACTION</th>");
                            out.print("</tr>");

                            studentList = StudentDAO.findStudentBySubjectId(subjectList.get(i).getSubjectCode());

                            if (studentList.size() == 0) {
                                out.print("<tr class='no-register'><td colspan='6'>No registered students</td></tr>");
                            }

                            for (int j = 0; j < studentList.size(); j++) {
                                out.print("<td>");
                                out.print("<input type='hidden' form='my_form" + (j + 1) + "' value='" + (j + 1) + "'/>");
                                out.print("<scope='row'>" + (j + 1) + "</td>");
                                out.print("</td>");
                                out.print("<td>");
                                out.print("<input type='hidden' name='studID' form='my_form" + (j + 1) + "' value='" + studentList.get(j).getStudentID() + "'/>");
                                out.print(studentList.get(j).getStudentID());
                                out.print("</td>");
                                out.print("<td>");
                                out.print("<input type='hidden' name='studName' form='my_form" + (j + 1) + "' value='" + studentList.get(j).getStudentName() + "'/>");
                                out.print(studentList.get(j).getStudentName());
                                out.print("</td>");
                                out.print("<td>");
                                out.print("<input type='hidden' name='studGender' form='my_form" + (j + 1) + "' value='" + studentList.get(j).getGender() + "'/>");
                                out.print(studentList.get(j).getGender());
                                out.print("</td>");

                                String classroom = StudentDAO.findClassByClassID(studentList.get(j).getClassID());

                                out.print("<td>");
                                out.print("<input type='hidden' name='studClassroom' form='my_form" + (j + 1) + "' value='" + classroom + "'/>");
                                out.print(classroom);
                                out.print("</td>");
                                out.print("<td>");
                                out.print("<div class='modal-container'>");
                                out.print("<button type='button' class='btn btn-info btn-sm btn-flex' data-toggle='modal' data-target='#exampleModal" + (i + 1) + (j + 1) + "'><b>Details</b></button>");
                                out.print("<button type='button' class='btn btn-success btn-sm btn-edit btn-flex' onclick=\"window.location.href='teacher-update-student.jsp?id=" + studentList.get(j).getStudentID() + "'\"><b>Edit</b></button>");
                                out.print("</div>");
                                out.print("</td>");
                                out.print("</tr>");
                            }
                            out.print("</tbody>");
                            out.print("</table>");
                            out.print("</div>");
                            out.print("</div>");
                        }
                    } else {
                        out.print("<div class='card-body'>");
                        out.print("<h5 class='card-header'>No registered subject</h5>");
                        out.print("<table class='table table-striped table-light w-auto'");
                        out.print("<thead class='thead-light'>");
                        out.print("<tr>");
                        out.print("<th scope='col'>NO</th>");
                        out.print("<th scope='col'>STUDENT ID</th>");
                        out.print("<th scope='col'>STUDENT NAME</th>");
                        out.print("<th scope='col'>GENDER</th>");
                        out.print("<th scope='col'>CLASSROOM</th>");
                        out.print("<th scope='col' style='text-align: center;'>ACTION</th>");
                        out.print("</tr>");
                        out.print("<tr class='no-register'><td colspan='6'>No registered students</td></tr>");
                        out.print("</div>");
                    }
                %>                           
            </div>
        </div>
        <%
            for (int t = 0; t < subjectList.size(); t++) {
                studentList = StudentDAO.findStudentBySubjectId(subjectList.get(t).getSubjectCode());
                for (int i = 0; i < studentList.size(); i++) {
                    out.println("<div  class='modal fade' id='exampleModal" + (t + 1) + (i + 1) + "' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel" + (i + 1) + "' aria-hidden='true'>");
                    out.println("<div class='modal-dialog' role='document'>");
                    out.println("<div class='modal-content'>");
                    out.println("<div class='modal-header'>");
                    out.println("<h5 class='modal-title' id='exampleModalLabel" + (t + 1) + (i + 1) + "'>Student Details</h5>");
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
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getStudentPassword() + "'><br>");
                    out.println("<label><b>Student Gender</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getGender() + "'><br>");
                    out.println("<label><b>Guardian Number</b></label>");
                    out.println("<input type='text' disabled placeholder='" + studentList.get(i).getGuardianNum() + "'><br>");

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
            }
        %>

        <%
            for (int i = 0; i < subjectList.size(); i++) {
                out.println("<div  class='modal fade' id='subjectModal" + (i + 1) + "' tabindex='-1' role='dialog' aria-labelledby='subjectModalLabel" + (i + 1) + "' aria-hidden='true'>");
                out.println("<div class='modal-dialog' role='document'>");
                out.println("<div class='modal-content'>");
                out.println("<div class='modal-header'>");
                out.println("<h5 class='modal-title' id='subjectModalLabel" + (i + 1) + "'>Announcement Details</h5>");
                out.println("<button type='button' class='close' data-dismiss='modal' aria-label='Close'>");
                out.println("<span aria-hidden='true'>&times;</span>");
                out.println("</button>");
                out.println("</div>");
                out.println("<form action='../SubjectController?action=announce' method='POST' id='form" + (i + 1) +"'>");
                out.println("<div class='modal-body'>");
                out.println("<label><b>Subject ID</b></label>");
                out.println("<input type='text' disabled placeholder='" + subjectList.get(i).getSubjectCode() + "'><br>");
                out.println("<input type='hidden' name='subjectID' value='" + subjectList.get(i).getSubjectCode() + "' form='form" + (i+1) + "'><br>");
                out.println("<label><b>Announcement Message</b></label>");
                out.println("<input type='text' form='form" + (i+1) + "' name='message' placeholder='Type your message'><br>");
                out.println("</div>");
                out.println("<div class='modal-footer" + "'>");
                out.println("<button type='submit' class='btn btn-success' form='form" + (i+1) + "'>Save</button>");
                out.println("<button type='button' class='btn btn-danger' data-dismiss='modal'>Close</button>");
                out.println("</div>");
                out.println("</div>");
                out.println("</form>");
                out.println("</div>");
                out.println("</div>");
            }
        %>
        <script>
            const tabs = document.querySelectorAll('[data-tab-target]');
            const tabContents = document.querySelectorAll('[data-tab-content]');
            const buttons = document.querySelectorAll('.btn-tab');
            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    const target = document.querySelector(tab.dataset.tabTarget);
                    tabContents.forEach(tabContent => {
                        tabContent.classList.remove('active');
                    });
                    tabs.forEach(tab => {
                        tab.classList.remove('active');
                    });
                    tab.classList.add('active');
                    target.classList.add('active');
                });

                buttons.forEach(btn => {
                    btn.addEventListener('click', () => {
                        buttons.forEach(btn => {
                            if (btn.classList.contains('btn-primary')) {
                                btn.classList.remove('btn-primary');
                                btn.classList.add('btn-outline-primary');
                            }
                        });

                        if (btn.classList.contains('btn-outline-primary')) {
                            btn.classList.remove('btn-outline-primary');
                            btn.classList.add('btn-primary');
                        } else if (btn.classList.contains('btn-primary')) {
                            btn.classList.remove('btn-primary');
                            btn.classList.remove('btn-outline-primary');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
