<%-- 
    Document   : admin-manage-statistics
    Created on : 6 Jun 2022, 2:50:58 pm
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
<%@page import="dao.RegistrationDAO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="java.util.AbstractList"%>
<%@page import="model.Subject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="admin-navbar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin | Statistics</title>
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/highcharts-3d.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
        <style>        
          .card {
            background-color: #EAEEF1;  
          }
          
          #container {
            height: 400px;
          }

          .highcharts-figure,
          .highcharts-data-table table {
            min-width: 310px;
            max-width: 810px;
            margin: 1em auto;
          }

          .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
          }

          .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
          }

          .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
          }

          .highcharts-data-table td,
          .highcharts-data-table th,
          .highcharts-data-table caption {
            padding: 0.5em;
          }

          .highcharts-data-table thead tr,
          .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
          }

          .highcharts-data-table tr:hover {
            background: #f1f7ff;
          }
          
          #nav_statistics {
              font-weight: bold;
              color: white;
          }
        </style>
    </head>
    <body>
        <%
            List<Subject> subjectList = new ArrayList<>();
            subjectList = SubjectDAO.findAllSubjects();
            
            List<Teacher> teacherList = new ArrayList<>();
            teacherList = TeacherDAO.findAllTeachers();
        %>
        <div class="card">
            <figure class="highcharts-figure">
                <div id="container"></div>
                <p class="highcharts-description">
                    This graph shows the available subjects in the system. 
                    Hover the chart to see the number of registered students
                </p>
            </figure>
            <figure class="highcharts-figure">
                <div id="container-two"></div>
                <p class="highcharts-description">
                    This graph shows the available teachers in the system. 
                    Hover the chart to see the number of assigned subjects
                </p>
            </figure>
        </div>
        <script>
            Highcharts.chart('container', {
            chart: {
              type: 'pie',
              options3d: {
                enabled: true,
                alpha: 45
              }
            },
            title: {
              text: 'Registered Subjects'
            },
            plotOptions: {
              pie: {
                innerSize: 100,
                depth: 45
              }
            },
            series: [{
              name: 'Number of registered students',
              data: [
                  <%
                      for(int i = 0; i < subjectList.size(); i++) {
                        out.print("['" + subjectList.get(i).getSubjectTitle() + "'");
                        out.print(", " + RegistrationDAO.findRegisteredSubjects(subjectList.get(i).getSubjectCode()) + "]");
                        if(subjectList.size() > 1 && i != subjectList.size()-1) {
                            out.print(",");
                        }
                      }
                  %>
              ]
            }]
          });

          Highcharts.chart('container-two', {
            chart: {
              type: 'pie',
              options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
              }
            },
            title: {
              text: 'Registered teachers'
            },
            plotOptions: {
              pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                  enabled: true,
                  format: '{point.name}'
                }
              }
            },
            series: [{
              type: 'pie',
              name: 'Number of assigned subjects',
              data: [
                  <%
                      int result = 0;
                      int counter = 0;
                      for(int i = 0; i < teacherList.size(); i++) {
                        counter = SubjectDAO.findAllSubjectsByTeacherID(teacherList.get(i).getTeacherID()).size();
                        if(counter > result)
                            result = counter;
                      }
                      
                      for(int i = 0; i < teacherList.size(); i++) {
                        if(SubjectDAO.findAllSubjectsByTeacherID(teacherList.get(i).getTeacherID()).size() == result) {
                            out.print("{name:'" + teacherList.get(i).getTeacherName() + "'");
                            out.print(", y :" + result +", sliced : true}");
                        } else {
                            out.print("['" + teacherList.get(i).getTeacherName()+ "'");
                            out.print(", " + SubjectDAO.findAllSubjectsByTeacherID(teacherList.get(i).getTeacherID()).size() + "]");
                        }
                        if(teacherList.size() > 1 && i != teacherList.size()-1) {
                            out.print(",");
                        }
                      }
                  %>
              ]
            }]
          });
        </script>
    </body>
</html>
