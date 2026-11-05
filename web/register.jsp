<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>

    <link rel="stylesheet" href="css/register.css">
</head>

<body>

<div class="register-box">

    <h2>Student Registration</h2>

    <form action="RegisterServlet" method="post" onsubmit="return validateForm();">

        <input type="text"
               name="name"
               placeholder="Full Name"
               required>

        <input type="email"
               name="email"
               placeholder="Email Address"
               required>

        <input type="tel"
               name="mobile"
               placeholder="Mobile Number"
               pattern="[6-9][0-9]{9}"
               title="Enter a valid 10 digit mobile number"
               maxlength="10"
               required>

        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>

        <input type="text"
               name="course"
               value="MCA"
               readonly>

        <input type="password"
               id="password"
               name="password"
               placeholder="Password"
               minlength="8"
               required>

        <input type="password"
               id="confirmPassword"
               name="confirmPassword"
               placeholder="Confirm Password"
               minlength="8"
               required>

        <button type="submit">Register</button>

    </form>

    <br>

    <p style="text-align:center;">
        Already have an account?
        <a href="login.jsp">Login Here</a>
    </p>

</div>

<script>

function validateForm()
{
    var mobile = document.getElementsByName("mobile")[0].value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    if(!/^[6-9][0-9]{9}$/.test(mobile))
    {
        alert("Please enter a valid 10 digit mobile number.");
        return false;
    }

    if(password.length < 8)
    {
        alert("Password must be at least 8 characters.");
        return false;
    }

    if(password !== confirmPassword)
    {
        alert("Password and Confirm Password do not match.");
        return false;
    }

    return true;
}

</script>

</body>
</html>