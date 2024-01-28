<%-- 
    Document   : process-update-teacher
    Created on : 1 Jun 2022, 10:44:25 am
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page import="dao.TeacherDAO"%>
<%@page import="model.Teacher"%>
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
  <title>Admin | Add Teacher</title>
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
            
        input[readonly] {
           background-color: red;
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
                       
            #nav_teacher {
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
    String id = request.getParameter("id");
    Teacher teacher = TeacherDAO.findTeacherByTeacherId(id);
  %>
  <div class="container mt-5 mb-5 d-flex justify-content-center">
    <div class="card px-1 py-4">
        <div class="card-body">
            <h1 class="card-title mb-3 text-center">Edit Teacher</h1>
            <h6 class="information mt-4">Fill in the details to update teacher</h6>
            <form action="../TeacherController?action=update" method="post">
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="id">Teacher ID</label>
                    </div>
                    <input type="text" class="form-control" readonly id="ticketID" readonly placeholder="<%=teacher.getTeacherID()%>">
                    <input type="hidden" class="form-control"  name="id" value="<%=teacher.getTeacherID()%>">
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="id">Teacher Name</label>
                    </div>
                    <input type="text" class="form-control" id="name" name="name" value="<%=teacher.getTeacherName()%>">
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="password">Teacher Password</label>
                    </div>
                    <input type="password" class="form-control" id="password" name="password" value="<%=teacher.getTeacherPassword()%>">
                </div>
                <div class="input-group mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text text-dark" for="gender">Teacher Email</label>
                    </div>
                    <input type="email" class="form-control" id="email" name="email" value="<%=teacher.getTeacherEmail()%>">
                </div>
            <br />
              <button type='submit'class="btn btn-primary btn-block confirm-button">Submit</button>
              <button type='reset' onclick="window.location.href='admin-manage-teachers.jsp';" class="btn btn-danger btn-block confirm-button">Cancel</button>
          </form> 
        </div>
    </div>
</div>
</body>
</html>
