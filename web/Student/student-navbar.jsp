<%-- 
    Document   : navbar
    Created on : 25 Apr 2022, 3:57:22 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.StudentDAO"%>
<%@page import="model.Classroom"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="model.Teacher"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="bootstrap.jsp"/>
<html>
    <head>
        <style>
            nav {
                background-color: #2A58AD;
            }
            
            input {
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%
            Student student = (Student) request.getSession().getAttribute("student");
            String classroom = StudentDAO.findClassByClassID(student.getClassID());
        %>
        <nav class="navbar navbar-expand-md navbar-dark">
             <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" aria-controls="collapsibleNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-md-center" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <a class="navbar-brand" style="pointer-events: none"href="#">
                        <i class="fa-solid fa-graduation-cap"></i>   Student
                    </a>

                    <li class="nav-item">
                        <a class="nav-link" id='nav_home' href="student-homepage.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_subjects'  href="student-registered-subject.jsp">Subjects</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_schedule'  href="student-schedule.jsp">Schedule</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="modal" data-target="#studentProfile" href="#"><%=student.getStudentName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="log-out.jsp">Sign Out</a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <div class="modal fade" id="studentProfile" tabindex="-1" role="dialog" aria-labelledby="studentProfileLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="studentProfileLabel">Student Details</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                    <label>Student ID : </label>
                    <input type="text" disabled placeholder='<%=student.getStudentID()%>'><br><br>
                    <label>Student Name : </label>
                    <input type="text" disabled placeholder='<%=student.getStudentName()%>'><br><br>
                    <label>Student Class : </label>
                    <input type="text" disabled placeholder='<%=classroom%>'><br><br>
                    <label>Student Password : </label>
                    <input type="password" disabled placeholder='<%=student.getStudentPassword()%>'><br><br>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
    </body>
</html>
