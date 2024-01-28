<%-- 
    Document   : student-schedule
    Created on : 2 Jun 2022, 12:52:14 am
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.RegistrationDAO"%>
<%@page import="model.Registration"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Teacher"%>
<%@page import="java.util.List"%>
<%@page import="model.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="student-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student | Schedule</title>
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
            
            .btn-register {
                width: 88px;
            }
            
            .no-register td {
                color: black;
                background-color: #FDFDFE;
                text-align: center;
            }
            
            #nav_schedule {
                color: white;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">    
        <%
            //May check comments in Teacher/teacher-manage-schedule.jsp, more or less the same
            Student student = (Student) request.getSession().getAttribute("student");
            List<Registration> registrationList = new ArrayList<>();
            List<Subject> subjectList = new ArrayList<>();
            int duration = 0;
            registrationList = RegistrationDAO.findRegisteredSubjectsByStudentID(student.getStudentID());
            
            String[] day = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};  
        %>
                <div class="card-body ">
                    <h5 class="card-header text-center">Schedule</h5>
                        <table class="table table-striped table-light w-auto">
                            <thead class="thead-light">
                                <tr>
                                <th scope="col" class='text-center' style='width: 20%'>DAY</th>
                                <th scope="col" style='width: 80%'><div style='margin-left: 250px;'>SUBJECT NAME</div></th>
                              </tr>
                            </thead>
                            <tbody>
                                    <%
                                        for(int i = 0; i < 5; i++) {
                                            out.print("<tr>");
                                            out.print("<td class='text-center'>");
                                            out.print(day[i]);
                                            out.print("</td>"); 
                                            out.print("<td>");
                                            
                                            String str = day[i];
                                            int counter = 0;
                                            
                                            for(int k = 0; k < registrationList.size(); k++) {
                                            
                                                subjectList = SubjectDAO.findAllSubjectsBySubjectCode(registrationList.get(k).getSubjectCode());
                                            
                                                if(subjectList.get(0).getSubjectDay().equals(str)) {
                                                    if(counter != 0) {
                                                        out.print("<b>,</b> ");
                                                    }
                                                    out.println("<b>" + subjectList.get(0).getSubjectTitle() + "</b>");
                                                    counter++;
                                                    duration += subjectList.get(0).getSubjectDuration();
                                                }
                                            }
                                            
                                            if(counter == 0) {
                                                out.print("No scheduled class on this day");
                                            }
                                            out.print("</td>");
                                            out.print("</tr>");
                                        }
                                   %>                           
                            </tbody>
                       </table>                           
                </div>
                <div class='ml-3'>
                     Total duration is <%=duration%> hours       
                </div>
        </div>
    </body>
</html>

