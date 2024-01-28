<%-- 
    Document   : teacher-navbar
    Created on : 1 Jun 2022, 6:12:15 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../Student/bootstrap.jsp"/>
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
            Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
        %>
        <nav class="navbar navbar-expand-md navbar-dark">
             <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" aria-controls="collapsibleNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-md-center" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <a class="navbar-brand" style="pointer-events: none"href="#">
                        <i class="fa-solid fa-chalkboard-user"></i>  Teacher
                    </a>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_teacher' href="teacher-homepage.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_schedule'  href="teacher-manage-schedule.jsp">Schedule</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_students'  href="teacher-manage-students.jsp">Students</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_teachers'  href="teacher-view-teachers.jsp">Teachers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="modal" data-target="#teacherProfile" href="#"><%=teacher.getTeacherName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"href="../Student/log-out.jsp">Sign Out</a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <div class="modal fade" id="teacherProfile" tabindex="-1" role="dialog" aria-labelledby="teacherProfileLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="teacherProfileLabel">Teacher Details</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                    <label>Teacher ID : </label>
                    <input type="text" disabled placeholder='<%=teacher.getTeacherID()%>'><br><br>
                    <label>Teacher Name : </label>
                    <input type="text" disabled placeholder='<%=teacher.getTeacherName()%>'><br><br>
                    <label>Teacher Email : </label>
                    <input type="text" disabled placeholder='<%=teacher.getTeacherEmail()%>'><br><br>
                    <label>Teacher Password : </label>
                    <input type="password" disabled placeholder='<%=teacher.getTeacherPassword()%>'><br><br>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
    </body>
</html>
