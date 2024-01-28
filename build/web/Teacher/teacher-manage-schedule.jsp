<%-- 
    Document   : teacher-manage-schedule
    Created on : 1 Jun 2022, 9:01:51 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.TeacherDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Subject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Teacher"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="teacher-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Teacher | Manage Schedule</title>
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
            Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");
            List<Subject> subjectList = new ArrayList<>();
            
            //Declare a string array of days
            String[] day = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
            
            //Retrieve a list of subject assigned to current teacher 
            //param : teacherID
            subjectList = SubjectDAO.findAllSubjectsByTeacherID(teacher.getTeacherID());  
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
                                            
                                            //Iterate over the subject list
                                            for(int k = 0; k < subjectList.size(); k++) {
                                            
                                                //Check for the current status of teacher for the respective subject
                                                int status = TeacherDAO.findTeacherStatus(teacher.getTeacherID(), subjectList.get(k).getSubjectCode());
                                                
                                                //If the current subject day equal the current day (from the string array)
                                                //Enter the if loop
                                                if(subjectList.get(k).getSubjectDay().equals(str)) {
                                                    
                                                    //If counter is not 0 then print comma (indicates multiple subject on same day)
                                                    if(counter != 0) {
                                                        out.print(", ");
                                                    }
                                                    
                                                    //If status > 0 print the subject in red color (indicates teacher on leave for that subject)
                                                    if(status > 0) {
                                                        out.println("<span style='color: red'><b>" + subjectList.get(k).getSubjectTitle() + "</b></span>");
                                                    } else {
                                                    //Else print it as black color
                                                        out.println("<b>" + subjectList.get(k).getSubjectTitle() + "</b>");
                                                    }
                                                    counter++;
                                                }
                                            }
                                            
                                            //If counter = 0, means the teacher has no assigned subject on that day
                                            if(counter == 0) {
                                                out.print("No scheduled subject on this day");
                                            }
                                            out.print("</td>");
                                            out.print("</tr>");
                                        }
                                   %>                           
                            </tbody>
                       </table>                           
                </div>
                <div>
                     *Subject in red is currently replaced by replacement teacher           
                </div>
        </div>
    </body>
</html>
