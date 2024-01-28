<%-- 
    Document   : process-update-subject
    Created on : 1 Jun 2022, 12:14:34 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="model.Subject"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="dao.TeacherDAO"%>
<%@page import="model.Teacher"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  <title>Admin | Update Subject</title>
  <style>
      body {
         background-color: #EAEEF1;
      }
      
      .card {
         min-width: 700px;
         background-color: #fff;
         outline: 5px solid #89CFF0;
         border: none;
         border-radius: 12px
      }
       
      .flex-body {
          display: flex;
          justify-content: space-around;
          flex-wrap: wrap;
      }
            
      .input-group-prepend {
          width : 30%; /*adjust as needed*/
      }

      .input-group-prepend label {
          width: 100%;
          overflow: hidden;
      }
            
      .btn {
          cursor: pointer;
          padding: 10px;
          color: white;
          font-weight: bold;
      }
      
      select.form-control {
          -webkit-appearance: menulist;
      }
                     
      #nav_subject {
          color: white;
          font-weight: bold;
          font-size: 16px;
      }
            
      @media only screen and (max-width: 600px) {
          .card {
             min-width: 0;
             width: auto;
          }
       }
  </style>
</head>
<body>
    <%
        List<Teacher> teacherList = new ArrayList<>();
        List<Subject> subjectList = new ArrayList<>();
        
        //Retrieve all teachers information from teachers table in db
        teacherList = TeacherDAO.findAllTeachers();
        String[] day = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
       
        //Get the value of element with the name id from admin-manage-subjects.jsp
        //Actual variable name is subjectCode
        //But here we shortened it to only 'id', not sure if it's a good practice or not...prolly not
        String id = request.getParameter("id");
        
        //Retrieve all subject information from subjects table in db based on the given id/subjectCode
        //param : id/subjectCode
        subjectList = SubjectDAO.findAllSubjectsBySubjectCode(id);
    %>
  <div class="container mt-5 mb-4 d-flex justify-content-center">
    <div class="card px-1 py-4">
        <div class="card-body">
            <h1 class="card-title mb-3 text-center">Update Subject</h1>
            <h6 class="information mt-4">Fill in the details to update subject</h6>
            <form action="../SubjectController?action=update" method="post">
                <h6 class="information mt-4">Subject code must be length of 3 and consist only UPPERCASE letters (ex: ABC)</h6>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="id">Subject Code</label>
                    </div>
                    <input type="hidden" name='currentID' value="<%=subjectList.get(0).getSubjectCode()%>"">
                    <input type="text" class="form-control" size='3' pattern="[A-Z]{3}" name='id' value="<%=subjectList.get(0).getSubjectCode()%>" required">
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="name">Subject Title</label>
                    </div>
                    <input type="text" class="form-control" id="name" name="name"  value="<%=subjectList.get(0).getSubjectTitle()%>" required>
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="duration">Subject Duration (Hours)</label>
                    </div>
                    <select  class="form-control" name="duration" id="duration"  value="<%=subjectList.get(0).getSubjectDuration()%>" required="required">
                        <%
                            //print the option value for a dropdown of duration
                            for(int i = 1; i < 5; i++) {
                                //if i equals to the duration of retrieved subjectList
                                if(i == subjectList.get(0).getSubjectDuration()) {
                                    //add selected to the option
                                    out.print("<option selected>" +  subjectList.get(0).getSubjectDuration() + "</option>");
                                } else {
                                    //else print the option without 'selected' tag
                                    out.print("<option>" +  i + "</option>");
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="day">Subject Day</label>
                    </div>
                    <select  class="form-control" name="day" id="day"  value="<%=subjectList.get(0).getSubjectDay()%>" required="required">
                        <%
                             //print the option value for a dropdown of day
                            for(int i = 0; i < 5; i++) {
                                //if day[i] equals to the day of retrieved subjectList
                                if(day[i].equals(subjectList.get(0).getSubjectDay())) {
                                    //mark the day as selected in the option
                                    out.print("<option selected>" +  subjectList.get(0).getSubjectDay() + "</option>");
                                } else {
                                    out.print("<option>" +  day[i] + "</option>");
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="teacher">Teacher In Charge</label>
                    </div>
                    <select  class="form-control" name="teacher" id="teacher" required="required">
                        <%
                            //print the option value for a dropdown of teacher
                            for(int i = 0; i < teacherList.size(); i++) {
                                //if teacherList.get(i) equals to the teacher in the retrieved subjectList
                                if(teacherList.get(i).getTeacherID().equals(subjectList.get(0).getTeacherID())) {
                                    //mark the teacher as selected in the option
                                    out.print("<option selected value='" + teacherList.get(i).getTeacherID() + "'>" +  teacherList.get(i).getTeacherName() + "</option>");
                                } else {
                                    out.print("<option value='" + teacherList.get(i).getTeacherID() + "'>" +  teacherList.get(i).getTeacherName() + "</option>");
                                }
                            }
                        %>
                    </select>
                </div>
            <br />
              <button type='submit'class="btn btn-primary btn-block confirm-button mt-2">Submit</button>
              <button type='reset' onclick="window.location.href='admin-manage-subjects.jsp';" class="btn btn-danger btn-block confirm-button">Cancel</button>
          </form> 
        </div>
    </div>
</div>                   
</body>
</html>

