<%-- 
    Document   : process-add-subject
    Created on : 1 Jun 2022, 12:14:25 pm
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
        <title>Admin | Add Subject</title>
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
            teacherList = TeacherDAO.findAllTeachers();
        %>
        <div class="container mt-5 mb-4 d-flex justify-content-center">
            <div class="card px-1 py-4">
                <div class="card-body">
                    <h1 class="card-title mb-3 text-center">Add Subject</h1>
                    <h6 class="information mt-4">Fill in the details to add subject</h6>
                    <form action="../SubjectController?action=register" method="post">
                        <h6 class="information mt-4">Subject code must be length of 3 and consist only UPPERCASE letters (ex: ABC)</h6>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="id">Subject Code</label>
                            </div>
                            <input type="text" class="form-control" size='3' pattern="[A-Z]{3}" placeholder='(ex: ABC)' required name="id"">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="name">Subject Title</label>
                            </div>
                            <input type="text" class="form-control" id="name" name="name" required value="">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="duration">Subject Duration (Hours)</label>
                            </div>
                            <select  class="form-control" name="duration" id="duration" required="required">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="day">Subject Day</label>
                            </div>
                            <select class="form-control" name="day" id="day" required="required">
                                <option>Monday</option>
                                <option>Tuesday</option>
                                <option>Wednesday</option>
                                <option>Thursday</option>
                                <option>Friday</option>
                            </select>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="teacher">Teacher In Charge</label>
                            </div>
                            <select  class="form-control" name="teacher" id="teacher" required="required">
                                <%
                                    for (int i = 0; i < teacherList.size(); i++) {
                                        out.print("<option value='" + teacherList.get(i).getTeacherID() + "'>" + teacherList.get(i).getTeacherName() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <br />
                        <button type='submit'class="btn btn-primary btn-block confirm-button mt-2">Submit</button>
                        <button type='reset' onclick="window.location.href = 'admin-manage-subjects.jsp';" class="btn btn-danger btn-block confirm-button">Cancel</button>
                    </form> 
                </div>
            </div>
        </div>

    </body>
</html>


