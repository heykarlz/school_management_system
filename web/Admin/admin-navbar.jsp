<%-- 
    Document   : admin-navbar
    Created on : 31 May 2022, 10:41:44 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>
<%@page import="model.Admin"%>
<%@page import="dao.StudentDAO"%>
<%@page import="model.Classroom"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="model.Teacher"%>
<%@page import="model.Student"%>
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
            Admin admin = (Admin) request.getSession().getAttribute("admin");
        %>
        <nav class="navbar navbar-expand-md navbar-dark">
             <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar" aria-controls="collapsibleNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-md-center" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <a class="navbar-brand" style="pointer-events: none"href="#">
                        <i class="fa-solid fa-user-pen"></i>   Admin
                    </a>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_student' href="admin-manage-students.jsp">Students</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_teacher'  href="admin-manage-teachers.jsp">Teachers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_subject'  href="admin-manage-subjects.jsp">Subjects</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_replacement'  href="admin-replacement-list.jsp">Replacement</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id='nav_statistics'  href="admin-manage-statistics.jsp">Statistics</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="modal" data-target="#adminProfile" href="#"><%=admin.getAdminName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"href="../Student/log-out.jsp">Sign Out</a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <div class="modal fade" id="adminProfile" tabindex="-1" role="dialog" aria-labelledby="adminProfileLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="adminProfileLabel">Admin Details</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                    <label>Admin ID : </label>
                    <input type="text" disabled placeholder='<%=admin.getAdminID()%>'><br><br>
                    <label>Admin Name : </label>
                    <input type="text" disabled placeholder='<%=admin.getAdminName()%>'><br><br>
                    <label>Admin Email : </label>
                    <input type="text" disabled placeholder='<%=admin.getAdminEmail()%>'><br><br>
                    <label>Admin Password : </label>
                    <input type="text" disabled placeholder='<%=admin.getAdminPassword()%>'><br><br>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>
    </body>
</html>
