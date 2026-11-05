<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>

    <link rel="stylesheet" href="adminLogin.css">

    <script>
        window.onload = function() {

            const urlParams = new URLSearchParams(window.location.search);

            if (urlParams.get("error") === "1") {

                alert("Enter correct email ID or password.");

                // Remove error=1 from URL
                window.history.replaceState(
                    {},
                    document.title,
                    "adminLogin.jsp"
                );
            }
        };
    </script>

</head>

<body>

<div class="login-box">

    <h2>Admin Login</h2>

    <form action="AdminLoginServlet" method="post">

        <label>Email ID / Username</label>
        <input type="text" name="username" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <input type="submit" value="Login">

    </form>

</div>

</body>
</html>