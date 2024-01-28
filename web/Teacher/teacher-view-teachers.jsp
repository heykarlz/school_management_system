<%-- 
    Document   : admin-manage-teachers
    Created on : 1 Jun 2022, 10:06:01 am
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.StudentDAO"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="teacher-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher | View Teachers</title>
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
            
            #nav_teachers {
                color: white;
                font-weight: bold;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
    <div class="container mt-5">        
        <%
            List<Teacher> teacherList = new ArrayList<>();            
            teacherList = TeacherDAO.findAllTeachers();                                                                                                        
            
            for(int i = 0; i < teacherList.size(); i++) {
                out.print("<form action='../TeacherController' method='post' id='my_form" + (i+1) + "'></form>");
            }
        %>
                <div class="card-body ">
                    <h5 class="card-header text-center">Teacher List</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col">NO</th>
                                <th scope="col">TEACHER ID</th>
                                <th scope="col">TEACHER NAME</th>
                                <th scope="col">TEACHER EMAIL</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(teacherList.size() > 0) {
                                        for(int i = 0; i < teacherList.size(); i++) {
                                            out.print("<tr>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' form='my_form" + (i+1) + "' value='" + (i+1) + "'/>");
                                            out.print("<scope='row'>" + (i + 1) + "</td>");
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='teacherID' form='my_form" + (i+1) + "' value='" + teacherList.get(i).getTeacherID()+  "'/>");
                                            out.print(teacherList.get(i).getTeacherID());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='teacherName' form='my_form" + (i+1) + "' value='" + teacherList.get(i).getTeacherName() + "'/>");
                                            out.print(teacherList.get(i).getTeacherName());
                                            out.print("</td>");
                                            out.print("<td>");
                                            out.print("<input type='hidden' name='teacherEmail' form='my_form" + (i+1) + "' value='" + teacherList.get(i).getTeacherEmail()+  "'/>");
                                            out.print(teacherList.get(i).getTeacherEmail());
                                            out.print("</td>");
                                            out.print("</tr>");
                                       }
                                    } else {
                                         out.print("<tr class='no-register'><td colspan='4'>No registered teachers</td></tr>");
                                    }                     
                                %>                           
                            </tbody>
                       </table>
                 </div>
            </div>
    </body>
</html>
