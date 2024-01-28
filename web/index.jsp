<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sample Testing Management System</title>
        <style>
            .flex-body {
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
            }
        </style>
    </head>
    <body>       
    <head>

        <!----======== CSS ======== -->
        <link rel="stylesheet" href="style.css">

        <!----===== Iconscout CSS ===== -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

        <!--<title>Responsive Regisration Form </title>--> 
    <div class="container">
        <header>Application Form For Sample Testing</header>

        <form action="#">
            <div class="form first">
                <div class="details personal">
                    <span class="title">Applicant's Details</span>

                    <div class="fields">
                        <div class="input-field">
                            <label>Name</label>
                            <input type="text" required>
                        </div>

                        <div class="input-field">
                            <label>Address Organization</label>
                            <input type="text" required>
                        </div>

                        <div class="input-field">
                            <label>Email</label>
                            <input type="text" required>
                        </div>

                        <div class="input-field">
                            <label>Phone Number</label>
                            <input type="number" required>
                        </div>

                        <div class="input-field">
                            <label>Office Number</label>
                            <input type="number" required>
                        </div>    

                        <div class="input-field" style="visibility: hidden">
                            <label>Office Number</label>
                            <input type="number" required>
                        </div> 
                    </div>
                </div>
                <span class="title">Testing Details</span>
                <div class="details ID flex-body">
                    
                    
                    <div class="input-field">
                        <label style="margin-right: 20px;">Testing Type</label>
                        <select required>
                            <option disabled selected>Choose your testing type</option>
                            <option disabled selected>Accredited</option>
                            <option>TS - APHA 2540 B (2005)</option>
                            <option>TDS - APHA 2540 C (2005)</option>
                            <option>TSS - APHA 2540 D (2005)</option>
                            <option>Not Accredited</option>
                        </select>
                    </div>                       

                    <div class="input-field">
                        <label>Sample ID</label>
                        <input type="text" required>
                    </div>
                    <div class="input-field">
                        <label style="margin-right: 40px;">Rate(RM)</label>
                        <input type="number" required>
                    </div>

                    <div class="input-field">
                        <label>Total(RM)</label>
                        <input type="text"  required>
                    </div>

                    <div class="input-field">
                        <label style="margin-right: 5px;">Total Price(RM)</label>
                        <input type="text"  required>
                    </div>

                    <button class="nextBtn">
                        <span class="btnText">Next</span>
                        <i class="uil uil-navigator"></i>
                    </button>
                </div> 
            </div>

            <div class="form second">
                <div class="details address">
                    <span class="title">Sample Details</span>

                    <div class="fields">
                        <div class="input-field">
                            <label>Sampling Date</label>
                            <input type="date"  required>
                        </div>

                        <div class="input-field">
                            <label>Sampling Date</label>
                            <input type="time"  required>
                        </div>

                        <div class="input-field">
                            <label>Type of Storage Sample</label>
                            <input type="text" placeholder="Enter your state" required>
                        </div>

                        <div class="input-field">
                            <label>Type of Sample</label>
                            <input type="text"  required>
                        </div>

                        <div class="input-field">
                            <label>Applicant's Signature</label>
                            <input type="text" required>
                        </div>

                        <div class="input-field">
                            <label>Date</label>
                            <input type="date" required>
                        </div>
                    </div>
                </div>

                <div class="buttons">
                    <div class="backBtn">
                        <i class="uil uil-navigator"></i>
                        <span class="btnText">Back</span>
                    </div>

                    <button class="sumbit">
                        <span class="btnText">Submit</span>
                        <i class="uil uil-navigator"></i>
                    </button>
                </div>
            </div> 
    </div>
</form>
</div>

<!--<script src="script.js"></script>-->

</head> 
</body> 
</html>