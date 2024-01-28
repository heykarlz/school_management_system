<%-- 
    Document   : process-subject
    Created on : 27 May 2022, 5:22:45 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.RegistrationDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="bootstrap.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap");
            .swal2-popup {
                font-family: "Poppins", sans-serif;
            }
        </style>
    </head>
    <body>
        <%
            //Get the student object
            Student student = (Student) request.getSession().getAttribute("student");
            
            //Retrieve the value of element with the name action from "student-registered-subject.jsp"
            String action = request.getParameter("action");
            
            String code = "";
            String subjName = "";
            int result;
            
            //If action value is "add"
            if(action.equals("add")) {
                //Retrieve the value of element 'subjectCode'
                code = request.getParameter("subjectCode");
                //Find the subject name using subjectDAO
                //param : subjectCode 
                //return: subjectName
                subjName = SubjectDAO.findSubjectNameBySubjectCode(code);
            }
        %>
        <script>
            var name = "<%=subjName%>";//declare a JavaScript variable and pass it the value of subjectName
        </script> 
        <%
            switch (action) {
                    //If action value is "add"
                    case "add":
                        //Check if code is null
                        //If yes, then it indicates that subject has already been registered
                        if(code == null) {
                            out.println("<script>");
                            out.println("alert('Subject has already been registered')");
                            out.print("location=history.back()");
                            out.print("</script>");
                        }
                        
                        //Add the pair of current subject and studentID to Registration table in database using RegistrationDAO
                        //param : studentID, subjectCode
                        //return : result (int) ->  more than 0 = success, equal to 0 = fail
                        result = RegistrationDAO.add(student.getStudentID(), code);
                        
                        //If insertion to database is successfull and code is not null
                        //Display successful message
                        if(result > 0 && code != null) {
                            out.println("<script type='text/javascript'>");
                            out.println("Swal.fire({"
                            + "icon: 'success',"
                            + "title: 'Successful',"
                            + "text:'You have successfully register for the subject '+ name + ' !',"
                            + "confirmButtonText: 'Back to Homepage!',"
                            + "}).then((result) => {");
                            out.print("if (result.isConfirmed){window.location.href = 'student-homepage.jsp'}})");
                            out.print("</script>");
                        } else {
                        //Else display error message
                            out.println("<script type='text/javascript'>");
                            out.println("Swal.fire({"
                            + "icon: 'error',"
                            + "title: 'Error',"
                            + "text: 'Subject has already been registered!',"
                            + "confirmButtonText: 'Back to Homepage!',"
                            + "}).then((result) => {");
                            out.print("if (result.isConfirmed){window.location.href = 'student-homepage.jsp'}})");
                            out.print("</script>");
                        }
                        break;
                    //If action value is "deleteOne"    
                    case "deleteOne":
                        
                        //Retrieve the value of element 'subjectCode'
                        code = request.getParameter("subjectCode");
                        //Pass the pair of [code and current student id] to delete the record from registration table
                        result = RegistrationDAO.delete(student.getStudentID(), code);
                        
                        //If deletion to database is successfull
                        //Display successful message
                        if(result > 0) {
                            out.println("<script type='text/javascript'>");
                            out.println("Swal.fire({"
                            + "icon: 'success',"
                            + "title: 'Successful',"
                            + "text: 'You have successfully drop the  subject',"
                            + "confirmButtonText: 'Back to Homepage!',"
                            + "}).then((result) => {");
                            out.print("if (result.isConfirmed){window.location.href = 'student-registered-subject.jsp'}})");
                            out.print("</script>");
                        } else {
                            out.println("<script type='text/javascript'>");
                            out.println("Swal.fire({"
                            + "icon: 'error',"
                            + "title: 'Error',"
                            + "text: 'Subject cannot be dropped (possibly null)',"
                            + "confirmButtonText: 'Back to Homepage!',"
                            + "}).then((result) => {");
                            out.print("if (result.isConfirmed){window.location.href = 'student-registered-subject.jsp'}})");
                            out.print("</script>");
                        }
                        break;
                    //If action value is "deleteAll"     
                    case "deleteAll": 
                        
                        //Pass the studentID to delete the record of all subject containing the id from registration table
                        result = RegistrationDAO.deleteAll(student.getStudentID());

                        //If deletion to database is successfull
                        //Display successful message
                        if(result > 0) {
                            out.println("<script type='text/javascript'>");
                            out.println("Swal.fire({"
                            + "icon: 'success',"
                            + "title: 'Successful',"
                            + "text: 'You have successfully drop ALL subject',"
                            + "confirmButtonText: 'Back to Homepage!',"
                            + "}).then((result) => {");
                            out.print("if (result.isConfirmed){window.location.href = 'student-registered-subject.jsp'}})");
                            out.print("</script>");
                        } else {
                            out.println("<script type='text/javascript'>");
                            out.println("Swal.fire({"
                            + "icon: 'error',"
                            + "title: 'Error',"
                            + "text: 'Subjects cannot be dropped (possibly null)',"
                            + "confirmButtonText: 'Back to Homepage!',"
                            + "}).then((result) => {");
                            out.print("if (result.isConfirmed){window.location.href = 'student-registered-subject.jsp'}})");
                            out.print("</script>");
                        }
                        break;
                }
        %>                              
    </body>
</html>
