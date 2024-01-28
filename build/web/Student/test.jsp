<%-- 
    Document   : test
    Created on : 10 Nov 2023, 11:46:55 am
    Author     : Muhammad Haikal Aiman Bin Mohd Puat S59419
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            th, td {
                text-align: center;
                border: 1px solid black;
            }
        </style>
    </head>
    <body>
        <table>
            <tr>
                <th>Matric Number</th>
                <th>Name</th>
                <th>Programme</th>
                <th>Project Title</th>
                <th>Progress Evaluation</th> 
            </tr>

            <tr>
                <%
                    for(int x=0; x < 3; x++) {
                        out.print("<td rowspan='" + x + "'>123</td>");
                    }
                %>
                <td rowspan="4">123</td>
                <td rowspan="4">sky</td>
                <td rowspan="4">Student at school</td>
                <td rowspan="4">How to add multiple rows in a column on a table using HTML?</td>
                <td>mutiple</td>
            </tr>

            <tr>
                <td>rows</td>
            </tr>

            <tr>
                <td>in</td>
            </tr>

            <tr>
                <td>here</td>
            </tr>
        </table>
    </body>
</html>
