<%-- 
    Document   : log-in
    Created on : 25 Apr 2022, 1:07:49 pm
Lecturer   : DR. ILY AMALINA BINTI AHMAD SABRI
Author     : GROUP 14(B)
1. MUHAMMAD HAIKAL AIMAN BIN MOHD PUAT
2. AJLAA AQILAH BINTI MOHD HAMDAN
3. NOR AMNI AFIFAH BINTI CHE OMAR
4. NURATIA AFIFAH BINTI HAMDAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <jsp:include page="bootstrap.jsp"/>
        <style>
            form {
                max-width: 480px;
                margin: auto;
                margin-top: 100px;
            }
            
            form img {
                width: 500px;
                height: 300px;
            }
            
            body {
                background-color: #EAEEF1;
            }
        </style>
    </head>
    <body>
        <span>
            <div class="text-center mt-5">
                <form action="../StudentController" method="post">
<!--                <img class="mt-4 mb-4 img-responsive" src="https://upload.wikimedia.org/wikipedia/commons/3/3e/Logo_Rasmi_UMT.png" alt="UMT Logo">-->
                    <img class="mt-4 mb-1 img-responsive" src="../images/logo.png" alt=" Logo"> 
                    <h1 class="h3 mb-3 font-weight-normal">School Management System</h1>

                    <label for="txtID" class="sr-only">ID</label>
                    <input type="text" name="txtID" class="form-control" placeholder="ID" required autofocus />

                    <label for="password" class="sr-only">Password</label>
                    <input type="password" name="txtPassword" placeholder="Password" class="form-control" required autofocus/>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <label class="input-group-text text-dark" for="inputGroupSelect01">Role</label>
                        </div>
                        <select name="role" class="custom-select" id="inputSelectRole">
                            <option value="student" selected="">Student</option>
                            <option value="teacher">Teacher</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                        <div class="mt-3">
                            <button class="btn btn-lg btn-primary btn-block" name="action" value="login">
                                    Sign In
                            </button>
                        </div>
                </form>
            </div>
        </span>
    </body>
</html>
