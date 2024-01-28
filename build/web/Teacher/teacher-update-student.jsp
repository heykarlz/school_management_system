<%-- 
    Document   : teacher-update-student
    Created on : 16 Jun 2022, 10:19:06 pm
    Author     : Muhammad Haikal Aiman Bin Mohd Puat S59419
--%>

<%-- 
    Document   : process-add-student
    Created on : 31 May 2022, 11:42:40 pm
    Project    : SCHOOL REGISTRATION SYSTEM @ CSE3209
    Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
    Author     : GROUP 14(B)

1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>
<%@page import="model.Student"%>
<%@page import="dao.StudentDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="teacher-navbar.jsp"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <title>Teacher | Update Student</title>
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

            #nav_students {
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
            Student student = StudentDAO.findStudentById(id);
        %>
        <div class="container mt-5 mb-4 d-flex justify-content-center">
            <div class="card px-1 py-4">
                <div class="card-body">
                    <h1 class="card-title mb-3 text-center">Edit Student</h1>
                    <h6 class="information mt-4">Fill in the details to update student</h6>
                    <form action="../StudentController?action=update&user=teacher" method="post">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="id">Student ID</label>
                            </div>
                            <input type="text" class="form-control" readonly id="ticketID" readonly placeholder="<%=student.getStudentID()%>">
                            <input type="hidden" class="form-control"  name="id" value="<%=student.getStudentID()%>">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="id">Student Name</label>
                            </div>
                            <input type="text" class="form-control" id="name" name="name" value="<%=student.getStudentName()%>">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="gender">Gender</label>
                            </div>
                            <select id="gender" class="form-control" name="gender" value="<%=student.getGender()%>" required="required">
                                <%
                                    if (student.getGender().equals("Male")) {
                                        out.print("<option selected>Male</option>");
                                    } else {
                                        out.print("<option>Male</option>");
                                    }

                                    if (student.getGender().equals("Female")) {
                                        out.print("<option selected>Female</option>");
                                    } else {
                                        out.print("<option>Female</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="phoneNumber">Guardian Phone Number</label>
                            </div>
                            <input type="tel" class="form-control" name="phoneNumber" value="<%=student.getGuardianNum()%>">
                        </div>
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <label class="input-group-text text-dark" for="classroom">Classroom</label>
                            </div>
                            <select id="classroom" class="form-control" name="classroom" value="<%=student.getClassID()%>" required="required">
                                <%
                                    switch (student.getClassID()) {
                                        case 1:
                                            out.print("<option value='1' selected>Cemerlang</option>");
                                            break;
                                        case 2:
                                            out.print("<option value='2' selected>Terbilang</option>");
                                            break;
                                        case 3:
                                            out.print("<option value='3' selected>Gemilang</option>");
                                            break;
                                        case 4:
                                            out.print("<option value='4' selected>Patriotik</option>");
                                            break;
                                    }

                                    switch (student.getClassID()) {
                                        case 1:
                                            out.print("<option value='1'>Cemerlang</option>");
                                            out.print("<option value='2'>Terbilang</option>");
                                            out.print("<option value='3'>Gemilang</option>");
                                            out.print("<option value='4'>Patriotik</option>");
                                            break;
                                        case 2:
                                            out.print("<option value='1'>Cemerlang</option>");
                                            out.print("<option value='3'>Gemilang</option>");
                                            out.print("<option value='4'>Patriotik</option>");
                                            break;
                                        case 3:
                                            out.print("<option value='1'>Cemerlang</option>");
                                            out.print("<option value='2'>Terbilang</option>");
                                            out.print("<option value='4'>Patriotik</option>");
                                            break;
                                        case 4:
                                            out.print("<option value='1'>Cemerlang</option>");
                                            out.print("<option value='2'>Terbilang</option>");
                                            out.print("<option value='3'>Gemilang</option>");
                                            break;
                                    }
                                %>
                            </select>
                        </div>
                        <br />
                        <button type='submit'class="btn btn-primary btn-block confirm-button">Submit</button>
                        <button type='reset' onclick="window.location.href = 'teacher-manage-students.jsp';" class="btn btn-danger btn-block confirm-button">Cancel</button>
                    </form> 
                </div>
            </div>
        </div>
    </body>
</html>

